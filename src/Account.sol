// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleAccount {
    bytes32 constant STORAGE_SLOT = keccak256("diamond.storage.routing");

    struct DS {
        mapping(bytes4 => address) selectorToPlugin;
    }

    function getAccountStorage() internal pure returns (DS storage _as) {
        bytes32 slot = STORAGE_SLOT;
        assembly { _as.slot := slot }
    }

    function installPlugin(address _plugin, bytes4[] memory _selectors) external {
        DS storage ds = getAccountStorage();
        for (uint256 i = 0; i < _selectors.length; i++) {
            ds.selectorToPlugin[_selectors[i]] = _plugin;
        }
    }

    fallback() external payable {
        // A. Find which plugin handles this function
        address plugin = getAccountStorage().selectorToPlugin[msg.sig];
        require(plugin != address(0), "Function not found");

        // B. Execute the logic using DelegateCall
        assembly {
            // Copy the function call data
            calldatacopy(0, 0, calldatasize())

            // Call the plugin.
            // result: 1 = success, 0 = failure
            let result := delegatecall(gas(), plugin, 0, calldatasize(), 0, 0)

            // Copy the return data
            returndatacopy(0, 0, returndatasize())

            // Return result or revert changes
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    receive() external payable {}
}

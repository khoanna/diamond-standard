// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Storage {
    bytes32 constant STRUCT_SLOT = keccak256("storage.slot");

    struct WalletStorage {
        string name;
        string symbol;
        uint256 totalSupply;
        mapping(address => uint256) balances;
    }

    function _getStorage() internal pure returns (WalletStorage storage ws) {
        bytes32 slot = STRUCT_SLOT;
        assembly {
            ws.slot := slot
        }
    }

    function setName(string memory newName) public {
        WalletStorage storage ws = _getStorage();
        ws.name = newName;
    }

    function getName() public view returns (string memory) {
        WalletStorage storage ws = _getStorage();
        return ws.name;
    }
}

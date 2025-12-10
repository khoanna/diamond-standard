// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library CounterStorage {
    bytes32 constant STRUCT_SLOT = keccak256("counter.storage.slot");

    struct Counter {
        uint256 count;
    }

    function _getStorage() internal pure returns (Counter storage ws) {
        bytes32 slot = STRUCT_SLOT;
        assembly {
            ws.slot := slot
        }
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CounterStorage} from "./Storage.sol";

contract CounterPlugin {
    function increment() public {
        CounterStorage.Counter storage cs = CounterStorage._getStorage();
        cs.count += 1;
    }

    function getCount() public view returns (uint256) {
        CounterStorage.Counter storage cs = CounterStorage._getStorage();
        return cs.count;
    }
}

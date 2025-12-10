// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CounterPlugin} from "../src/plugin/Plugin.sol";
import {SimpleAccount} from "../src/Account.sol";

contract StorageTest is Test {
    CounterPlugin public counterPlugin;
    SimpleAccount public accountContract;

    function setUp() public {
        counterPlugin = new CounterPlugin();
        accountContract = new SimpleAccount();
    }

    function testCounterPluginViaAccount() public {
        // Install the CounterPlugin into the Account contract
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = CounterPlugin.increment.selector;
        selectors[1] = CounterPlugin.getCount.selector;

        accountContract.installPlugin(address(counterPlugin), selectors);

        // Call increment() via the Account contract
        (bool incrementSuccess,) =
            address(accountContract).call(abi.encodeWithSelector(CounterPlugin.increment.selector));
        require(incrementSuccess, "Increment call failed");

        // Call getCount() via the Account contract
        (bool getCountSuccess, bytes memory returnData) =
            address(accountContract).call(abi.encodeWithSelector(CounterPlugin.getCount.selector));
        require(getCountSuccess, "getCount call failed");

        // Decode the returned count
        uint256 count = abi.decode(returnData, (uint256));
        assertEq(count, 1, "Count should be 1 after one increment");
    }
}

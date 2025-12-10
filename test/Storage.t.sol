// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Storage} from "../src/Storage.sol";

contract StorageTest is Test {
    Storage public storageContract;

    function setUp() public {
        storageContract = new Storage();
        storageContract.setName("Test");
    }

    function test_GetName() public {
        string memory name = storageContract.getName();
        assertEq(name, "Test");
    }
}

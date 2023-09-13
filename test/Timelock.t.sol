// SPDX-License-Identifier: UNLICENSED
pragma abicoder v2;
pragma solidity 0.8.19;


import "forge-std/Test.sol";
import "../src/Timelock.sol";

contract TimelockTest is Test {
    Timelock public timelock;

    function setUp() public {
        timelock = new Timelock();
    }
}
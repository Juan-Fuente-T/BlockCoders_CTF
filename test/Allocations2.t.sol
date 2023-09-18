// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;


import "lib/forge-std/src/Test.sol";
import "../src/Allocations.sol";
import "../src/TakeAllocations.sol";

contract AllocationsTest is Test {
    Allocations public allocations;
    TakeAllocations public attackAllocations;
    address alice;

    function setUp() public {
        allocations = new Allocations();
        attackAllocations = new TakeAllocations(address(allocations));
        alice = makeAddr("alice");
    }
    function testAllocations2 () public payable{
        vm.startPrank(alice);
        vm.deal(alice, 1*1e18);

        console.log("alice",alice.balance);

        allocations.allocate{value: 1*1e18}();

        console.log("alice",alice.balance);

        (bool success, ) = address(attackAllocations).call{value: 0}(abi.encodeWithSignature("attack()"));
      
        allocations.collectAllocations();

        assertEq(alice.balance, 1e18);
        
        console.log("alice",alice.balance);
    }
}
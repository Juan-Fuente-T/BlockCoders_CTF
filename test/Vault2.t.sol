// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;
pragma abicoder v2;

import "lib/forge-std/src/Test.sol";
import "../src/Vault2.sol";
import "../src/AttackerSelfdestruct.sol";

contract Vault2Test is Test {
   
    Vault2 public vault2;
    AttackerSelfdestruct atacker;
    address public Juan;

    //constructor() AttackerSelfdestruct(vault2) public {}
    
    function setUp() public {
        vault2 = new Vault2{value: 0.0001 ether}();
        //atacker = new AttackerSelfdestruct{value: 0.0001 ether}(address(vault2));
        atacker = new AttackerSelfdestruct(address(vault2));
        Juan = makeAddr("Juan");
    }
    function testVault2() public {
        vm.startPrank(Juan);
        vm.deal(Juan, 0.0001 ether);
        console.log("Balance Juan: ", Juan.balance);
        (bool sent, ) = address(atacker).call{value: 0.0001 ether}(abi.encodeWithSignature("attack()"));
        require(sent, "Error en el call");
        console.log("Balance atacker: ",address(atacker).balance);
        console.log("Balance Juan: ", Juan.balance);
        atacker.attack();
        console.log("Balance Vault2: ", address(vault2).balance);
        console.log("Balance atacker: ",address(atacker).balance);
        vault2.recoverFunds();
        //payable(address(vault2)).call{value: 0.0001 ether}("");
        //selfdestruct(Juan);
        assertEq(Juan.balance, 0.0002 ether);
        console.log("Balance Juan: ", Juan.balance);
        console.log("Balance Vault2: ", address(vault2).balance);
        
    }
}



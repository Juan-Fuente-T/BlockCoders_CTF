// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "lib/forge-std/src/Test.sol";
import "../src/Vault2.sol";

contract Vault2Test is Test {
    Vault2 public vault;
    address public Juan;

    function setUp() public {
        vault = new Vault2{value: 0.0001 ether}();
        Juan = makeAddr("Juan");
    }

    function testVault2() public {
        vm.startPrank(Juan);
        console.log("Balance Vault: ", address(vault).balance);

        //(bool sent, ) = payable(address(vault)).call{value:0.0001 ether}("");
        //require(sent, "Error en el call");

        //console.log("Balance Vault despues: ",address(vault).balance);
        console.log("Balance Juan: ", Juan.balance);

        address payable addr = payable(address(vault));
        //payable(address(vault)).call{value: 0.0001 ether}("");

        selfdestruct(addr);
        
        assertEq(Juan.balance, 0.001 ether);
        console.log("Balance Juan: ", Juan.balance);
        console.log("Balance Vault: ", address(vault).balance);
        
    }
}


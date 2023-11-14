// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;


import "lib/forge-std/src/Test.sol";
import "../src/Cerrojo.sol";
import "lib/forge-std/src/console.sol";
contract CerrojoTest is Test {
    Cerrojo public cerrojo;
    address Juan;

    function setUp() public {
        cerrojo = new Cerrojo();
        Juan = makeAddr("Juan");
    }

    function testCerrojo() public{
        //bytes2 target = 0x6942;
        // Luego, convierte target a bytes8, llenando con ceros a la derecha
        //bytes8 num = bytes8(target);
        //bytes16 message = bytes16(num);
        //console.logBytes16(message);

        vm.startPrank(Juan, Juan);
        vm.deal(Juan, 33);
        console.log("Balance Juan Inicio: ", Juan.balance);

        cerrojo.pick1(420);
        
       
        (bool success, ) = address(cerrojo).call{value: 33}(abi.encodeWithSignature("pick2()"));
                         
        cerrojo.pick3(bytes16(hex"6942000000000000"));

        cerrojo.recoverFunds();
        
        assertEq(Juan.balance, 33);
        console.log("Balance Juan Superado Cerrojo: ", Juan.balance);
    }

}

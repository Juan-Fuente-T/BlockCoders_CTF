// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.11;
 
contract Counter1 {
    uint256 public number;
 
    function increment() public {
        number++;
    }
}
 
contract Counter2 {
    uint256 public number;
 
    function increment() public {
        number = number + 2;
    }
}
 
contract Proxy {
    address implementation;
 
    address owner;
 
    event OwnerChanged(address oldOwner, address newOwner);
    event ImplementationChanged(address oldImplementation, address newImplementation);
    error NoInicializado();
    error NotOwner();
    error DelegateError();
 
 
    
 
    
 
   
 
    receive() external payable {
        _delegate();
    }
 
    fallback() external payable {
        _delegate();
    }
 
    function _delegate() internal {
        if(implementation == address(0)) {
            revert NoInicializado();
        }
 
        (bool success, ) = implementation.delegatecall(msg.data);
        if(!success) {
            revert DelegateError();
        }
    }
}
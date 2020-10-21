//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;


import './Accounts.sol';
contract BorrowerContract {
    
    address public AccountsContract;
   
    
    struct Borrower{
        address borrower_public_key;
        string[] circles;
        address[] defaultAddress;
    }
    
    mapping(address => Borrower) public BorrowerCircle;
    
    function setAccountContract(address Caddr) public {
        AccountsContract = Caddr;
    }
    function createBorrower() public {
        BorrowerCircle[msg.sender].borrower_public_key = msg.sender;
    }
    function createCircle(string memory name) public {
        
        BorrowerCircle[msg.sender].circles.push(name);
        BorrowerCircle[msg.sender].defaultAddress.push(address(uint160(uint(keccak256(abi.encodePacked(block.timestamp))))));
       
    }
    
    function getdefaultAddress(uint index) public view returns(address) {
        return BorrowerCircle[msg.sender].defaultAddress[index];
    }
    
    function initiatecircleLimit(uint index,uint circleLimit) public
    {
     //BorrowerCircle[msg.sender].circles[index]
     address getter = BorrowerCircle[msg.sender].defaultAddress[index];
     Accounts acc = Accounts(AccountsContract);
     acc.transfer(msg.sender,getter,circleLimit);
    }
    
}

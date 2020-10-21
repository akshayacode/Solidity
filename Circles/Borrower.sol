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
    
    mapping(uint => Borrower) public BorrowerCircle;
    
    function setAccountContract(address Caddr) public {
        AccountsContract = Caddr;
    }
    
    function createCircle(string memory name,uint index) public {
        BorrowerCircle[index].borrower_public_key = msg.sender;
        BorrowerCircle[index].circles.push(name);
        BorrowerCircle[index].defaultAddress.push(address(uint160(uint(keccak256(abi.encodePacked(block.timestamp))))));
       
    }
    
    function getdefaultAddress(uint index) public view returns(address[] memory) {
        return BorrowerCircle[index].defaultAddress;
    }
}

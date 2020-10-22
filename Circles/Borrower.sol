//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;

import './Accounts.sol';
contract CirclesContract {
    
    address public AccountsContract;
    struct Circle{
        string name;
        address manager;
        address locker;
        address[] participants;
        uint circleLimit;
    }
    
    struct Borrower{
        address borrower;
        mapping(uint => Circle) circles;
    }
    
    mapping(address => Borrower) public borrwers;
    
    function setAccountsContract(address addr) public {
        AccountsContract = addr;
    }
    
    function createCircle(uint id,string memory name,uint circleLimit) public{
        borrwers[msg.sender].borrower = msg.sender;
        borrwers[msg.sender].circles[id].name= name;
        borrwers[msg.sender].circles[id].circleLimit = circleLimit;
        borrwers[msg.sender].circles[id].manager = msg.sender;
        borrwers[msg.sender].circles[id].locker = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,borrwers[msg.sender].circles[id].locker ,circleLimit);
        
    }
    
    
    function viewCircle(address addr,uint id) public view returns(string memory,address,address[] memory,uint) {
        return(borrwers[addr].circles[id].name,borrwers[msg.sender].circles[id].manager,borrwers[msg.sender].circles[id].participants,borrwers[msg.sender].circles[id].circleLimit);
    }
    
    function joincircle(address addr,uint id) public {
        borrwers[addr].circles[id].participants.push(msg.sender);
    }
    
}

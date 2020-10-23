//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;

import './Accounts.sol';
contract CirclesContract {
    
    address public AccountsContract;
    struct Circle{
        string name;
        address manager;
        address borrower;
        address locker;
        address[] participants;
        uint circleLimit;
      mapping (address => participantsteams) participantslist;
        
    }
     mapping (address => participantsteams) public participantslist;
     
        
    
    struct participantsteams{
        uint id;
        address participantsno;
        bool agree;
    }
    
    
    struct Borrower{
        address borrower;
        mapping(uint => Circle) circles;
    }
    
    mapping(address => Borrower) public borrwers;
    
    enum Status{
        Created,
        Progress,
        Shortlisted,
        Accepted
    }
    struct LoanApplication {
        //uint id;
        uint duration;
        uint interest_rate;
        uint credit_amount;
        uint total_circle_limit;
        //uint available_limit;
        uint EMI;
        Status status;
        
    }
    mapping(uint => LoanApplication) public applications;
    uint numapplications;
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
    
    
    function viewCircle(address addr,uint id) public view returns(string memory,address,address[] memory,uint, address) {
        return(borrwers[addr].circles[id].name,
               borrwers[addr].circles[id].manager,
               borrwers[addr].circles[id].participants,
               borrwers[addr].circles[id].circleLimit,
               borrwers[addr].circles[id].participantslist[addr].participantsno);
    }
    
    function joincircle(address addr,uint id) public {
        Accounts acc = Accounts(AccountsContract);
        
        acc.transfer(msg.sender,borrwers[addr].circles[id].locker,borrwers[addr].circles[id].circleLimit);
        borrwers[addr].circles[id].participants.push(msg.sender);
      
         uint a = borrwers[addr].circles[id].participants.length;
        borrwers[addr].circles[id].participantslist[msg.sender].id = a + 1;
        borrwers[addr].circles[id].participantslist[msg.sender].participantsno = msg.sender;
        borrwers[addr].circles[id].participantslist[msg.sender].agree = false;
        
    }
    function getdata(address addr, uint id) public payable{
      
        
        for (uint m = 0; m <  borrwers[addr].circles[id].participants.length; m++) {
             borrwers[msg.sender].circles[id].participants[m];
             
        }

        
    }
    
    function getcirclelength(address addr, uint id) public view returns(uint){
        
      return borrwers[addr].circles[id].participants.length;
    }
    
    function CreateApplication(uint duration,uint interest_rate,uint credit_amount,uint total_circle_limit,uint EMI) public {
        applications[numapplications] = LoanApplication(duration,interest_rate,credit_amount,total_circle_limit,EMI,Status.Created);
    }
    
    function viewApplication(uint id) public view returns(uint,uint,uint,uint,uint,Status)
    {
        return (applications[id].duration,
                applications[id].interest_rate,
                applications[id].credit_amount,
                applications[id].total_circle_limit,
                applications[id].EMI,
                applications[id].status);
        
        //return applications[id]; (not working)
    }
    
    function agreeForLoan(uint id) public {
        
    }
    
    
    function checkagree(address addr) public view returns(uint, address, bool){
        
       return (participantslist[addr].id, participantslist[addr].participantsno, participantslist[addr].agree);
    
        
    }
    
    function ifAgreed(address addr, uint id) public {
          
          borrwers[addr].circles[id].participantslist[msg.sender].agree = true;
          
    }
}

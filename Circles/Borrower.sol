//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;

import './Accounts.sol';
   enum Status{
        Created,
        Progress,
        Shortlisted,
        Approved
    }
contract CirclesContract {
    
    address public AccountsContract;
    struct Circle{
        string name;
        address manager;
        address borrower;
        address locker;
        address[] participants;
        uint circleLimit;
        
    }
    
    struct Borrower{
        address borrower;
        mapping(uint => Circle) circles;
    }
    
    mapping(address => Borrower) public borrwers;
    
 
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
    
    
    function viewCircle(address addr,uint id) public view returns(string memory,address,address[] memory,uint) {
        return(borrwers[addr].circles[id].name,
               borrwers[msg.sender].circles[id].manager,
               borrwers[msg.sender].circles[id].participants,
               borrwers[msg.sender].circles[id].circleLimit);
    }
    
    function joincircle(address addr,uint id) public {
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,borrwers[addr].circles[id].locker,borrwers[addr].circles[id].circleLimit);
        borrwers[addr].circles[id].participants.push(msg.sender);
    }
    
    function CreateApplication(uint duration,uint interest_rate,uint credit_amount,uint total_circle_limit,uint EMI) public {
        applications[numapplications] = LoanApplication(duration,interest_rate,credit_amount,total_circle_limit,EMI,Status.Created);
    }
    
    function viewApplication(uint id) public view returns(uint,uint,uint,uint,uint)
    {
        return (applications[id].duration,
                applications[id].interest_rate,
                applications[id].credit_amount,
                applications[id].total_circle_limit,
                applications[id].EMI
                //applications[id].status
                );
        
        //return applications[id]; (not working)
    }
    
    function getCreditAmount(uint id) public view returns(uint){
        return applications[id].credit_amount;
    }
    
    function getlocker(address addr,uint id) public view returns (address) {
        return borrwers[addr].circles[id].locker;
    }
    
    function agreeForLoan(address addr,uint id) public {
        // code 
       
        
    }
    
    function changestatusApproved(uint id) public {
        applications[id].status = Status.Approved;
    }
    function changestatusShortlisted(uint id) public {
        applications[id].status = Status.Shortlisted;
    }
    
    function ifAgreed(uint id) public {
        //code if 80 % of participants agreed for loan
        applications[id].status = Status.Progress;
    }
    
      
    

}

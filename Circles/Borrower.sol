//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;


import './Accounts.sol';
contract BorrowerContract {
    
    address public AccountsContract;
   
    enum Status{
        Created,
        progress,
        Shortlisted,
        Approved
    }
    struct Borrower{
        address borrower_public_key;
        string[] circles;
        address[] defaultAddress;
    }
    
    mapping(address => Borrower) public BorrowerCircle;
    
    struct Circle{
        address locker;
        address[] circleMembers;
        uint circleLimit;
    }
    
    mapping(uint => Circle) public circle;
    
    struct LoanApplication{
        //For traversal and indexing
        bool openApp;
        uint applicationId;

        //address borrower;
        uint duration; // In months
        uint credit_amount; // Loan amount
        uint interest_rate; //From form
        //string otherData;// Encoded string with delimiters (~)
        uint circleLimit;
        Status status;
        //address[] borrowercircle;
        //address defaultAddress;


    }
    
    mapping(address => bool) hasOngoingLoan;
    mapping(address => bool) hasOngoingApplication;
    mapping (uint => LoanApplication) public applications;
    uint numApplications;
    
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
     circle[index].locker = BorrowerCircle[msg.sender].defaultAddress[index];
     circle[index].circleLimit = circleLimit;
     Accounts acc = Accounts(AccountsContract);
     acc.transfer(msg.sender,getter,circleLimit);
    }
    
    function JoinCircle(uint index) public {
        circle[index].circleMembers.push(msg.sender);
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,circle[index].locker,circle[index].circleLimit);
        
    }
    
    function initiateApplication(uint duration,uint interest_rate,uint credit_amount,uint circleLimit,uint EMI) public {
        applications[numApplications] = LoanApplication(true,duration,interest_rate,credit_amount,circleLimit,EMI,Status.Created);    
    }
    
    // function viewInitailApp(uint index) public view returns (bool,uint,uint,uint,uint,Status){
        
    //     applications[index].circleLimit;
    // }
    
    function agree(uint index) public  {
       applications[index].status = Status.progress;
    }
}

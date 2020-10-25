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
        //address[] participants;
        uint circleLimit;
        address investor;
        mapping(address => participants) partcipantList;
        
    }
    struct participants{
        address circleMember;
        bool agree;
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
    
    mapping(address => bool) hasOngoingLoan;
    mapping(address => bool) hasOngoingApplication;
    
    struct Loan{
        bool openLoan;
        uint loanId;
        address borrower;
        address investor;
        uint interest_rate;
        uint duration;
        uint principal_amount;
        uint original_amount;
        uint amount_paid;
        uint startTime;
        uint monthlyCheckpoint;
        uint appId;

    }
    mapping(uint => Loan) public loans;
    uint numLoans;
    
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
    
    
    // function viewCircle(address addr,uint id) public view returns(string memory,address,address[] memory,uint) {
    //     return(borrwers[addr].circles[id].name,
    //           borrwers[msg.sender].circles[id].manager,
    //           borrwers[msg.sender].circles[id].partcipantList[],
    //           borrwers[msg.sender].circles[id].circleLimit);
    // }
    
    function joincircle(address addr,uint id) public {
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,borrwers[addr].circles[id].locker,borrwers[addr].circles[id].circleLimit);
        //borrwers[addr].circles[id].participants.push(msg.sender);
        borrwers[addr].circles[id].partcipantList[msg.sender].circleMember = msg.sender;
    }
    
    function CreateApplication(address addr,uint id,uint duration,uint interest_rate,uint credit_amount,uint total_circle_limit,uint EMI) public {
        borrwers[addr].circles[id].borrower = msg.sender;
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
    
    function changeCircleLimit(address addr,uint id,uint credit_Limit) public {
        borrwers[addr].circles[id].circleLimit = credit_Limit;
    }
    
    function getCreditAmount(uint id) public view returns(uint){
        return applications[id].credit_amount;
    }
    
    function getlocker(address addr,uint id) public view returns (address) {
        return borrwers[addr].circles[id].locker;
    }
    
    function agreeForLoan(address addr,uint id) public {
       borrwers[addr].circles[id].partcipantList[msg.sender].agree = true;
       
        
    }
    
    function changestatusApproved(address addr,uint id) public {
        applications[id].status = Status.Approved;
        borrwers[addr].circles[id].investor = msg.sender;
        
    }
    function changestatusShortlisted(uint id) public {
        applications[id].status = Status.Shortlisted;
    }
    
    function ifAgreed(uint id) public {
        //code if 80 % of participants agreed for loan
        //uint members = borrwers[addr].circles[id].participants.length;
        
        applications[id].status = Status.Progress;
    }
    
    function releaseLoan(address addr,uint id,uint appId) public {
        Accounts acc = Accounts(AccountsContract);
        //balances[applications[appId].borrower] += applications[appId].credit_amount * 40/100;
        uint initialamount = applications[appId].credit_amount * 40/100;
        acc.transfer(borrwers[addr].circles[id].locker,borrwers[addr].circles[id].borrower,initialamount);

        // Populate loan object
        loans[numLoans] = Loan(true, numLoans, borrwers[addr].circles[id].borrower, borrwers[addr].circles[id].investor, applications[appId].interest_rate, applications[appId].duration,
        applications[appId].credit_amount, applications[appId].credit_amount, 0, block.timestamp,0, appId);
        numLoans += 1;

        //applications[appId].openApp = false;
        hasOngoingLoan[borrwers[addr].circles[id].borrower] = true;
    }
    function PaytoInvestor(address addr,uint id,uint EMI) public payable {
        address payer = borrwers[addr].circles[id].locker;
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(payer,borrwers[addr].circles[id].investor,EMI);
    }


    function getinvestor(address addr,uint id) public view  returns (address)
    {
        return borrwers[addr].circles[id].investor;
    }
    
    

}

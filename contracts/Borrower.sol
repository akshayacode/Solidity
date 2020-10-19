//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;



contract BorrowerContract {
   
   
    mapping (address => Borrower) public borrowers; // Borrower public key => Borrower
    

    //Global counters, always increment
    uint numApplications;
    uint numLoans;
    uint locker;

    mapping (uint => LoanApplication) public applications;
    mapping (uint => Loan) public loans;

    mapping(address => bool) hasOngoingLoan;
    mapping(address => bool) hasOngoingApplication;
    mapping(address => bool) hasOngoingInvestment;

   
    struct Borrower{
        address borrower_public_key;
        string name;
        bool EXISTS;
    }
    struct LoanApplication{
        //For traversal and indexing
        bool openApp;
        uint applicationId;

        address borrower;
        uint duration; // In months
        uint credit_amount; // Loan amount
        uint interest_rate; //From form
        string otherData; // Encoded string with delimiters (~)

    }
    struct Loan{

        //For traversal and indexing
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
     struct FriendsCircle {
        string name;
        address waddress;
        int balance;
    }
  
   
    mapping(address => FriendsCircle) public circle;

    
    function createFriendsCircle(string memory _name, address _waddress) public {
        
        require(_waddress != circle[_waddress].waddress); //only one address per person
        FriendsCircle memory friendscircle = FriendsCircle({name: _name, waddress: _waddress, balance: 0});
        circle[_waddress] = friendscircle;
    }
    
   
    function isFriendCircle(address _waddress) public view returns (bool) {
        if (_waddress == circle[_waddress].waddress) {
            return true;
        }else {
            return false;
        }
    }
    
    function createBorrower(string memory name) public {
        Borrower memory borrower;
        borrower.name = name;
        borrower.borrower_public_key = msg.sender;
        borrower.EXISTS = true;
        //require (inv.investors[msg.sender].EXISTS != true);
        borrowers[msg.sender] = borrower;
        // borrowerArray[borrowerArray.length] = borrower.borrower_public_key;
        hasOngoingLoan[msg.sender] = false;
        hasOngoingApplication[msg.sender] = false;
        //acc.balances[msg.sender] = 0; // Init balance
    }
 
    function createApplication(uint duration, uint interest_rate, uint credit_amount, string memory otherData) public {

        require(hasOngoingLoan[msg.sender] == false);
        require(hasOngoingApplication[msg.sender] == false);
        require(isBorrower(msg.sender));
        applications[numApplications] = LoanApplication(true, numApplications, msg.sender, duration, credit_amount, interest_rate, otherData);
        // app.duration = duration;
        // app.interest_rate = interest_rate;
        // app.credit_amount = credit_amount;
        // app.otherData = otherData;
        // app.applicationId = numApplications;
        // app.borrower = msg.sender;
        // app.openApp = true;

        // current_applications[msg.sender] = app;
        numApplications += 1;
        hasOngoingApplication[msg.sender] = true;
    }
    

    function ifApplicationOpen(uint index) public view returns (bool){
        LoanApplication storage app = applications[index];
        if(app.openApp) return true; else return false;
    }
    function ifLoanOpen(uint index) public view returns (bool){
        Loan storage loan = loans[index];
        if (loan.openLoan == true) return true; else return false;
    }
    
    function getcreditamount(uint index) public view returns(uint) 
    {
        return applications[index].credit_amount;
    }
    function getApplicationData(uint index) public view returns (uint[] memory, string memory, address){
        string storage otherData = applications[index].otherData;
        uint[] memory numericalData = new uint[](4);
        numericalData[0] = index;
        numericalData[1] = applications[index].duration;
        numericalData[2] = applications[index].credit_amount;
        numericalData[3] = applications[index].interest_rate;

        address borrower = applications[index].borrower;
        return (numericalData, otherData, borrower);
        // numericalData format = [index, duration, amount, interestrate]
    }
    function getLoanData(uint index) public view returns (uint[] memory, address, address){
        uint[] memory numericalData = new uint[](9);
        numericalData[0] = index;
        numericalData[1] = loans[index].interest_rate;
        numericalData[2] = loans[index].duration;
        numericalData[3] = loans[index].principal_amount;
        numericalData[4] = loans[index].original_amount;
        numericalData[5] = loans[index].amount_paid;
        numericalData[6] = loans[index].startTime;
        numericalData[7] = loans[index].monthlyCheckpoint;
        numericalData[8] = loans[index].appId;

        return (numericalData, loans[index].borrower, loans[index].investor);
        
    }
    function getNumApplications() public view returns  (uint) { return numApplications;}
    function getNumLoans() public view returns (uint) { return numLoans;}
    function isBorrower(address account) public view returns (bool) {return borrowers[account].EXISTS;}
    function getTime() public  view returns (uint){return block.timestamp;}
}

//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;

contract InvestorContract {
   

    mapping (address => Investor) public investors; // Investor public key => Investor

   
    uint numLoans;
    uint locker;

    
    mapping (uint => Loan) public loans;

    mapping(address => bool) hasOngoingInvestment;

    // Structs
    struct Investor{
        address investor_public_key;
        string name;
        bool EXISTS;
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
 
   
    function createInvestor(string memory name) public {
        Investor memory investor;
        investor.name = name;
        investor.investor_public_key = msg.sender;
        investor.EXISTS = true;
        //require (borrowers[msg.sender].EXISTS != true);
        investors[msg.sender] = investor;
        // investorArray[investorArray.length] = investor.investor_public_key;
        hasOngoingInvestment[msg.sender] = false;
       // balances[msg.sender] = 0; // Init balance

    }
    

    
    // function grantLoan(uint appId) public {
    //     //Check sufficient balance
    //     require(balances[msg.sender] >= applications[appId].credit_amount);
    //     require(hasOngoingInvestment[msg.sender] == false);

    //     // Take from sender and give to reciever
    //     balances[msg.sender] -= applications[appId].credit_amount;
    //     locker +=  applications[appId].credit_amount;
        
    //     hasOngoingInvestment[msg.sender] = true;


    // }

    
    // function ifApplicationOpen(uint index) public view returns (bool){
    //     LoanApplication storage app = applications[index];
    //     if(app.openApp) return true; else return false;
    // }
    function ifLoanOpen(uint index) public view returns (bool){
        Loan storage loan = loans[index];
        if (loan.openLoan == true) return true; else return false;
    }
    // function getApplicationData(uint index) public view returns (uint[] memory, string memory, address){
    //     string storage otherData = applications[index].otherData;
    //     uint[] memory numericalData = new uint[](4);
    //     numericalData[0] = index;
    //     numericalData[1] = applications[index].duration;
    //     numericalData[2] = applications[index].credit_amount;
    //     numericalData[3] = applications[index].interest_rate;

    //     address borrower = applications[index].borrower;
    //     return (numericalData, otherData, borrower);
    //     // numericalData format = [index, duration, amount, interestrate]
    // }
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
        // numericalData format = [index, interestrate, duration, p_amnt, o_amnt, paid_amnt, starttime, app_index]
    }
    // function getNumApplications() public view returns  (uint) { return numApplications;}
    // function getNumLoans() public view returns (uint) { return numLoans;}
    // function isInvestor(address account) public view returns (bool) {return investors[account].EXISTS;}
    // function isBorrower(address account) public view returns (bool) {return borrowers[account].EXISTS;}
    // function getTime() public  view returns (uint){return block.timestamp;}
}

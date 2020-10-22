//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;

import "./Accounts.sol";
//import "./Borrower.sol";
import './Circle.sol'; // import borrower. sol
contract InvestorContract {
 

    mapping (address => Investor) public investors;

 
    
    address public AccountsContractAddress;
    
    address public contractaddr;

    // function set(address contractaddr, address text1) public  view returns(address, string memory , bool) {
      
    //   return  BorrowerContract(contractaddr).borrowers(text1);
       
          
    // }
    function setcontractaddr(address borrower, address account) public   {
      //BorrowerContractAddress = borrower;
      contractaddr = borrower;
      AccountsContractAddress = account;
   
          
    }
 
    mapping(address => bool) hasOngoingInvestment;

    // Structs
    struct Investor{
        address investor_public_key;
        string name;
        bool EXISTS;
    }
   
   
    function createInvestor(string memory name) public {
        Investor memory investor;
        investor.name = name;
        investor.investor_public_key = msg.sender;
        investor.EXISTS = true;
        //require (borrowers[msg.sender].EXISTS != true);
        investors[msg.sender] = investor;
        hasOngoingInvestment[msg.sender] = false;
       // balances[msg.sender] = 0; // Init balance

    }
  

     function applicationdata(uint id) public view  returns(uint,uint,uint,uint,uint) {
        CirclesContract cbwr = CirclesContract(contractaddr);
        return cbwr.viewApplication(id);
    }
    

    
    function grantloan(address addr,uint index) public payable {
        Accounts acc = Accounts(AccountsContractAddress);
        //BorrowerContract bwr = BorrowerContract(BorrowerContractAddress);
        CirclesContract cbwr = CirclesContract(contractaddr);
        uint amount = cbwr.getCreditAmount(index);
        address beneficiary = cbwr.getlocker(addr,index);
        require(acc.viewBalance(msg.sender) >= amount);
        require(hasOngoingInvestment[msg.sender] == false);
        //address circlelocker = acc.locker();
        acc.transfer(msg.sender,beneficiary,amount);
        hasOngoingInvestment[msg.sender] = true;
        //cbwr.applications(index).credit_amount= Status.Shortlisted;

    }

}

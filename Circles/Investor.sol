//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;

import "./Accounts.sol";
import './Circle.sol'; // import borrower. sol
contract InvestorContract {
 
    mapping (address => Investor) public investors;

    address public AccountsContractAddress;
    
    address public contractaddr;

    function setcontractaddr(address borrower, address account) public   {
      contractaddr = borrower;
      AccountsContractAddress = account;
   
    }
 
    mapping(address => bool) hasOngoingInvestment;

    // Structs
    struct Investor{
        address investor_public_key;
        string name;
        bool EXISTS;
        InvestorStatus status;
        uint interestrate;
    }
    
    enum InvestorStatus{
        Shortlisted,
        Debited
    }
   
    function createInvestor(string memory name) public {
        //Investor memory investor;
        investors[msg.sender].name = name;
        investors[msg.sender].investor_public_key = msg.sender;
        investors[msg.sender].EXISTS = true;
        //investors[msg.sender] = investor;
        hasOngoingInvestment[msg.sender] = false;

    }
  

    function applicationdata(uint id) public view  returns(uint,uint,uint,uint,uint,uint,Status) {
        CirclesContract cbwr = CirclesContract(contractaddr);
        return cbwr.viewApplication(id);
    }
    
    // Using Javascript shortlist the applications
    
    function Shortlist(uint id,uint interest_rate) public{
        CirclesContract cbwr = CirclesContract(contractaddr);
        investors[msg.sender].interestrate = interest_rate;
        investors[msg.sender].status = InvestorStatus.Shortlisted;
        cbwr.changestatusShortlisted(id);
        
    }
   
    function grantloan(address addr,uint index) public payable {
        Accounts acc = Accounts(AccountsContractAddress);
        CirclesContract cbwr = CirclesContract(contractaddr);
        uint amount = cbwr.getCreditAmount(index);
        address beneficiary = cbwr.getlocker(addr,index);
        require(hasOngoingInvestment[msg.sender] == false);
        acc.transfer(msg.sender,beneficiary,amount);
        hasOngoingInvestment[msg.sender] = true;
        //cbwr.changestatusApproved(addr,index);
        investors[msg.sender].status = InvestorStatus.Debited;
    }

}

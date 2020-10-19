//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;

import "./Accounts.sol";
import "./Borrower.sol";
contract InvestorContract {
 

    mapping (address => Investor) public investors;

 
    address public BorrowerContractAddress;
    address public AccountsContractAddress;
    

    // function set(address contractaddr, address text1) public  view returns(address, string memory , bool) {
      
    //   return  BorrowerContract(contractaddr).borrowers(text1);
       
          
    // }
    function setcontractaddr(address borrower, address account) public   {
      BorrowerContractAddress = borrower;
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
    
      function demo(address addr,uint256 index) public view returns(bool) {
        //BorrowerContract bwr = BorrowerContract(addr);
        //bwr.ifApplicationOpen(index);
         return BorrowerContract(addr).ifApplicationOpen(index);

    }


    
    function viewApplication(uint index) public view  returns(uint[] memory, string memory, address) {
       BorrowerContract bwr = BorrowerContract(BorrowerContractAddress);
       return bwr.getApplicationData(index);
    }
    

     function applicationdata(uint index) public view  returns(bool, uint, address, uint, uint, uint, string memory) {
        BorrowerContract bwr = BorrowerContract(BorrowerContractAddress);
       return bwr.applications(index);
    }
    

    
    function grantloan(uint index) public payable {
        Accounts acc = Accounts(AccountsContractAddress);
        BorrowerContract bwr = BorrowerContract(BorrowerContractAddress);
        uint amount = bwr.getcreditamount(index);
        require(acc.viewBalance(msg.sender) >= amount);
        require(hasOngoingInvestment[msg.sender] == false);
        //address circlelocker = acc.locker();
        acc.transfer(msg.sender,acc.locker(),amount);
        hasOngoingInvestment[msg.sender] = true;

    }

}

//SPDX-License-Identifier: MIT;
pragma solidity ^0.7.0;

import './Accounts.sol';
contract InvestorContract {
   
    
    mapping (address => Investor) public investors;

   
   
    address locker = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    
   

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

    function DepositFD(address contractaddr,uint amount,address _addr) public payable {
        //Check sufficient balance
        Accounts acc = Accounts(contractaddr);
        require(acc.viewBalance(_addr) >= amount);
        require(hasOngoingInvestment[msg.sender] == false);

        acc.transfer(_addr,locker,amount);
        
        hasOngoingInvestment[msg.sender] = true;

    }

}

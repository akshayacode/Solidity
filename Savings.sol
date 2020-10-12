pragma solidity ^0.7.0;

contract Savings{
    
    struct Fund{
            string  fundName;
            uint  installmentAmount;
            uint  noOfInstallments;
            uint  noOfParticipants;
            address manager;
    }
    
    mapping(address => Fund) public ChitFund;
    uint public numFunds;
    
    
    function createFund(string memory name, uint amount, uint installments, uint participants) public {
        ChitFund[msg.sender] = Fund(name, amount, installments, participants, msg.sender);
        numFunds++;
    }
}

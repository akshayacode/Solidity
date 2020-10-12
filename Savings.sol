// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Savings{
    
    string public fundName;
    uint public installmentAmount;
    uint public noOfInstallments;
    uint public noOfParticipants;
  
    
    uint public numFunds;
    
    address public manager;
    mapping(address => bool) public participants;
    uint public noOfParticipantsJoined;
    uint public fundBalance;
    bool public status = true;
    
    address[] public participantsArray;
    address[] public participantsToBePaid;
    
    function createFund(string memory name, uint amount, uint installments, uint _Participants) public {
       fundName = name;
       installmentAmount = amount;
       noOfInstallments = installments;
       noOfParticipants = _Participants;
       numFunds++;
    }
    
    function joinFund() public {
        require(noOfParticipantsJoined < noOfParticipants);
        require(participants[msg.sender] != true);
        require(status);

        // participants.push(msg.sender);
        participants[msg.sender] = true;
        participantsArray.push(msg.sender);
        participantsToBePaid.push(msg.sender);
        noOfParticipantsJoined++;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import './Accounts.sol';
contract Save{
   
    
    // mapping (address => uint) balance;
    

    string FundName;
    uint targetamount;
    uint installmentAmount;
    uint noOfInstallments;
    uint noOfparticipants;
    address manager;
    address locker = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    
    mapping(address => bool) public participants;
    uint public noOfParticipantsJoined;
    bool public status = true;
    address[] public participantsArray;
    address[] public participantsToBePaid;
    
    mapping(address => uint) public contributedParticipants;
    uint public currentInstallment = 1;
    uint public currentNoOfContributors;
    uint public fundBalance;
    
    //For bidding
    uint  public LowestBid;
    address public LowestBidder;
    event LowestBidDecreased(address bidder, uint amount);
    
    //Locker
  
    
 
     
    function CreateChitFund(string memory name,uint _targetamount,uint _installmentAmount,uint _noOfInstallments,uint _noOfparticipants) public
    {
       FundName = name;
       targetamount = _targetamount;
        installmentAmount = _installmentAmount;
        noOfInstallments = _noOfInstallments;
        noOfparticipants = _noOfparticipants;
        manager = msg.sender;
        LowestBid = _targetamount;
   
        
    }
    
    function joinFund() public {
        require(noOfParticipantsJoined < noOfparticipants);
        require(participants[msg.sender] != true);
        require(status);

        participants[msg.sender] = true;
        participantsArray.push(msg.sender);
        participantsToBePaid.push(msg.sender);
        noOfParticipantsJoined++;
    }
     modifier isParticipant() {
        require(participants[msg.sender] == true);
        _;
    }
    modifier isManager() {
        require(msg.sender == manager);
        _;
    }
    
    function contribute(address addr,uint amount) public isParticipant payable {
        require(amount == installmentAmount);
        require(contributedParticipants[msg.sender] != currentInstallment);
        require(status);

        fundBalance += amount;
        Accounts ac = Accounts(addr);
        ac.transfer(msg.sender,locker,amount);
        currentNoOfContributors ++;
        contributedParticipants[msg.sender] = currentInstallment;
    }
    
    function participantsToBePaidLength() public view returns(uint) {
        return participantsToBePaid.length;
    }
    function bid(uint amount) public payable {
  
        require(
            amount < LowestBid,
            "There already is a Lowest bid."
        );

        
        LowestBidder = msg.sender;
        LowestBid = amount;
        emit LowestBidDecreased(msg.sender, amount);
    }
    
    function releaseFund(address _addr) public payable isManager {
        Accounts acc = Accounts(_addr);
        require(currentNoOfContributors == noOfparticipants);
        require(status);
        if(currentInstallment == 1)
        {
            //balance[manager] += targetamount;
            acc.transfer(locker,manager,targetamount);
        }
        else{
        //balance[LowestBidder] += LowestBid;
        acc.transfer(locker,LowestBidder,LowestBid);
        }
        currentInstallment ++;
        fundBalance = targetamount - LowestBid;
        currentNoOfContributors = 0;
        LowestBid = targetamount;

        if(currentInstallment == noOfInstallments) {
            status = false;
        }
    }

    
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;


contract Save{
    mapping (address => uint) balances;
    

    string FundName;
    uint targetamount;
    uint installmentAmount;
    uint noOfInstallments;
    uint noOfparticipants;
 
    
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
    
    function viewBalance() public view returns (uint256){
        return balances[msg.sender];
    }
    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }
    function withdraw(uint amount) public payable returns(uint) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        return amount;
    }
    function transfer(address taker, uint amount) public payable{
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[taker] += amount;
    }
     
    function CreateChitFund(string memory name,uint _targetamount,uint _installmentAmount,uint _noOfInstallments,uint _noOfparticipants) public
    {
       FundName = name;
       targetamount = _targetamount;
        installmentAmount = _installmentAmount;
        noOfInstallments = _noOfInstallments;
        noOfparticipants = _noOfparticipants;
        
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
    
    function contribute(uint amount) public isParticipant payable {
        require(amount == installmentAmount);
        require(contributedParticipants[msg.sender] != currentInstallment);
        require(status);

        fundBalance += amount;
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
    
    
    
    
    
    
}

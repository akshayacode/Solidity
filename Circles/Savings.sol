// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import './Accounts.sol';
contract Save{
   
    enum Status {
        Active,
        Inactive,
        Locked
    }

    string FundName;
    uint circleLimit;
    uint changeCircleLimit;
    uint targetamount;
    uint installmentAmount;
    uint noOfInstallments;
    uint noOfparticipants;
    address manager;
    
    //circle status
    Status CircleStatus;
    
    mapping(address => bool) public participants;
    uint public noOfParticipantsJoined;
    //bool public status = true;
    address[] public participantsArray;
    address[] public participantsToBePaid;
    
    mapping(address => uint) public contributedParticipants;
    mapping(address => bool) public agree;
    uint public currentInstallment = 1;
    uint public currentNoOfContributors;
    uint public fundBalance;
    
    //For bidding
    uint public AuctionTime;
    uint  public LowestBid;
    address public LowestBidder;
    event LowestBidDecreased(address bidder, uint amount);
    address  public defaultAddress ;
    address public AccountsContract;
    
    //Locker
  
    function setAccountsContract(address addr) public{
         AccountsContract = addr;
    } 
 
    function SavingCircle(string memory name,uint _circleLimit,uint _targetamount,uint _installmentAmount,uint _noOfInstallments,uint _noOfparticipants) public
    {
        FundName = name;
        circleLimit = _circleLimit;
        manager = msg.sender;
        defaultAddress = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
        targetamount = _targetamount;
        installmentAmount = _installmentAmount;
        noOfInstallments = _noOfInstallments;
        noOfparticipants = _noOfparticipants;
        LowestBid = _targetamount;
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,defaultAddress,circleLimit);
        
    }
     
    function changeCircleLimt(uint _circleLimit)  public  {
        changeCircleLimit = _circleLimit;
        // Notofication should go to manager
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,defaultAddress,circleLimit);
    }
    
    function Agree() public isParticipant {
        
        agree[msg.sender] = true;
    }
    
    function checkagree() public isManager {
        require(agree[manager] == true);
        uint numagree = participantsArray.length;
        uint maxagree = participantsArray.length * 80/100;
        if(numagree >= maxagree)
        {
          circleLimit = changeCircleLimit;
          Accounts acc = Accounts(AccountsContract);
          acc.transfer(msg.sender,defaultAddress,circleLimit);  
        }
    }
    
    function viewSavingCircle() public view returns(uint _circleLimit,uint,uint,uint,uint,uint) {
        return (circleLimit,targetamount,installmentAmount,noOfInstallments,noOfparticipants,noOfParticipantsJoined);
    }
    function joinFund() public {
        require(noOfParticipantsJoined < noOfparticipants);
        require(participants[msg.sender] != true);
        require(CircleStatus == Status.Active);
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,defaultAddress,circleLimit);
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
    
    function contribute(uint amount) public isParticipant payable {
        require(amount == installmentAmount);
        require(contributedParticipants[msg.sender] != currentInstallment);
        require(CircleStatus == Status.Active);

        fundBalance += amount;
        Accounts ac = Accounts(AccountsContract);
        ac.transfer(msg.sender,defaultAddress,amount);
        currentNoOfContributors ++;
        contributedParticipants[msg.sender] = currentInstallment;
    }
    
    function participantsToBePaidLength() public view returns(uint) {
        return participantsToBePaid.length;
    }
    function bid(uint amount) public payable {
        
        require(
            block.timestamp <= AuctionTime,
            "Auction already ended."
        );
  
        require(
            amount < LowestBid,
            "There already is a Lowest bid."
        );

        
        LowestBidder = msg.sender;
        LowestBid = amount;
        emit LowestBidDecreased(msg.sender, amount);
    }
    
    function releaseFund() public payable isManager {
        Accounts acc = Accounts(AccountsContract);
        require(currentNoOfContributors == noOfparticipants);
        require(CircleStatus == Status.Active);
        if(currentInstallment == 1)
        {
            //balance[manager] += targetamount;
            acc.transfer(defaultAddress,manager,targetamount);
        }
        else{
        //balance[LowestBidder] += LowestBid;
        acc.transfer(defaultAddress,LowestBidder,LowestBid);
        }
        currentInstallment ++;
        fundBalance = targetamount - LowestBid;
        currentNoOfContributors = 0;
        LowestBid = targetamount;

        if(currentInstallment == noOfInstallments) {
           CircleStatus = Status.Inactive;
        }
    }
    
    function setAuctionTime() public isManager {
        AuctionTime = block.timestamp * 1 days;
        
    }

    function Lockcircle() public {
        require(LowestBid == targetamount);
        CircleStatus = Status.Locked;
    }
}

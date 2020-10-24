//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;

import './Accounts.sol';
contract CirclesContract {
    
    address public AccountsContract;
    
    
     struct Borrower{
        address borrower;
        mapping(uint => Circle) circles;
        
    }
    
    struct Circle{
        string name;
        address manager;
        address borrower;
        address locker;
        address[] participants;
        uint circleLimit;
        mapping (address => participantsteams) participantslist;
        mapping(uint => checklist1)  checkme;
             
        
    }
    
    struct participantsteams{
        address participantsno;
        bool agree;
     
       
    }
   
    mapping(address => Borrower) public borrwers;
    mapping (address => participantsteams) public participantslist;
    
 
    
    enum Status{
        Created,
        Progress,
        Shortlisted,
        Accepted
    }
         //temp store only
         struct checklist1 {
                
                address[] user;
                bool[] agree;
            }
            
    
    struct LoanApplication {
        //uint id;
        uint duration;
        uint interest_rate;
        uint credit_amount;
        uint total_circle_limit;
        //uint available_limit;
        uint EMI;
        Status status;
        
    }
    
    mapping(uint => LoanApplication) public applications;
    uint numapplications;
    function setAccountsContract(address addr) public {
        AccountsContract = addr;
    }
    
    
    function createCircle(uint id,string memory name,uint circleLimit) public{
        borrwers[msg.sender].borrower = msg.sender;
        borrwers[msg.sender].circles[id].name= name;
        borrwers[msg.sender].circles[id].circleLimit = circleLimit;
        borrwers[msg.sender].circles[id].manager = msg.sender;
        borrwers[msg.sender].circles[id].locker = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
        Accounts acc = Accounts(AccountsContract);
        acc.transfer(msg.sender,borrwers[msg.sender].circles[id].locker ,circleLimit);
        
    }
    
    
    function viewCircle(address addr,uint id) public view returns(string memory,address,address[] memory,uint) {
        return(borrwers[addr].circles[id].name,
               borrwers[addr].circles[id].manager,
               borrwers[addr].circles[id].participants,
               borrwers[addr].circles[id].circleLimit);
    }

    
    
    
  
    function joincircle(address addr,uint id) public {
        Accounts acc = Accounts(AccountsContract);
        
        acc.transfer(msg.sender,borrwers[addr].circles[id].locker,borrwers[addr].circles[id].circleLimit);
        borrwers[addr].circles[id].participants.push(msg.sender);
      
      
        borrwers[addr].circles[id].participantslist[msg.sender].participantsno = msg.sender;
        borrwers[addr].circles[id].participantslist[msg.sender].agree = false;
        
    }

     
    function checkAgreeIam(address addr, uint id) public view returns(address, bool){
        
        
       return ( borrwers[addr].circles[id].participantslist[msg.sender].participantsno, 
                borrwers[addr].circles[id].participantslist[msg.sender].agree);
                
            }
          
    //only access for admin or manager 
       function checkAgreeList(address addr, uint id) public view returns(address[] memory, bool[] memory){
              return( borrwers[addr].circles[id].checkme[id].user, 
                      borrwers[addr].circles[id].checkme[id].agree);
              
          }  
             
    function Admincheckagree(address addr, uint id) public {
      
        for (uint m = 0; m <  borrwers[addr].circles[id].participants.length; m++) {
           
           if(borrwers[addr].circles[id].participantslist[borrwers[addr].circles[id].participants[m]].agree == true){
               
            borrwers[addr].circles[id].checkme[id].user.push(borrwers[addr].circles[id].participants[m]);
            
            borrwers[addr].circles[id].checkme[id].agree.push(true);

           }else{
               
           borrwers[addr].circles[id].checkme[id].user.push(borrwers[addr].circles[id].participants[m]);
            
             borrwers[addr].circles[id].checkme[id].agree.push(false);
                       
           }
           
        }
        
    }
    
    
   
    
    function CreateApplication(uint duration,uint interest_rate,uint credit_amount,uint total_circle_limit,uint EMI) public {
        applications[numapplications] = LoanApplication(duration,interest_rate,credit_amount,total_circle_limit,EMI,Status.Created);
    }
    
    function viewApplication(uint id) public view returns(uint,uint,uint,uint,uint,Status)
    {
        return (applications[id].duration,
                applications[id].interest_rate,
                applications[id].credit_amount,
                applications[id].total_circle_limit,
                applications[id].EMI,
                applications[id].status);
        
        //return applications[id]; (not working)
    }
    
    function agreeForLoan(uint id) public {
        
    }
    
    
    function checkagree(address addr) public view returns(address, bool){
        
       return (participantslist[addr].participantsno, participantslist[msg.sender].agree);
    
        
    }
    
    function ifAgreed(address addr, uint id) public {
          
          borrwers[addr].circles[id].participantslist[msg.sender].agree = true;
          
    }
}

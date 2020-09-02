pragma solidity ^0.6.0;
 contract AConstructor{
     
     uint public x;
     uint public y;
     
     address public Owner;
     uint public CreatedAt;
     
       constructor(uint _x,uint _y) public{
           x = _x;
           y = _y;
           
           Owner = msg.sender;
           CreatedAt = block.timestamp;
       }
 }

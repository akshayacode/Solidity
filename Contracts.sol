pragma solidity ^0.7.0;

contract Callee{
    uint public x;
    uint public value;
    mapping(address => uint) public balances;
    
    function setX(uint _x) public returns(uint){
        x = _x;
        return x;
    }
    
    function setXandSendEther(uint _x) public payable returns(uint,uint){
        x = _x;
        value = msg.value;
        
        return(x,value);
    }
    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }
}

contract Caller{
    
    function setX(Callee _callee ,uint _x) public returns(uint){
        uint x=_callee.setX(_x);
    }
    
    function setFromAddress(address _addr,uint _x) public{
        Callee callee= Callee(_addr);
        callee.setX(_x);
    }
    
    function setXandSendEther(Callee _callee,uint _x) public payable{
        (uint x,uint value) = _callee.setXandSendEther{value:(msg.value)}(_x);
    }
    function deposit(address _addr,uint amount) public payable{
        Callee callee= Callee(_addr);
        callee.deposit(amount); 
    }
}


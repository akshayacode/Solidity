pragma solidity ^0.6.0;

contract FunctionModifiers{
    
    address public owner;
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner,"NotOwner");
        _;
    }
    
    modifier validAddress(address _addr) 
    {
        require(_addr != address(0), "Not Valid Address");
        _;
    }
    
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner){
        //onlyOwner();
        //validAddress(_newOwner);
        owner = _newOwner;
    }
    
    //reentrancy
    uint public x=10;
    bool locked;
    
    modifier noReentrancy(){
        require(!locked,"Locked");
        locked = true;
        _;
        locked = false;
    }
    function decrement(uint i) public noReentrancy{
        x -= i;
        
        if(i > 1)
        {
            decrement(i-1);
        }
    }
}

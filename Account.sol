pragma solidity ^0.6.0;

contract Account{
    uint public balance;
    uint public constant MAX_UNIT = 2 ** 256 -1;
    
    function deposit(uint _amount) public{
        uint OldBalance = balance;
        uint NewBalance = balance + _amount;
        require(NewBalance >= OldBalance,"Overflow");
    
        balance = NewBalance;
        assert(balance >= OldBalance);
        
    }
    
    function withdraw(uint _amount) public{
        uint OldBalance = balance;
        
        //balance does not underflow
        require(balance >= _amount,"underflow");
        balance -= _amount;
        //revert takes only one argument
        if(balance < _amount){
            revert("underflow");
        }
        assert(balance <= OldBalance);
    }
}

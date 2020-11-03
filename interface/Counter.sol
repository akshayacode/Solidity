pragma solidity ^0.6.0;

contract counter{
    uint public count;
    
    function increment() external {
        count +=1;
    }
    
}

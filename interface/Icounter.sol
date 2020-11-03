pragma solidity ^0.6.0;

interface ICounter{
    function count() external view returns(uint);
    function increment() external;
}

contract MyContract{
    function incrementCounter(address _adr) external {
        ICounter(_adr).increment();
    }
    
    
    function getCount(address _adr) external view returns(uint){
        return ICounter(_adr).count();
    }
}

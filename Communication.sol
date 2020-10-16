pragma solidity ^0.7.0;

contract Calculate{
    
    
    function TwoPlusFive(address _addr) public view returns(uint)
    {
        Calculator calc = Calculator(_addr);
        return calc.add(2,5);
    }
    function twoTimesFive(address _addr) public view returns(uint)
    {
        Calculator calc = Calculator(_addr);
        return calc.mul(2,5);
    }
}


contract Calculator{
    function add(uint a,uint b) public view returns(uint)
    {
        return a + b;
    }
    
    function mul(uint a ,uint b) public view returns(uint)
    {
        return a*b;
    }
}

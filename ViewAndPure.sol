pragma solidity ^0.6.0;

contract ViewAndPure{
    uint public x=1;//state variables
    //view functions do not modify state.
    function addToX(uint y) public view returns(uint)
    {
        return x+y;
    }
    //when we try to update x in view function it throws error
    //function update() public view{
       // x +=1;}
       
    function add(uint i,uint j) public pure returns(uint)
    {
        return i+j;
    }
    
    //If we remove pure here it changes to view and it
    //cannot be accessable by pure fun so it throws error
    function foo() public pure{
        
    }
    function invalidPure() public pure{
        fool()
    }
    
}

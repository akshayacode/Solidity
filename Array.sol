pragma solidity ^0.6.0;

contract Arrays{
    
    uint[] public uintArray=[1,2,3];
    string[] public stringarray=["block","chain"];
    string[] public values;
    
    function addvalue(string memory _value) public{
        values.push(_value);//adds to the ends of the array
    }
    
    uint[][] public array2D =[[1,2,3],[4,5,6]];
}

pragma solidity ^0.6.0;
//No storage, no ether
//can add functionality types

//Embedded library has only internal function
//Linked library must be deployed and linked(if public and external function)

//SafeMath to prevent uint overflow
library SafeMath{
    function add(uint x,uint y) internal pure returns(uint)
    {
        uint z= x + y;
        require( z >= x, "uint overflow");
        
        return z;
    }
}

contract TestSafeMAth{
    using SafeMath for uint;
    
    //uint x=123;
    //x.add(456);
    //SafeMath.add(x,456);
    
    uint public MAx_UINT = 2 ** 256 -1;
    
    function testAdd(uint x,uint y) public pure returns ( uint){
        return x.add(y);
    }
    
}

//deleting element from array without using gas
library Array{
    function remove(uint[] storage arr,uint index) public{
        arr[index] = arr[arr.length -1];
        arr.pop();
    }
}

contract TestArray{
    using Array for uint[];
    
    uint[] public arr;
    
    function testArrayRemove() public{
        for(uint i=0;i < 3; i++)
        {
            arr.push(i);
        }
        arr.remove(1);
        
        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
        
    }
}

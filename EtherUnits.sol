pragma solidity ^0.6.0;

contract EtherUnits{
    uint public OneWei = 1 wei;
    uint public OneEther = 1 ether;
    
    function testOnewei() public pure returns(bool)
    {
        return 1 wei == 1;
        
    }
    function textOneEther() public pure returns(bool){
        return 1 ether ==1e18 wei;
    }
}

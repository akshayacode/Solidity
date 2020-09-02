pragma solidity ^0.6.0;
// tx fee = gas used * gas price
// Gas = Unit of computation
// Gas Price = Ether / gas
// Unspent gas will be refunded
// Gas Limit - set by you
//Block Gas Limit - set by network
//if you run out of gas the transaction will fail and the changes made 
//to state variables will be undone but still we need to pay for gas

contract TestGasRefund{
    
    function Gasvalue() public returns (uint)
    {
        return tx.gasprice;
        
    }
    
    uint public i=0;
    function forever() public{
        while(true)
        {
            i+=1;
        }
    }
}

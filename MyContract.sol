//SPDX-License-Identifier
pragma solidity ^0.6.10;

contract MyContract {
    uint public count;

    //get the current count
    function get() public view returns (uint) {
        return count;
    }

    //increment 1
    function inc() public {
        count += 1;
    }

    //decrement by 1
    function dec() public {
        count -= 1;
    }
    
    // --------DATA TYPES---------
    function datatypes() public{
    bool boo=true ;
    
    //Unsigned int from 8 bits to 256 bits. uint256 is same as uint.
    uint aa = 43;
    uint256 ab = 345;
    uint8 ac =1;
    
    //Unsigned int from 8 bits to 256 bits. uint256 is same as uint.
    int i=123;
    int256 i256=345;
    int8 i8=1;
    
    address ad=0x6cb526eba41c87AE55dbc5B63D106b74DcB72577;
    
    // Default values
    // Unassigned variables have a default value
    bool defaultBoo; // false
    uint defaultUint; // 0
    int defaultInt; // 0
    address defaultAddr; // 0x0000000000000000000000000000000000000000
    }
    
}

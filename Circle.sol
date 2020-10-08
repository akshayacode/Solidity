pragma solidity ^0.6.0;

contract Circles{
    
        struct FriendsCircle {
        string name;
        address waddress;
        int balance;
    }

    /// This declares a state variable that stores a `FriendsCircle` struct for each possible address.
    mapping(address => FriendsCircle) public circle;
 
    function createFriendsCircle(string memory _name, address _waddress) public {
        
        require(_waddress != circle[_waddress].waddress); //only one address per person
        FriendsCircle memory FriendsCircle = FriendsCircle({name: _name, waddress: _waddress, balance: 0});
        circle[_waddress] = FriendsCircle;
    }
}


pragma solidity ^0.7.0;

contract Circles{
    
        struct FriendsCircle {
        string name;
        address waddress;
        int balance;
    }
    
    struct Loan {
        
        uint loanamount;
        bool agree;
        mapping(address => bool) agreements; 
    }


    /// This declares a state variable that stores a `FriendsCircle` struct for each possible address.
    mapping(address => FriendsCircle) public circle;
    
    Loan[] public loans;

 
    function createFriendsCircle(string memory _name, address _waddress) public {
        
        require(_waddress != circle[_waddress].waddress); //only one address per person
        FriendsCircle memory friendscircle = FriendsCircle({name: _name, waddress: _waddress, balance: 0});
        circle[_waddress] = friendscircle;
    }
    
   
    function isFriendCircle(address _waddress) public view returns (bool) {
        if (_waddress == circle[_waddress].waddress) {
            return true;
        }else {
            return false;
        }
    }
        
        
}
    
   



pragma solidity ^0.7.0;

contract Fantasy {
    
    struct contest{
        string name;
        uint entryfee;
        uint team_size;
        uint prizeamount;
        uint spots;
        
        
    }
    uint numcontest;
    
  
    string[] public teams;
    
    mapping(uint => contest) public Contestdetails;
    
     function createcontest(string memory name,uint entryfee,uint team_size,uint prizeamount,uint spots) public {
        Contestdetails[numcontest] = contest(name,entryfee,team_size,prizeamount,spots);
    }
    
    function createTeam(string memory teamname) public{
         teams.push(teamname);
    }
    
    function addPlayers(string memory name) public {
        
    }
}

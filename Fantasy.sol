pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

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
    
    struct Player{
        string name;
        string category;
        uint value;
        
    }
    
    struct Teams{
        string Teamname;
        string[] playername;
    }
    
    Teams[] public teamData;
    
    mapping(uint => Player) public playerdetails;
    uint players;
    
    
    
     function createcontest(string memory name,uint entryfee,uint team_size,uint prizeamount,uint spots) public {
        Contestdetails[numcontest] = contest(name,entryfee,team_size,prizeamount,spots);
    }
    
    function CreateTeam(string memory _name, string[] memory _players) public {
        teamData.push(Teams(_name, _players));
    }
    
    function addPlayers(uint _index ,string memory _player,string memory category,uint value) public {
        teamData[_index].playername.push(_player);
        playerdetails[players] = Player(_player,category,value);
    }
    function getPlayersname(uint256 _index) public view returns (string[] memory) {
        return teamData[_index].playername;
    }
}

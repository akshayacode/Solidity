pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Fantasy {
    
    mapping(address => uint) balances;
    struct contest{
        string name;
        uint entryfee;
        uint team_size;
        uint prizeamount;
        uint spots;
        uint particiantsJoined;
        
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
    address[] creator;
    
    
    function createcontest(string memory name,uint entryfee,uint team_size,uint prizeamount,uint spots) public {
        Contestdetails[numcontest] = contest(name,entryfee,team_size,prizeamount,spots,0);
        creator.push(msg.sender);
        numcontest++;
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
    function viewBalance() public view returns (uint256){
        return balances[msg.sender];
    }
    function deposit(uint amount) public payable {
        balances[msg.sender] += amount;
    }
    function joincontest(uint _index) public payable {
        require(Contestdetails[_index].spots > Contestdetails[_index].particiantsJoined,'Contest Limit exceeded');
        balances[msg.sender] -= Contestdetails[_index].entryfee;
        balances[creator[_index]] += Contestdetails[_index].entryfee;
        Contestdetails[_index].particiantsJoined += 1;
           
        
    }
}

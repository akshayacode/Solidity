// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";


contract CollectableToken is
  NFTokenMetadata,
  Ownable
{

  /**
   * @dev Contract constructor. Sets metadata extension `name` and `symbol`.
   */
  constructor(string memory name,string memory symbol)
    public
  {
    nftName = name;
    nftSymbol = symbol;
  }
  
    string public collectableCircleName;
    uint256 public circle_length;
    uint256 public members;
    address public Circleadmin;
    address payable lockerAddress;
    address[] public members_address;
   
    
    function createCircle(string memory name,uint256 members_length) public 
    {
       collectableCircleName = name;
       circle_length = members_length;
       Circleadmin= msg.sender;
       members += 1;
       members_address.push(msg.sender);
       lockerAddress = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
    }
    
    function JoinCircle() public {
        require(members <= circle_length);
        members_address.push(msg.sender);
        members += 1;
        
    }
    
    function getLocker() public view returns (address payable) {
        return lockerAddress;
    }
  
  /**
   * @dev Mints a new NFT.
   * @param _to The address that will own the minted NFT.
   * @param _tokenId of the NFT to be minted by the msg.sender.
   * @param _uri String representing RFC 3986 URI.
   */
  function mint(
    address _to,
    uint256 _tokenId,
    // uint256 _price,
    string calldata _uri
  )
    external
    onlyOwner
  {
    super._mint(_to, _tokenId);
    super._setTokenUri(_tokenId, _uri);
  }

}

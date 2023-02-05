// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@opengsn/contracts/src/ERC2771Recipient.sol";             

contract MyToken is ERC1155, Ownable ,ERC2771Recipient {


     constructor(address _trustedForwarder) ERC1155("USDao") public {                 
        _setTrustedForwarder(_trustedForwarder);
    }

    mapping(uint256=>string)uris;

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function uri(uint256 _id) public view virtual override returns (string memory) {
        return uris[_id];
    }

    function seturi(uint256 _id, string memory _uri)public onlyOwner returns(string memory){
       uris[_id] = _uri;
       return uris[_id];
    }

    function _msgSender() internal override(ERC2771Recipient,Context) view returns(address){

    }

    function _msgData() internal override(ERC2771Recipient,Context) virtual view returns (bytes calldata ret) {
        if (msg.data.length >= 20 && isTrustedForwarder(msg.sender)) {
            return msg.data[0:msg.data.length-20];
        } else {
            return msg.data;
        }
    }
  
}

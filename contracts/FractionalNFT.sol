// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts@4.6.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/utils/ERC721Holder.sol";

contract FractionalizedNFTFactory {
    FractionalizedNFT[] public FractionalizedNFTs;

    function createFractionalizedNFT() external {
        FractionalizedNFT fractionalized_NFT = new FractionalizedNFT();
        fractionalized_NFT.transferOwnership(msg.sender);
        FractionalizedNFTs.push(fractionalized_NFT);
    }
}

contract FractionalizedNFT is ERC20, Ownable, ERC20Permit, ERC721Holder {
    IERC721 public collection;
    uint256 public tokenId;
    uint256 public maxSupply;
    uint256 public currentSupply;
    bool public initialized;
    bool public forSale;
    uint256 public salePrice;
    bool public canRedeem;
    bool public sold;

    constructor() ERC20("Akshay", "AKY") ERC20Permit("Akshay") {}

    function initialize(
        address _collection,
        uint256 _tokenId,
        uint256 _amount,
        uint256 price
    ) external onlyOwner {
        require(!initialized, "Already initialized");
        require(_amount > 0, "Amount should be > 0");
        collection = IERC721(_collection);
        collection.safeTransferFrom(msg.sender, address(this), _tokenId);
        tokenId = _tokenId;
        initialized = true;
        maxSupply = _amount;
        salePrice = price;
        forSale = true;
    }

    function buyFraction(uint256 _amount) external payable {
        require(!sold, "Already sold");
        require(currentSupply + _amount <= maxSupply, "Max supply reached");
        require(msg.value >= salePrice * _amount, "Not enough ether");
        currentSupply += _amount;
        _mint(msg.sender, _amount);
    }

    function redeem(uint256 _amount) external {
        require(_amount == maxSupply , "Not enough tokens");
        _burn(msg.sender, _amount);
        collection.transferFrom(address(this), msg.sender, tokenId);
    }
}

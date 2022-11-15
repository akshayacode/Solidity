// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "./1155AkshayaTicket.sol";

interface IRandomizer {
    function requestRandomWords() external;

    function s_randomWords(uint256) external view returns (uint256);
}

contract AkSerum is ERC1155, Ownable, ERC1155Burnable {
    
    IRandomizer random;
    AkshayaTicket akt;
    uint8[] items = [0, 1, 2];
    uint256[] weights = [1, 10, 89];
    uint256[] cumulativeWeights = [1, 11, 100];
    uint8 private randomItem;
    uint8 public randomNum;

    constructor(address _randomizerAddress) ERC1155("https://akshaya.com/") {
        random = IRandomizer(_randomizerAddress);
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
     function setTicketAddr (address _addr) internal {
        akt = AkshayaTicket(_addr);
    }

    function mint(
        address account,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        randomNum= spin();
        require(akt.balanceOf(msg.sender, 1) >= 50, "Not enought tickets");
        akt.burn(msg.sender, 1, 50);
        _mint(account, randomNum, amount, data);
    }

    function spin() internal returns (uint8) {
        random.requestRandomWords();
        uint256 firstNum = (random.s_randomWords(0) % 3) + 1;
        for (uint256 itemIndex = 0; itemIndex < items.length; itemIndex += 1) {
            if (cumulativeWeights[itemIndex] >= firstNum) {
                randomItem= items[itemIndex];
            }
        }
        return randomItem;
    }
}

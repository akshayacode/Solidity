// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract WeightedRandom {
    function pickPositionByWeight(
        uint256 numChoices,
        uint256[] memory choiceWeight,
        uint256 randomNumber
        ) public pure returns (uint256) {
        uint256 sum_of_weight = 0;
        for (uint256 i = 0; i < numChoices; i++) {
        sum_of_weight += choiceWeight[i];
        }
        uint256 rnd = randomNumber % sum_of_weight;
        for (uint256 i = 0; i < numChoices; i++) {
        if (rnd < choiceWeight[i]) return i;
        rnd -= choiceWeight[i];
        }
    return rnd;
}

}

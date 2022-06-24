// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

error Raffle__NotEnoughETHEntered();

contract Raffle {
    /* State variables */
    uint private immutable i_entranceFee;
    address payable[] private s_players;

    constructor(uint entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughETHEntered();
        }
        s_players.push(payable(msg.sender));
    }

    function getEnteranceFee() public view returns (uint) {
        return i_entranceFee;
    }

    function getPlayer(uint index) public view returns (address payable) {
        return s_players[index];
    }
}
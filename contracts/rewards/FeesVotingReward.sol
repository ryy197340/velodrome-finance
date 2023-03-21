// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {VotingReward} from "./VotingReward.sol";
import {IVoter} from "../interfaces/IVoter.sol";

/// @notice Bribes pay out rewards for a given pool based on the votes that were received from the user (goes hand in hand with Voter.vote())
contract FeesVotingReward is VotingReward {
    constructor(address _voter, address[] memory _rewards) VotingReward(_voter, _rewards) {}

    /// @inheritdoc VotingReward
    function notifyRewardAmount(address token, uint256 amount) external override nonReentrant {
        address sender = _msgSender();
        if (IVoter(voter).gaugeToFees(sender) != address(this)) revert NotGauge();
        if (!isReward[token]) revert InvalidReward();

        _notifyRewardAmount(sender, token, amount);
    }
}

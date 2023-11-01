// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IOnChainSetting {
    function viewSetting() external view returns (string memory);
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IOnChainStyle {
    function viewStyle() external view returns (string memory);
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IOnChainScript {
    function viewScript() external view returns (string memory);
}

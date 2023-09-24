// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./interfaces/IVisualGraphics.sol";

/// @title Visual Graphics as Smart Contract
/// @author raldblox
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
contract VectorGraphics is IVisualGraphics {
    address immutable deployer;

    constructor() {
        deployer = msg.sender;
    }

    function image() public pure override returns (string memory) {
        // store bitmap image
        return "hello";
    }

    function vectorImage() public pure returns (string memory) {
        // generate vector image
        return "hello";
    }

    function animation() public pure override returns (string memory) {
        // generate animation
        return "hello";
    }

    function metadata() public pure override returns (string memory) {
        // generate metadata
        return "hello";
    }

    function externalUrl() public pure override returns (string memory) {
        // generate metadata
        return "hello";
    }
}

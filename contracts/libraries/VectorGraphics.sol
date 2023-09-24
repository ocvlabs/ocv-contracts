// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library VectorGraphics {
    struct Params {
        string config;
        string animation;
        string externalUrl;
        string metadata;
    }

    function svg(Params calldata params) public pure returns (string memory) {
        return "hello";
    }
}

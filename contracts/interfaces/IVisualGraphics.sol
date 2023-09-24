// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

interface IVisualGraphics {
    struct VisualData {
        string image;
        string animation;
        string externalUrl;
        string metadata;
    }

    function metadata() external returns (string memory);

    function image() external returns (string memory);

    function animation() external returns (string memory);

    function externalUrl() external returns (string memory);
}

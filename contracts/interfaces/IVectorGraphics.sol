// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

interface IVectorGraphics {
    function metadata() external returns (string memory);

    function image() external view returns (string memory);

    function animation() external returns (string memory);
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../interfaces/IVectorGraphics.sol";
import "../libraries/EthereumStyleSheets.sol";

contract VectorGraphics is IVectorGraphics {
    function metadata() external returns (string memory) {
        string memory name_ = "";
        string memory image_ = image();
        string memory attribute_ = "";
        string memory animation_ = animation();
        string memory description_ = "";

        string memory metadata_ = EthereumStyleSheets.encodeJson(
            bytes(
                abi.encodePacked(
                    '{"name":"',
                    name_,
                    '", "description":"',
                    description_,
                    '", "image": "',
                    image_,
                    '", "attributes": ',
                    "[",
                    attribute_,
                    "]",
                    ', "animation_url": "',
                    animation_,
                    '"}'
                )
            )
        );

        return metadata_;
    }

    function image() public view returns (string memory) {
        //
    }

    function animation() public returns (string memory) {
        //
    }
}

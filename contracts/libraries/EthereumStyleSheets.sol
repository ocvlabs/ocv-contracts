// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../interfaces/IVectorGraphics.sol";

library VectorGraphics {
    function animation(
        string memory _title,
        string memory _style,
        string memory _code,
        string memory _script
    ) public pure returns (string memory) {
        string memory animation_ = string(
            abi.encodePacked(
                "<!DOCTYPE html><html>",
                "<head>",
                _title,
                '<meta http-equiv="content-type" content="text/html; charset=UTF-8" />',
                '<meta charset="UTF-8" /><meta http-equiv="X-UA-Compatible" content="IE=edge" />',
                '<meta name="viewport" content="width=device-width, initial-scale=1.0" />',
                "<style>",
                _style,
                "</style>",
                "</head>",
                "<body>",
                _code,
                "<script>",
                _script,
                "</script>",
                "</body>",
                "</html>"
            )
        );
        return animation_;
    }

    function script(string memory _script) public pure returns (string memory) {
        string memory script_ = string(
            abi.encodePacked("<script>", _script, "</script>")
        );
        return script_;
    }

    function style(string memory _style) public pure returns (string memory) {
        string memory style_ = string(
            abi.encodePacked("<style>", _style, "</style>")
        );
        return style_;
    }

    function image(
        bool onChain,
        address vectorAddress,
        string memory source,
        string memory params
    ) public view returns (string memory) {
        if (onChain) {
            return IVectorGraphics(vectorAddress).image();
        } else {
            string memory image_ = string(
                abi.encodePacked('<img src="', source, '" ', params, " />")
            );
            return image_;
        }
    }

    function div() public pure returns (string memory) {
        return "";
    }

    function h1() public pure returns (string memory) {
        return "";
    }

    function h2() public pure returns (string memory) {
        return "";
    }

    function h3() public pure returns (string memory) {
        return "";
    }

    function h4() public pure returns (string memory) {
        return "";
    }

    function h5() public pure returns (string memory) {
        return "";
    }

    function p() public pure returns (string memory) {
        return "";
    }

    function a() public pure returns (string memory) {
        return "";
    }
}

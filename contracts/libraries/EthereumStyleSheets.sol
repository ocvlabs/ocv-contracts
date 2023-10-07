// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../interfaces/IVectorGraphics.sol";
import "../openzeppelin/Base64.sol";

/// @title Ethereum Style Sheets
library EthereumStyleSheets {
    function encodeSvg(
        string memory _params,
        string memory _content
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(bytes(svg(_params, _content)))
                )
            );
    }

    function encodeJson(
        bytes memory data
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(data)
                )
            );
    }

    function encodeAnimation(
        string memory _title,
        string memory _style,
        string memory _code,
        string memory _script,
        string memory _config
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:text/html;base64,",
                    Base64.encode(
                        bytes(
                            animation(_title, _config, _style, _code, _script)
                        )
                    )
                )
            );
    }

    function animation(
        string memory _title,
        string memory _config,
        string memory _style,
        string memory _code,
        string memory _script
    ) public pure returns (string memory) {
        string memory animation_ = string(
            abi.encodePacked(
                "<!DOCTYPE html><html>",
                "<head><title>",
                _title,
                '</title><meta http-equiv="content-type" content="text/html; charset=UTF-8" />',
                '<meta charset="UTF-8" /><meta http-equiv="X-UA-Compatible" content="IE=edge" />',
                '<meta name="viewport" content="width=device-width, initial-scale=1.0" />',
                _config,
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

    function linkStyleSheet(
        string memory _href
    ) public pure returns (string memory) {
        string memory href_ = string(
            abi.encodePacked('<link rel="stylesheet"', _href, " />")
        );
        return href_;
    }

    function linkScript(
        string memory _src
    ) public pure returns (string memory) {
        string memory src_ = string(
            abi.encodePacked('<script src="</script>', _src, '"></script>')
        );
        return src_;
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

    function svg(
        string memory _params,
        string memory _content
    ) public pure returns (string memory) {
        string memory image_ = string(
            abi.encodePacked(
                '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" ',
                _params,
                ">",
                _content,
                "</svg>"
            )
        );
        return image_;
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

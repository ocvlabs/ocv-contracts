// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../interfaces/IVectorGraphics.sol";
import "../openzeppelin/Base64.sol";

/// @title Ethereum Style Sheets
library EthereumStyleSheets {
    function encodeSvgAsBase64(
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

    function encodeJsonAsBase64(
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

    function encodeHtmlAsBase64(
        string memory _data
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:text/html;base64,",
                    Base64.encode(bytes(_data))
                )
            );
    }

    function encodeAnimation(
        string memory _title,
        string memory _style,
        string memory _markup,
        string memory _setting,
        string memory _script
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:text/html;base64,",
                    Base64.encode(
                        bytes(
                            animation(
                                _title,
                                _style,
                                _markup,
                                _setting,
                                _script
                            )
                        )
                    )
                )
            );
    }

    function animation(
        string memory _title,
        string memory _style,
        string memory _markup,
        string memory _setting,
        string memory _script
    ) public pure returns (string memory) {
        string memory animation_ = string(
            abi.encodePacked(
                "<!DOCTYPE html> <html lang=en> ",
                "<head><title>",
                _title,
                '<meta http-equiv=content-type content="text/html; charset=UTF-8"> <meta charset=UTF-8><meta http-equiv=X-UA-Compatible content="IE=edge"> <meta name=viewport content="width=device-width,initial-scale=1">',
                "<style>",
                _style,
                "</style>",
                "</head>",
                "<body>",
                _markup,
                " ",
                _setting,
                " <script type=module> ",
                _script,
                " </script> </body> </html>"
            )
        );
        return animation_;
    }

    function script(
        string memory _script,
        string memory _src
    ) public pure returns (string memory) {
        string memory script_ = string(
            abi.encodePacked('<script src="', _src, '">', _script, "</script>")
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
            abi.encodePacked('<link rel="stylesheet" href="', _href, '" />')
        );
        return href_;
    }

    function linkScript(
        string memory _src
    ) public pure returns (string memory) {
        string memory src_ = string(
            abi.encodePacked('<script src="', _src, '"></script>')
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
}

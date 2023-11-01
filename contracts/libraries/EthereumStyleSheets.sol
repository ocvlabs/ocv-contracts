// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/// @title Ethereum Style Sheets
/// @author Herald Bayoca - rald@ocvlabs.com
library EthereumStyleSheets {
    string internal constant TABLE_ENCODE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    bytes internal constant TABLE_DECODE =
        hex"0000000000000000000000000000000000000000000000000000000000000000"
        hex"00000000000000000000003e0000003f3435363738393a3b3c3d000000000000"
        hex"00000102030405060708090a0b0c0d0e0f101112131415161718190000000000"
        hex"001a1b1c1d1e1f202122232425262728292a2b2c2d2e2f303132330000000000";

    function encode(bytes memory data) internal pure returns (string memory) {
        if (data.length == 0) return "";

        // load the table into memory
        string memory table = TABLE_ENCODE;

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((data.length + 2) / 3);

        // add some extra buffer at the end required for the writing
        string memory result = new string(encodedLen + 32);

        assembly {
            // set the actual output length
            mstore(result, encodedLen)

            // prepare the lookup table
            let tablePtr := add(table, 1)

            // input ptr
            let dataPtr := data
            let endPtr := add(dataPtr, mload(data))

            // result ptr, jump over length
            let resultPtr := add(result, 32)

            // run over the input, 3 bytes at a time
            for {

            } lt(dataPtr, endPtr) {

            } {
                // read 3 bytes
                dataPtr := add(dataPtr, 3)
                let input := mload(dataPtr)

                // write 4 characters
                mstore8(
                    resultPtr,
                    mload(add(tablePtr, and(shr(18, input), 0x3F)))
                )
                resultPtr := add(resultPtr, 1)
                mstore8(
                    resultPtr,
                    mload(add(tablePtr, and(shr(12, input), 0x3F)))
                )
                resultPtr := add(resultPtr, 1)
                mstore8(
                    resultPtr,
                    mload(add(tablePtr, and(shr(6, input), 0x3F)))
                )
                resultPtr := add(resultPtr, 1)
                mstore8(resultPtr, mload(add(tablePtr, and(input, 0x3F))))
                resultPtr := add(resultPtr, 1)
            }

            // padding with '='
            switch mod(mload(data), 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }
        }

        return result;
    }

    function decode(string memory _data) internal pure returns (bytes memory) {
        bytes memory data = bytes(_data);

        if (data.length == 0) return new bytes(0);
        require(data.length % 4 == 0, "invalid base64 decoder input");

        // load the table into memory
        bytes memory table = TABLE_DECODE;

        // every 4 characters represent 3 bytes
        uint256 decodedLen = (data.length / 4) * 3;

        // add some extra buffer at the end required for the writing
        bytes memory result = new bytes(decodedLen + 32);

        assembly {
            // padding with '='
            let lastBytes := mload(add(data, mload(data)))
            if eq(and(lastBytes, 0xFF), 0x3d) {
                decodedLen := sub(decodedLen, 1)
                if eq(and(lastBytes, 0xFFFF), 0x3d3d) {
                    decodedLen := sub(decodedLen, 1)
                }
            }

            // set the actual output length
            mstore(result, decodedLen)

            // prepare the lookup table
            let tablePtr := add(table, 1)

            // input ptr
            let dataPtr := data
            let endPtr := add(dataPtr, mload(data))

            // result ptr, jump over length
            let resultPtr := add(result, 32)

            // run over the input, 4 characters at a time
            for {

            } lt(dataPtr, endPtr) {

            } {
                // read 4 characters
                dataPtr := add(dataPtr, 4)
                let input := mload(dataPtr)

                // write 3 bytes
                let output := add(
                    add(
                        shl(
                            18,
                            and(
                                mload(add(tablePtr, and(shr(24, input), 0xFF))),
                                0xFF
                            )
                        ),
                        shl(
                            12,
                            and(
                                mload(add(tablePtr, and(shr(16, input), 0xFF))),
                                0xFF
                            )
                        )
                    ),
                    add(
                        shl(
                            6,
                            and(
                                mload(add(tablePtr, and(shr(8, input), 0xFF))),
                                0xFF
                            )
                        ),
                        and(mload(add(tablePtr, and(input, 0xFF))), 0xFF)
                    )
                )
                mstore(resultPtr, shl(232, output))
                resultPtr := add(resultPtr, 3)
            }
        }

        return result;
    }

    function encodeSvgAsBase64(
        string memory _params,
        string memory _content
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    encode(bytes(svg(_params, _content)))
                )
            );
    }

    function encodeJsonAsBase64(
        bytes memory data
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked("data:application/json;base64,", encode(data))
            );
    }

    function encodeHtmlAsBase64(
        string memory _data
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked("data:text/html;base64,", encode(bytes(_data)))
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
                    encode(
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
                "<head> <title>",
                _title,
                '</title> <meta http-equiv=content-type content="text/html; charset=UTF-8"> <meta charset=UTF-8><meta http-equiv=X-UA-Compatible content="IE=edge"> <meta name=viewport content="width=device-width,initial-scale=1">',
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

    function encodeInteractives(
        string memory _style,
        string memory _markup,
        string memory _script,
        string memory _setting
    ) public pure returns (string memory) {
        string memory animation_ = string(
            abi.encodePacked(
                '<!DOCTYPE html> <html lang=en> <head> <title>Encoded by Ethereum Style Sheets (ESS) of OCVLabs.com<meta charset=UTF-8> <meta name=viewport content="width=device-width,initial-scale=1"> <style> ',
                _style,
                " </style> </head> <body> ",
                _markup,
                " ",
                _setting,
                " <script type=module> ",
                _script,
                " </script> </body> </html>"
            )
        );

        return
            string(
                abi.encodePacked(
                    "data:text/html;base64,",
                    encode(bytes(animation_))
                )
            );
    }
}

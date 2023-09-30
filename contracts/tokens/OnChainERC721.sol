// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title ERC-721 with Fully On-Chain Token Data
/// @author raldblox.eth
contract OnChainERC721 is ERC721 {
    uint256 private _tokenIds;
    address private _creator;

    mapping(uint256 => address) assetAddresses;

    constructor() ERC721("OnChainERC721", "ocNFT") {
        _creator = msg.sender;
    }

    function mint(address receiver) public returns (uint256) {
        // NFT Logics
        _safeMint(receiver, _tokenIds);
        _tokenIds++;
        return _tokenIds;
    }

    function tokenURI() public view returns (address) {
        return _creator;
    }

    // PERSONALIZE THIS NFT COLLECTION BY ADDING MORE FUNCTIONS
}

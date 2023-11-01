// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IOnChainAsset {
    function viewAsset() external view returns (string memory);

    function viewAssetType() external view returns (string memory);
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title Allow contracts to mintAsset at assetFactory
/// @author rald@ocvlabs.com
interface IAssetFactory {
    function mintAsset(address, address) external returns (uint256);
}

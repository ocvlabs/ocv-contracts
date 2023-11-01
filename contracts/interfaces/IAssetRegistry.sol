// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title Allow contracts to regiterAsset at assetRegitry
/// @author rald@ocvlabs.com
interface IAssetRegistry {
    function registerAsset(
        address,
        address,
        address
    ) external payable returns (uint256);

    function getMasterAdmin() external view returns (address);
}

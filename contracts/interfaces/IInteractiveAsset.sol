// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title Allow contracts to mintAsset at assetFactory
/// @author rald@ocvlabs.com
interface IInteractiveAsset {
    function viewAssetName() external view returns (string memory);

    function viewAssetImage() external view returns (string memory);

    function viewStyle() external view returns (string memory);

    function viewMarkup() external view returns (string memory);

    function viewSetting() external view returns (string memory);

    function viewScript() external view returns (string memory);

    function totalMint() external view returns (uint256);
}

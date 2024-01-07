//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
interface IPassengersMintingContract {
    function mint(address _to, uint256 _amount) external;
    function attach(address childContractAddress, uint256 childTokenId, uint256 passengerTokenId) external;
    function detach(address childContractAddress, uint256 childTokenId, uint256 passengerTokenId) external;
    function updateCrateAttachmentStatus(uint256 passengerTokenId) external;
}

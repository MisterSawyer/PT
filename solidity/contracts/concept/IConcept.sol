// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

import "contracts/ownable/IOwnable.sol";

interface IConcept is IOwnable
{
    function getName() external view returns(string memory);
    function isScalar() external view returns(bool);
    function getScalarsCount() external view returns (uint32);
    function getSubTreeSize() external view returns (uint32);
    function getCompositesCount() external view returns (uint32);
    function getComposite(uint32 id) external view returns (IConcept);
    function transform(uint32 dimId, uint32 opId, uint32 x) external view returns (uint32);
}
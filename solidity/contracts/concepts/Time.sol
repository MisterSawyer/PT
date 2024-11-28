// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../Concept.sol";
import "../Registry.sol";

contract Time is ConceptBase
{
    string[]      private _composites;

    constructor(address registryAddr) ConceptBase(registryAddr, "Time", _composites)
    {}
}
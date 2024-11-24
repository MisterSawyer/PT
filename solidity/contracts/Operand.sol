// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Registry.sol";

contract CallDef
{
    string[][]      public names;
    uint32[][][]    public args;

    constructor(uint32 dims)
    {
        names = new string[][](dims);
        args = new uint32[][][](dims);
    }

    function getDimensionsCount() external view returns(uint32)
    {
        assert(names.length == args.length);
        return uint32(names.length);
    }

    function getOperandsCount(uint32 dimId) external view returns(uint32)
    {
        require(dimId < this.getDimensionsCount());
        return uint32(names[dimId].length);
    }

    function getArgsCount(uint32 dimId, uint32 opId) external view returns(uint32)
    {
        require(dimId < this.getDimensionsCount());
        require(opId < this.getOperandsCount(dimId));
        return uint32(args[dimId][opId].length);
    }

    function allocate(uint32 dimId, uint32 opCount) external
    {
        require(dimId < names.length && dimId < args.length);
        names[dimId] = new string[](opCount);
        args[dimId] = new uint32[][](opCount);
    }

    function set0(uint32 dimId, uint32 opId, string calldata opName) external
    {
        require(dimId < names.length);
        require(opId < names[dimId].length);

        names[dimId][opId] = opName;
    }

    function set1(uint32 dimId, uint32 opId, string calldata opName, uint32[1] calldata argsArr) external
    {
        require(dimId < names.length && dimId < args.length);
        require(opId < names[dimId].length && opId < args[dimId].length);

        names[dimId][opId] = opName;
        args[dimId][opId] = argsArr;
    }

    function set2(uint32 dimId, uint32 opId, string calldata opName, uint32[2] calldata argsArr) external
    {
        require(dimId < names.length && dimId < args.length);
        require(opId < names[dimId].length && opId < args[dimId].length);

        names[dimId][opId] = opName;
        args[dimId][opId] = argsArr;
    }
}

abstract contract Operand
{
    Registry    private _registry;
    string      private _name;
    uint32      private _argc;

    constructor(address registryAddr, string memory name, uint32 argc)
    {
        require(registryAddr != address(0));
        _registry = Registry(registryAddr);
        
        _name = name;
        _argc = argc;

        _registry.registerOperand(_name, this);
    }
    
    function getArgsCount() external view returns(uint32)
    {
        return _argc;
    }

    function run(uint32 x, uint32[] calldata args) external view virtual returns (uint32);
}
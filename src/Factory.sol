// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "solady/utils/Initializable.sol";
import {LibClone} from "solady/utils/LibClone.sol";
import {Ownable} from "solady/auth/Ownable.sol";
import {Pool} from "./Pool.sol";

contract Factory {
    address public immutable poolImplementation;
    uint256 public poolNonce;

    constructor(address _poolImplementation) {
        poolImplementation = _poolImplementation;
    }

    function createPool() external returns (address poolAddress) {
        _checksBeforeCreation();

        poolAddress = _create();
    }

    function _checksBeforeCreation() internal view {
      // TODO Not implemented
    }

    function _create() internal returns (address poolAddress) {
        bytes32 salt = keccak256(abi.encodePacked(poolNonce));
        poolNonce++;

        poolAddress = LibClone.cloneDeterministic(poolImplementation, salt);
        Pool(poolAddress).initialize();
    }
}

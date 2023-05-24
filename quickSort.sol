// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Simple interface to facilitate usage
interface QuickSort {
    function nameDoesntMatter(
        uint[] calldata arr
    ) external pure returns (uint[] memory);
}

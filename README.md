# Quicksort in Yul

During a gas optimization challenge I had to sort an array spending as little gas as I could.
Naturally I used `Yul` which is much more efficient than `Solidity`.
This smart contract is meant to called by other contracts that require on-chain sorting of `uint`s.

I've implemented several algorithms:

-   Bubble sort
-   Insertion sort
-   Merge sort
-   Quick sort

Quick sort out performed all of the others in the vast majority of cases.

Of course there are several ways to pick a pivot in Quicksort, from my tests using the last element as the pivot saves some `swap`s and therefore saves gas.

Sorting arrays off-chain is the cheapest alternative, but sometimes we need to sort it on-chain.

If you have this flexibility to sort it off-chain, then you just need to check on-chain if the array is sorted and revert the transaction if it isn't.

I will add tests in the future.

## Disclaimer:

### This contract was not audited, so it's not recommended to use it in production

The code is provided as is with <u>**no guarantees**</u>.
If you decide to use this contract in production, you're assuming the risks involved.

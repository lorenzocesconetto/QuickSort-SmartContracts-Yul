// SPDX-License-Identifier: MIT

object "QuickSort" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    
    object "runtime" {
        code {
            function lte(a, b) -> p {
                p := iszero(gt(a, b))
            }

            function swap(a, b) {
                let tmp := mload(a)
                mstore(a, mload(b))
                mstore(b, tmp)
            }

            function quickSort(start, end) {
                let length := sub(add(end, 0x20), start)
                if lt(length, 0x40) { 
                    leave
                }
                if eq(length, 0x40) {
                    if gt(mload(start), mload(end)) {
                        swap(start, end)
                    }
                    leave
                }
                let pivot_value := mload(end)
                let left := start
                let right := sub(end, 0x20)

                for {} true {} {
                    for {} true {} {
                        // If statements are more efficient than switch statements
                        if and(lte(mload(left), pivot_value), lt(left, right)) {
                            left := add(left, 0x20)
                            continue
                        }
                        break
                    }
                    for {} true {} {
                        // If statements are more efficient than switch statements
                        if and(gt(mload(right), pivot_value), lt(left, right)) {
                            right := sub(right, 0x20)
                            continue
                        }
                        break
                    }
                    if lt(left, right) {
                        swap(left, right)
                        continue
                    }
                    break
                }
                switch lt(mload(end), mload(left)) 
                case 1 { 
                    swap(end, left) 
                    quickSort(start, sub(left, 0x20))
                    quickSort(add(left, 0x20), end)
                }
                case 0 {
                    quickSort(start, sub(end, 0x20))
                }
            }
            
            // Calldata will be structured as the following:
            // 4 bytes: function signature (since our contract has only one function, we can ignore this)
            // 0x00: 32 bytes: Array pointer (it'll point at 0x20)
            // 0x20: 32 bytes: Array size
            // 0x40: 32 bytes for each element of the array. They go back to back here
            // Even if the uint is shorter than 256 bits, the calldata standard is to pad with zeros all arguments to fit 32 bytes
            if lt(calldatasize(), 100) { revert(0, 0) } // Prevent underflow, array should have at least one element
            // Total bytes of elements in array
            let size := sub(calldatasize(), 4)

            // Copy array pointer, size and elements from calldata to memory
            for { let i := 0 } lt(i, size) { i := add(i, 0x20) } {
                mstore(i, calldataload(add(4, i)))
            }
            // Array elements storage starts at 0x40
            quickSort(0x40, sub(size, 0x20))
            // The return data must follow the same convention as calldata
            return(0x00, size)
        }
    }
}


import Foundation


func longestMountain(_ A: [Int]) -> Int {
    
    let count = A.count
    
    var dp1 = [Int](repeating: 1, count: count)
    var dp2 = [Int](repeating: 1, count: count)
    
    for var i in 0..<count {
        if i > 0 && A[i] > A[i-1] {
            dp1[i] = dp1[i-1] + 1
        }
        
        if i > 0 && A[count - i] < A[count - i - 1] {
            dp2[count-i-1] = dp2[count-i] + 1;
        }
    }
    
    var res = 0
    
    for i in 0..<count {
        if (dp1[i] > 1 && dp2[i] > 1) {
            res = max(res, dp1[i] + dp2[i] - 1)
        }
    }
    
    return res
}

print(longestMountain([2, 1, 4, 7, 3, 2, 5]))

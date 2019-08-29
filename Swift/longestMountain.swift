// 845. 数组中的最长山脉
// https://leetcode-cn.com/problems/longest-mountain-in-array/

/*
我们把数组 A 中符合下列属性的任意连续子数组 B 称为 “山脉”：
B.length >= 3
存在 0 < i < B.length - 1 使得 B[0] < B[1] < ... B[i-1] < B[i] > B[i+1] > ... > B[B.length - 1]
（注意：B 可以是 A 的任意子数组，包括整个数组 A。）
给出一个整数数组 A，返回最长 “山脉” 的长度。
如果不含有 “山脉” 则返回 0。

示例 1：
输入：[2,1,4,7,3,2,5]
输出：5
解释：最长的 “山脉” 是 [1,4,7,3,2]，长度为 5。

示例 2：
输入：[2,2,2]
输出：0
解释：不含 “山脉”。
提示：
0 <= A.length <= 10000
0 <= A[i] <= 10000
*/

/*
思路：
设dp1[i]是以i为终点的最大递增连续序列的长度，
设dp2[i]是以i为起点的最大递减连续序列的长度，
那么dp1[i]+dp2[i]-1就是i点的山脉长度，其中dp1[i]、dp2[i]根据题目要求，必须都大于1.
*/

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
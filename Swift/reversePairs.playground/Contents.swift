import Foundation
/*
 493. 翻转对
 
 https://leetcode-cn.com/problems/reverse-pairs/
 
 给定一个数组 nums ，如果 i < j 且 nums[i] > 2*nums[j] 我们就将 (i, j) 称作一个重要翻转对。
 
 你需要返回给定数组中的重要翻转对的数量。
 
 示例 1:
 
 输入: [1,3,2,3,1]
 输出: 2
 示例 2:
 
 输入: [2,4,3,5,1]
 输出: 3
 
 注意:
 给定数组的长度不会超过50000。
 输入数组中的所有数字都在32位整数的表示范围内。
*/


// 使用归并排序

func reversePairs(_ nums: inout [Int]) -> Int {
    return mergeSort(&nums, 0, nums.count - 1)
}

func mergeSort(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
    if low == high {
        return 0
    }
    
    let mid = (low + high) / 2;
    
    let leftCount = mergeSort(&nums, low, mid)
    let rightCount = mergeSort(&nums, mid + 1, high)
    
    return leftCount + rightCount + merge(&nums, low, mid, high)
}

func merge(_ nums: inout [Int], _ low: Int, _ mid: Int, _ high: Int) -> Int {
    var i = low
    var l = low
    var j = mid + 1
    var r = mid + 1
    
    let count = high - low + 1
    var temp = [Int](repeating: 0, count: count)
    var index = 0
    
    var reverseCount = 0
    
    while l <= mid && r <= high {
        if nums[l] > 2 * nums[r] {
            reverseCount += mid - l + 1
            r += 1
        } else {
            l += 1
        }
    }
    
    while i <= mid && j <= high {
        if nums[i] < nums[j] {
            temp[index] = nums[i]
            i += 1
        } else {
            temp[index] = nums[j]
            j += 1
        }
        index += 1
    }
    
    while i <= mid {
        temp[index] = nums[i]
        index += 1
        i += 1
    }
    
    while j <= high {
        temp[index] = nums[j]
        index += 1
        j += 1
    }
    
    for m in 0..<count {
        nums[low+m] = temp[m]
    }
    
    return reverseCount
}

var nums = [1, 3, 2, 3, 1]
reversePairs(&nums)

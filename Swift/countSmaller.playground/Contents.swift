import Foundation

/*
 315. 计算右侧小于当前元素的个数
 
 https://leetcode-cn.com/classic/problems/count-of-smaller-numbers-after-self/description/
 
 给定一个整数数组 nums，按要求返回一个新数组 counts。数组 counts 有该性质： counts[i] 的值是  nums[i] 右侧小于 nums[i] 的元素的数量。
 
 
 示例:
 
 输入: [5,2,6,1]
 输出: [2,1,1,0]
 解释:
 5 的右侧有 2 个更小的元素 (2 和 1).
 2 的右侧仅有 1 个更小的元素 (1).
 6 的右侧有 1 个更小的元素 (1).
 1 的右侧有 0 个更小的元素.
 
*/

class CountSmallerTreeNode {
    var count: Int = 0
    var val: Int
    var left: CountSmallerTreeNode?
    var right: CountSmallerTreeNode?
    
    init(val: Int, left: CountSmallerTreeNode? = nil, right: CountSmallerTreeNode? = nil) {
        self.val = val;
        self.left = left;
        self.right = right;
    }
}

class CountSmallerTree {

    var array: [Int] = [];
    
    init(array: [Int]) {
        self.array = array;
    }
    
    var result: [Int] = []
    var root: CountSmallerTreeNode?
    
    func countSmaller() -> [Int] {
        let n = self.array.count
        
        if n <= 0 { return [] }
        result = [Int](repeating: 0, count: n)
        
        for i in 1...n {
            root = insert(root: root, inserted: array[n-i], index: n-i)
        }
        
        return result;
    }
    
    func insert(root: CountSmallerTreeNode?, inserted: Int, index: Int) -> CountSmallerTreeNode {
        guard let root = root else {
            return CountSmallerTreeNode(val: inserted)
        }
        
        if (inserted <= root.val) {
            root.count += 1
            root.left = insert(root: root.left, inserted: inserted, index: index)
        } else if inserted > root.val {
            result[index] += root.count + 1
            root.right = insert(root: root.right, inserted: inserted, index: index)
        }
        
        return root
    }
}


CountSmallerTree(array: [5, 2, 6, 1]).countSmaller()

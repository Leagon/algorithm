import Foundation


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

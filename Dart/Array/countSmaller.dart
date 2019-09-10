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

import '../Tree/TreeNode.dart';

// 时间复杂度 O(n^2)
List<int> countSmaller(List<int> nums) {

  List<int> result = List.filled(nums.length, 0);

  for (int i = 0; i < nums.length; i++) {
    final cur = nums[i];
    for (int j = i + 1; j < nums.length; j ++) {
      final p = nums[j];
      if (p < cur) {
        result[i]++;
      }
    }
  }
  return result;
}

/*
使用二叉搜索树
*/
class CountSmallerTreeNode extends TreeNode {
  int count;
  CountSmallerTreeNode(int val, {dynamic left, dynamic right, this.count = 0}) : super(val);
}

class CountSmallerBST extends BinaryTree {
  CountSmallerBST(List array) : super(array) {
    countSmaller(); 
  }

  List<int> result = [];

  List<int> countSmaller() {
    final n = this.array.length;
    if (n <= 0) return [];

    result = List.filled(n, 0);
    
    // 以最后一个为根节点，倒序
    root = CountSmallerTreeNode(this.array.elementAt(n-1));

    for (int i = 1; i < this.array.length; i++) {
      CountSmallerTreeNode inserted = CountSmallerTreeNode(this.array.elementAt(n-i-1));
      BST_insert(root, inserted, n-1-i);
    }

    return result;
  }

  void BST_insert(CountSmallerTreeNode root, CountSmallerTreeNode insertNode, int index) {
    if (root.val < insertNode.val) {
      result[index] += root.count + 1;
      if (root.left == null) {
        root.left = insertNode;
      } else {
        BST_insert(root.left, insertNode, index);
      }
    } else {
      root.count += 1;
      if (root.right == null) {
        root.right = insertNode;
      } else {
        BST_insert(root.right, insertNode, index);
      }
    }
  }
}

void main() {
  final List<int> nums = [5, 2, 6, 1];
  final res = countSmaller(nums);
  print(res);

  final bst = CountSmallerBST([2, 0, 1]);
  final res2 = bst.countSmaller();
  print(res2);
}
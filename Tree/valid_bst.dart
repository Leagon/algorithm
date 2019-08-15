import 'dart:collection';

import 'TreeNode.dart';

/**
  给定一个二叉树，判断其是否是一个有效的二叉搜索树。

  假设一个二叉搜索树具有如下特征：

  节点的左子树只包含小于当前节点的数。
  节点的右子树只包含大于当前节点的数。
  所有左子树和右子树自身必须也是二叉搜索树。

  二叉搜索树(Binary Search Tree)


  示例 1:

  输入:
    2
   / \
  1   3
  输出: true

  输入:
    5
   / \
  1   4
     / \
    3   6
  输出: false
  解释: 输入为: [5,1,4,null,null,3,6]。根节点的值为 5 ，但是其右子节点值为 4 。
*/

// 中序遍历
bool isValidBST_Inorder(TreeNode root) {
  if (root == null) return true;

  Queue stack = Queue();
  int inorder = -10000;

  while (stack.isNotEmpty || root != null) {
    while (root != null) {
      stack.add(root);
      root = root.left;
    }

    root = stack.removeLast();
    print("before inorder = $inorder, val = ${root.val}");
    if (root.val <= inorder) return false;
    inorder = root.val;
    root = root.right;
  }
  return true;
}

// 递归
bool isValidBST_Recursive(TreeNode root, int lower, int upper) {
  if (root == null) return true;

  int val = root.val;
  if (lower != null && val <= lower) return false;
  if (upper != null && val >= upper) return false;

  if (!isValidBST_Recursive(root.right, val, upper)) return false;
  if (!isValidBST_Recursive(root.left, lower, val)) return false;

  return true;
}


void main() {

  BinaryTree tree = BinaryTree([2,1,3]);
  BinaryTree tree2 = BinaryTree([5,1,4,null,null,3,6]);
  
  print(tree.seqTraverse());
  print(tree2.seqTraverse());

  print(isValidBST_Inorder(tree.root));
  print(isValidBST_Inorder(tree2.root));

  print(isValidBST_Recursive(tree.root, null, null));
  print(isValidBST_Recursive(tree2.root, null, null));
  // print("tree 1 is binary search tree : $")

}


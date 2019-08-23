import 'dart:collection';
import 'dart:math';

import 'TreeNode.dart';

/**
 * 
 * 662. 二叉树最大宽度
 * 
给定一个二叉树，编写一个函数来获取这个树的最大宽度。树的宽度是所有层中的最大宽度。这个二叉树与满二叉树（full binary tree）结构相同，但一些节点为空。

每一层的宽度被定义为两个端点（该层最左和最右的非空节点，两端点间的null节点也计入长度）之间的长度。

示例 1:

输入: 

           1
         /   \
        3     2
       / \     \  
      5   3     9 

输出: 4
解释: 最大值出现在树的第 3 层，宽度为 4 (5,3,null,9)。
示例 2:

输入: 

          1
         /  
        3    
       / \       
      5   3     

输出: 2
解释: 最大值出现在树的第 3 层，宽度为 2 (5,3)。
示例 3:

输入: 

          1
         / \
        3   2 
       /        
      5      

输出: 2
解释: 最大值出现在树的第 2 层，宽度为 2 (3,2)。
示例 4:

输入: 

          1
         / \
        3   2
       /     \  
      5       9 
     /         \
    6           7
输出: 8
解释: 最大值出现在树的第 4 层，宽度为 8 (6,null,null,null,null,null,null,7)。 

*/


int widthOfBinaryTree(TreeNode root) {

  if (root == null) return 0;

  Queue queue = Queue();
  
  queue.add(root);
  int width = 0;

  while (queue.isNotEmpty) {

    // 移除左右两端的null
    while(queue.isNotEmpty && queue.first == null) queue.removeFirst();
    while(queue.isNotEmpty && queue.last == null) queue.removeLast();

    int n = queue.length;
    if (n == 0) break;
    width = max(width, n);

    for (int i = 0; i < n; i++) {
      final node = queue.removeFirst();
      if (node is TreeNode) {
        queue.add(node.left);
        queue.add(node.right);
      } else {
        queue.add(null);
        queue.add(null);
      }
    }
  }
  return width;
}


void main() {
  BinaryTree tree = BinaryTree([1,3,2,5,3,null,9]);
  int rs = widthOfBinaryTree(tree.root);
  print(rs);


  BinaryTree tree2 = BinaryTree([1, 3, null, 5, 3]);
  int rs2 = widthOfBinaryTree(tree2.root);
  print(rs2);

  BinaryTree tree3 = BinaryTree([1, 3, 2, 5, null, null, 9, 6, null, null, null, null, null, null, 7]);
  int rs3 = widthOfBinaryTree(tree3.root);
  print(rs3);

}
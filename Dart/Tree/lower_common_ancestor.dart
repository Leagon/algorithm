
import 'TreeNode.dart';

/** 

给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

示例 1:

输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
输出: 3
解释: 节点 5 和节点 1 的最近公共祖先是节点 3。

示例 2:

输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
输出: 5
解释: 节点 5 和节点 4 的最近公共祖先是节点 5。因为根据定义最近公共祖先节点可以为节点本身。
*/

/*
我们可以使用普通的树遍历来搜索这两个节点。一旦我们达到所需的节点 p 和 q, 我们就可以回溯并找到最近的共同祖先。
*/


/*
先深度遍历改树。当你遇到节点 p 或 q 时，返回一些布尔标记。
该标志有助于确定是否在任何路径中找到了所需的节点。
最不常见的祖先将是两个子树递归都返回真标志的节点。
它也可以是一个节点，它本身是p或q中的一个，对于这个节点,子树递归返回一个真标志。
*/
TreeNode ans;

TreeNode lowestCommonAncestor_binary_tree(TreeNode root, TreeNode p, TreeNode q) {
  recurse(root, p, q);
  return ans;
}

bool recurse(TreeNode root, TreeNode p, TreeNode q) {
  if (root == null) return false;

  int left = recurse(root.left, p, q) ? 1 : 0;
  int right = recurse(root.right, p, q) ? 1 : 0;

  int mid = (root == p || root == q) ? 1 : 0;

  if (mid + left + right >= 2) {
    ans = root;
  }

  return (mid + left + right) > 0;
}


/* 

给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先
示例 1:

输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
输出: 6 
解释: 节点 2 和节点 8 的最近公共祖先是 6。
示例 2:

输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
输出: 2
解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。
*/

TreeNode lowestCommonAncestor_binary_search_tree(TreeNode root, TreeNode p, TreeNode q) {

  int pVal = p.val;
  int qVal = q.val;

  while(root != null) {
    int rootVal = root.val;
    if (rootVal < pVal && rootVal < qVal) {
      root = root.right;
    } else if (rootVal > pVal && rootVal > qVal) {
      root = root.left;
    } else {
      return root;
    }
  }
  return null;
}


void main () {

  BinaryTree tree = BinaryTree([3,5,1,6,2,0,8,null,null,7,4]);
  print(tree.seqTraverse());

  TreeNode rs = lowestCommonAncestor_binary_tree(tree.root, TreeNode(5), TreeNode(1));
  print(rs.val);

  TreeNode rs2 = lowestCommonAncestor_binary_tree(tree.root, TreeNode(5), TreeNode(4));
  print(rs2.val);

  BinaryTree bst = BinaryTree([6,2,8,0,4,7,9,null,null,3,5]);
  print(bst.seqTraverse());

  TreeNode rs3 = lowestCommonAncestor_binary_search_tree(bst.root, TreeNode(2), TreeNode(8));
  print(rs3.val);

  TreeNode rs4 = lowestCommonAncestor_binary_search_tree(bst.root, TreeNode(2), TreeNode(4));
  print(rs4.val);

  //
  print("========== 中序遍历 ==========");
  bst.inOrder(bst.root);
  print(bst.inOrderList);
  print("========== 前序遍历 ==========");
  bst.preOrder(bst.root);
  print(bst.preOrderList);
  print("========== 后序遍历 ==========");
  bst.postOrder(bst.root);
  print(bst.postOrderList);
}
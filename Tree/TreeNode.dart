import 'dart:collection';

class TreeNode {
  int val;
  TreeNode left;
  TreeNode right;
  TreeNode(this.val, {this.left, this.right});

  void setLeft(TreeNode node) => left = node;
  void setRight(TreeNode node) => right = node;

  operator == (dynamic node) => this.val == node.val;
}

class BinaryTree {
  List<dynamic> array;

  BinaryTree(this.array) {
    root = TreeNode(this.array.elementAt(0));
    _buildBinaryTree(root, 0);
  }

  TreeNode root;

  void _buildBinaryTree(TreeNode root, int rootIndex) {

    int lIndex = 2 * rootIndex + 1;
    int rIndex = 2 * rootIndex + 2;

    if (lIndex < this.array.length) {
      final le = this.array.elementAt(lIndex);
      if (le != null) {
        TreeNode lnode = TreeNode(le);
        root.setLeft(lnode);
        _buildBinaryTree(lnode, lIndex);
      }
    }

    if (rIndex < this.array.length) {
      final re = this.array.elementAt(rIndex);
      if (re != null) {
        TreeNode rnode = TreeNode(re);
        root.setRight(rnode);
        _buildBinaryTree(rnode, rIndex);
      }
    }
  }

  // 层序遍历
  List<dynamic> seqTraverse() {
    if (root == null) return null;

    List<dynamic> list = [];

    Queue queue = Queue();
    queue.add(root);

    while(queue.isNotEmpty) {
      TreeNode r = queue.removeFirst();

      list.add(r.val);

      if (r.left != null) {
        queue.add(r.left);
      } 

      if (r.right != null) {
        queue.add(r.right);
      }
    }

    return list;
  }

  // 中序遍历
}
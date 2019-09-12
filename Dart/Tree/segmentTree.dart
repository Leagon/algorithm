/*
线段树


线段树是一种二叉搜索数，与区间树类似，
它将一个区间划分成一些单元区间，每个单元区间对应线段树中的一个叶节点。

                  [1,             10]
                  /                \
            [1,   5]              [6,      10]
           /       \              /         \
       [1,3]      [4,5]       [6, 8]       [9,10]
       /   \       /  \        /  \         /   \
    [1,2] [3,3] [4,4] [5,5] [6,7] [8,8]  [9,9] [10, 10]
    /   \                    /  \
 [1,1] [2,2]              [6,6] [7,7]


对于线段树种每一个非叶子节点 [a,b]，它的左儿子表示区间 [a, (a+b)/2], 右儿子表示区间 [(a+b)/2+1,b]。
因此线段树是平衡二叉树，最后的子节点数目为N，即整个线段树区间的长度。

使用线段树可以快速查找某一个节点在若干条线段中出现的次数，时间复杂度O(logN)。
而未优化的空间复杂度为2N，因此有时需要离散化让空间压缩。


基本结构

线段树是建立在线段的基础上，每个节点代表了一条线段[a,b]。长度为1的线段称为元线段。
非元线段都有两个子节点，左节点代表线段[a,(a+b)/2]，右节点代表线段[(a+b)/2+1,b]。


*/

class SegmentTree<T> {

  List<T> tree;
  List<T> data;

  Function merge;

  SegmentTree(this.data, this.merge) {
    this.tree = new List(this.data.length*4);
    _buildSegmentTree(0, 0, data.length-1);
  }

  /** 
   * @param treeIndex  当前需要添加节点的索引
   * @param treeLeft   左边界
   * @param treeRight  右边界
  */
  void _buildSegmentTree(int treeIndex, int treeLeft, int treeRight) {
    
    if (treeLeft == treeRight) {
      tree[treeIndex] = data[treeLeft];
      return;
    }

    // 当前节点的区间中间点
    int mid = treeLeft + (treeRight - treeLeft) ~/ 2;
    // 当前节点左子树索引
    int leftTreeIndex = getLeft(treeIndex);
    // 当前节点右子树索引
    int rightTreeIndex = getRight(treeIndex);

    // 构建左子树
    _buildSegmentTree(leftTreeIndex, treeLeft, mid);
    // 构建右子树
    _buildSegmentTree(rightTreeIndex, mid+1, treeRight);

    // 当前节点存放的值
    tree[treeIndex] = merge(tree[leftTreeIndex], tree[rightTreeIndex]);
  }

  int getLeft(int index) {
    return index * 2 + 1;
  }

  int getRight(int index) {
    return index * 2 + 2;
  }

  T query(int start, int end) {
    return _query(0, 0, data.length-1, start, end);
  }

  /**
   * @param treeIndex  当前查找的节点
   * @param treeLeft   左边界
   * @param treeRight  右边界
   * @param queryL     用户需要查找的左边界
   * @param queryR     用户需要查找的右边界
   */
  T _query(int treeIndex, int treeLeft, int treeRight, int queryL, int queryR) {

    // 1. 需要查找的范围刚好在这个treeIndex节点区间
    if (treeLeft == queryL && treeRight == queryR) {
      return tree[treeIndex];
    }

    // 当前节点的区间中间点
    int mid = treeLeft + (treeRight - treeLeft) ~/ 2;
    // 当前节点左子树索引
    int leftTreeIndex = getLeft(treeIndex);
    // 当前节点右子树索引
    int rightTreeIndex = getRight(treeIndex);

    
    // 2. 需要查找的范围完全在左子树区间
    if (queryR <= mid) {
      return _query(leftTreeIndex, treeLeft, mid, queryL, queryR);
    }

    // 3. 需要查找的范围完全在右子树区间
    if (queryL >= mid + 1) {
      return _query(rightTreeIndex, mid+1, treeRight, queryL, queryR);
    }

    // 4. 需要查找的范围一部分在左子树，一部分在右子树
    T left = _query(leftTreeIndex, treeLeft, mid, queryL, queryR);
    T right = _query(rightTreeIndex, mid+1, treeRight, queryL, queryR);

    return merge(left, right);
  }

  void update(int index, T e) {
    data[index] = e;
    _update(0, 0, data.length-1, index, e);
  }

  void _update(int treeIndex, int treeLeft, int treeRight, int index, T e) {
    if (treeLeft == treeRight) {
      tree[treeIndex] = e;
      return;
    }

    int mid = treeLeft + (treeRight - treeLeft) ~/ 2;
    int leftTreeIndex = getLeft(treeIndex);
    int rightTreeIndex =  getRight(treeIndex);

    if (index <= mid) {
      _update(leftTreeIndex, treeLeft, mid, index, e);
    } else if (index >= mid + 1) {
      _update(rightTreeIndex, mid + 1, treeRight, index, e);
    }

    // 更新完叶子节点后需要对所有根节点更新
    tree[treeIndex] = merge(tree[leftTreeIndex], tree[rightTreeIndex]);
  }
  
  @override
  String toString() {
    StringBuffer res = StringBuffer();
    res.write("[");
    for (int i = 0; i < tree.length; i++) {
      if (tree[i] != null) {
        res.write(tree[i]);
      } else {
        res.write("null");
      }

      if (i != tree.length - 1) {
        res.write(", ");
      }
    }
    res.write("]");
    return res.toString();
  }
}

void main() {

  int merger(int a, int b) => a + b;
  SegmentTree tree = SegmentTree([1,2,3,4,5,6,7,8,9,10], merger);

  print(tree);
}
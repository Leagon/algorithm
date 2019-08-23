// 使用dart实现优先队列

/*
当在一个循环中插入数组元素，同时需要对数组进行排序，在当前循环中按优先级获取数组的元素进行相关操作
如果将插入和排序分为两个步骤，很有可能 Time Limit Exceeded
这就需要一种数据结构：在插入操作的过程中，元素已被放置在正确的排序位置上，插入元素后可以直接按优先级获取数组的元素。
优先队列PriorityQueue可以显示这种功能。
在优先队列中，元素被赋予优先级。最大值或最小值都可以被定义为优先级。
当优先队列的元素并非简单的Int类型，而是多维数组或元组等其他数据结构，可以自定义优先级。
*/

/*
1. 满二叉树
定义：一个二叉树的所有非叶子节点都存在左右孩子，并且所有的叶子节点都在同一层级

2. 完全二叉树
定义：对一个有n个节点的二叉树，按层级顺序编号，则所有节点的编号为从1到n。如果这个树所有节点和同样深度的满二叉树的编号为1到n的节点位置相同，则这个二叉树为完全二叉树。

3. 二叉堆
二叉堆本质是一种完全二叉树

最大堆：任何一个父节点的值都大于等于它左、右孩子节点的值
最小堆：任何一个父节点的值都小于等于它左、右孩子节点的值

堆顶：二叉堆的根节点
最大堆的堆顶是整个堆中的最大元素
最小堆的堆顶是整个堆中的最小元素

4. 二叉堆的操作

4.1 插入节点：上浮
二叉堆插入节点时，插入位置是完全二叉树的最后一个位置
此时，比较新节点和其父节点，是否符合最大堆或最小堆的定义
若不符合则和父节点交换位置，即上浮
重复这样的过程，直到不需要交换位置

4.2 删除节点：下沉
二叉堆删除节点的过程和插入节点的过程正好相反
删除节点是堆顶的节点。删除堆顶后，堆顶空缺
为了维持完全二叉树的结构，把堆的最后一个节点，替补到堆顶空缺的位置。
让堆顶节点和其左右孩子进行比较，是否符合最大堆或最小堆的定义
若不符合则和左右孩子交换位置，即下沉

两种二叉堆的比较方法
  最小堆：取左右孩子几点钟最小的一个交换下沉
  最大堆：取左右孩子节点中最大的一个交换下沉

4.3 构建二叉堆
把一个无序的完全二叉树调整为二叉堆
本质是：让所有非叶子节点依次执行下沉操作

5. 二叉堆操作的时间复杂度
二叉堆插入操作是单一节点的上浮
二叉堆删除操作是单一节点的下沉
这两个操作的平均交换次数都是堆高的一半

二叉堆操作的时间复杂度
插入：O(logn)
删除：O(logn)
构建：O(n)

6. 二叉堆的物理存储
二叉堆虽然是一个完全二叉树，但是其使用的是顺序存储。
二叉堆的所有几点都存储在数组当中。

假设父节点的下标是p,则
左孩子下标：2p+1
右孩子下标：2p+2

7. 总结
在优先队列中，元素被赋予优先级，当访问元素时，具有最高优先级的元素最先删除。最高的优先级，即堆顶节点。
根据二叉堆具有最大堆和最小堆。响应的优先级队列也有两种。

最大优先队列：由最大堆实现，当前最大元素优先出队
最小优先队列：由最小堆实现，当前最小元素优先出队

8. 通用优先队列
将优先队列的控制权限进行自定义
*/

class PriorityQueue<T> {
  Heap heap;
  PriorityQueue.Priority(Function sort): heap = Heap(sort);

  bool get isEmpty => heap.isEmpty;
  int get length => heap.length;
  T peek() => heap.peek();

  void push(T element) => heap.insert(element);
  T pop() => heap.remove();

  int indexOf(T element) => heap.indexOf(element);
}

class Heap<T> {
  List<T> nodes;
  Function orderCriteria;

  Heap(this.orderCriteria) : nodes = [];
  Heap.Node(this.nodes, this.orderCriteria) {
    _configreHeap();
  }

  void _configreHeap() {
    for (int i = nodes.length ~/ 2 - 1; i >= 0; i--) {
      _shiftDown(i);
    }
  }

  bool get isEmpty => nodes.isEmpty;
  int get length => nodes.length;
  int _parentIndex({int ofIndex}) => (ofIndex - 1) ~/ 2;
  int _leftChildIndex({int ofIndex}) => 2 * ofIndex + 1;
  int _rightChildIndex({int ofIndex}) => 2 * ofIndex + 2;
  T peek() => nodes.first;
  int indexOf(T element) {
    return nodes.indexOf(element);
  }

  void insert(T value) {
    nodes.add(value);
    _shiftUp(this.length - 1);
  }

  void insertSequence(List<T> sequence) {
    for (var value in sequence) {
      insert(value);
    }
  }

  void replace({int index, T value}) {
    if (index < this.length) {
      return;
    }
    removeAt(index: index);
    insert(value);
  }

  T remove() {
    if (this.isEmpty) return null;
    if (this.length == 1) return nodes.removeLast();
    final value = nodes[0];
    nodes[0] = nodes.removeLast();
    _shiftDown(0);
    return value;
  }

  T removeAt({int index}) {
    if (index < this.length) return null;
    if (index != this.length - 1) {
      swap(atIndex: index, andIndex: this.length - 1);
      _shiftDownFrom(index: index, endIndex: this.length - 1);
      _shiftUp(index);
    }
    return nodes.removeLast();
  }

  void swap({int atIndex, int andIndex}) {
    final temp = nodes[atIndex];
    nodes[atIndex] = nodes[andIndex];
    nodes[andIndex] = temp;
  }

  void _shiftDownFrom({int index, int endIndex}) {
    final leftChildIndex = _leftChildIndex(ofIndex: index);
    final rightChildIndex = leftChildIndex + 1;

    var first = index;
    if (leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first])) {
      first = leftChildIndex;
    }
    if (rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first])) {
      first = rightChildIndex;
    }
    if (first == index) return;
    swap(atIndex: index, andIndex: first);
    _shiftDownFrom(index: first, endIndex: endIndex);
  }

  void _shiftDown(int index) {
    _shiftDownFrom(index: index, endIndex: this.length);
  }

  void _shiftUp(int index) {
    var childIndex = index;
    final child = nodes[childIndex];
    var parentIndex = _parentIndex(ofIndex: childIndex);

    while (childIndex > 0 && orderCriteria(child, nodes[parentIndex])) {
      nodes[childIndex] = nodes[parentIndex];
      childIndex = parentIndex;
      parentIndex = _parentIndex(ofIndex: childIndex);
    }
    nodes[childIndex] = child;
  }
}
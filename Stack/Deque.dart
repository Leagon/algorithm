// 双端队列

// 在数组中预留一定的空间，使用head和tail标记头部和尾部index
// 在数据发生插入和删除时，对空白的空间进行操作，然后移动head或者tail
// 如果超过数组范围大小，则需要扩大数组

class Deque<T> {

  List<T> array;
  int head;
  int capacity;
  int originCapacity;

  Deque(this.capacity): array = List.filled(capacity, null, growable: true), head = capacity, originCapacity = capacity;

  int get length {
    return array.length - head;
  }

  bool get isEmpty {
    return length == 0;
  }

  void addLast(T value) {
    array.add(value);
  }

  T removeLast() {
    if (isEmpty) return null;
    return array.removeLast();
  }

  void addFirst(T value) {

    // 空间不够用，增加2倍空间
    if (head == 0) {
      capacity *= 2;
      final emptySpace = List.filled(capacity, null);
      array.insertAll(0, emptySpace);
      head = capacity;
    }

    head -= 1;
    array[head] = value;
  }

  T removeFirst() {
    if (isEmpty) return null;
    
    final element = array[head];
    if (element == null) return null;

    array[head] = null;
    head += 1;

    // 空白区间太多，减少2/3的空间
    if (capacity >= originCapacity && head >= capacity*2) {
      final amountToRemove = capacity + capacity ~/ 2;
      array.removeRange(0, amountToRemove);
      head -= amountToRemove;
      capacity ~/= 2;
    }

    return element;
  }

  T peekFirst() {
    if (isEmpty) return null;
    return array[head];
  }

}

List<int> maxSlidingWindow(List<int> nums, int k) {

  List<int> rs = [];

  Deque queue = Deque<int>(k+1);

  queue.array.forEach((e) => print(e));

  for (int i = 0; i < nums.length; i++) {
    final element = nums[i];
    queue.addLast(element);

    if (queue.length > k) {
      queue.removeFirst();
    }

    while (element > queue.peekFirst()) {
      queue.removeFirst();
    }

    if (i < k-1) {
      //最前面几个不考虑输出
      continue;
    }

    rs.add(queue.peekFirst());
  }

  return rs;
}

void main() {
  final rs = maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3);
  print(rs);
}
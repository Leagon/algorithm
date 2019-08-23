
// 最大优先队列
// class PriorityQueue {

//   List<int> array;
//   int size;

//   PriorityQueue() : array = List.filled(32, 0, growable: true), size = 0;

//   // 入队操作
//   void enQueue(int value) {
//       array[size] = value;
//       size += 1;
//       upAdjust();   //上浮
//   }

//   // 出队操作
//   int deQueue() {
//     final head = array[0];
//     size -= 1;
//     array[0] = array[size];
//     downAdjust();   // 下沉操作
//     return head;
//   }

//   // 上浮调整
//   void upAdjust() {
//     int childIndex = size - 1;
//     int parentIndex = (childIndex - 1) ~/ 2;
//     print("test1 index = $parentIndex");
//     final temp = array[childIndex]; //temp保存插入的叶子节点的值，用于最后的赋值

//     while(childIndex > 0 && temp > array[parentIndex]) {
//       // 无需真正交换，单向赋值即可
//       array[childIndex] = array[parentIndex];
//       childIndex = parentIndex;
//       parentIndex = parentIndex ~/ 2;
//       print("test2 index = $parentIndex");
//     }
//     array[childIndex] = temp;
//   }

//   // 下沉调整
//   void downAdjust() {
//     int parentIndex = 0;
//     int temp = array[parentIndex];
//     int childIndex = 1;

//     while (childIndex < size) {
//       // 如果有右孩子，且右孩子大于左孩子的值，则定位到右孩子
//       if (childIndex + 1 < size && array[childIndex + 1] > array[childIndex]) {
//         childIndex += 1;
//       }
//       // 如果父节点大于任何一个孩子的值，直接跳过
//       if (temp >= array[childIndex]) break;
//       array[parentIndex] = array[childIndex];
//       parentIndex = childIndex;
//       childIndex = 2 * childIndex + 1;
//     }
//     array[parentIndex] = temp;
//   }
// }

import 'PriorityQueue.dart';

void main() {
  bool sort(int a, int b) => a < b;
  PriorityQueue queue = PriorityQueue<int>.Priority(sort);
  queue.push(0);
  queue.push(9);
  queue.push(1);
  queue.push(8);
  queue.push(3);

  print(queue.pop());
  print(queue.pop());
  print(queue.pop());
  print(queue.pop());
  print(queue.pop());
}
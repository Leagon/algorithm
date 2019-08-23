// 给定一个链表，判断链表中是否有环。
// 为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。
// 示例

/*
输入：head = [3,2,0,-4], pos = 1
输出：true
解释：链表中有一个环，其尾部连接到第二个节点。

输入：head = [1,2], pos = 0
输出：true
解释：链表中有一个环，其尾部连接到第一个节点。

输入：head = [1], pos = -1
输出：false
解释：链表中没有环。
*/

class LinkNode {
  num val = 0;
  LinkNode next;
  LinkNode(this.val);
  void printInfo() => print("$val");
  bool operator == (dynamic o) => val == o.val;
}

void printInfo(LinkNode head) {
  var p = head;
  while(p != null) {
    p.printInfo();
    p = p.next;
  }
}

void main() {
  final a = LinkNode(1);
  final b = LinkNode(2);
  final c = LinkNode(3);
  final d = LinkNode(4);
  final e = LinkNode(5);

  a.next = b;
  b.next = c;
  c.next = d;
  d.next = e;
  e.next = c; //有环

  final head = a;

  var r = hasCycle(head);
  print(r);
}

// 给定一个链表，判断链表中是否有环。

/* 
  1. 硬做
  设置0.5秒，没有null
  2. Set
  将每个val设置在Set中，每次判断是否重复，时间复杂度O(n)，空间复杂度O(n)
  3. 快慢指针
  快指针每次走两步，慢指针每次走一步，如果有环，一定会相遇。时间复杂度O(n)，空间复杂度O(1)
*/
bool hasCycle(LinkNode head) {
  var fast = head;
  var slow = head;

  while (fast != null && slow != null && fast.next != null) {
    slow = slow.next;
    fast = fast.next.next;
    
    if (fast == slow) {
      return true;
    }
  }
  return false;
}
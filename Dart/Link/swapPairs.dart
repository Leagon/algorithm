// 两两交换链表中的节点
// 给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。
// 示例
/*
初始:1->2->3->4
交换后:2->1->4->3
如果有奇数个节点，则最后一个节点不变
*/

class LinkNode {
  num val = 0;
  LinkNode next;
  LinkNode(this.val);
  void printInfo() => print("$val");
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

  final head = a;
  printInfo(head);

  var r = swapPairs(head);
  printInfo(r);
}

// 两两交换链表中的节点
LinkNode swapPairs(LinkNode head) {

  var pre = LinkNode(0);
  pre.next = head;
  var h = pre;

  while(pre.next != null && pre.next.next != null) {
    var a = pre.next;
    var b = a.next;
    a.next = b.next;
    b.next = a;
    pre.next = b;
    pre = a;
  }
  return h.next;
}
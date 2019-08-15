// 反转一个单链表。
// 输入: 1->2->3->4->5->NULL
// 输出: 5->4->3->2->1->NULL

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

  var r = reverseLink(head);
  printInfo(r);
}

// 反转一个单链表
LinkNode reverseLink(LinkNode head) {

  var cur = head;
  var pre;
  var temp;

  while(cur != null) {
    temp = cur;
    cur = cur.next;
    temp.next = pre;
    pre = temp;
  }

  return pre;

}
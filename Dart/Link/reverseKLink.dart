//K 个一组翻转链表
/*
给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。

k 是一个正整数，它的值小于或等于链表的长度。

如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
*/

// 示例
/*
  给定这个链表：1->2->3->4->5

  当 k = 2 时，应当返回: 2->1->4->3->5
  当 k = 3 时，应当返回: 3->2->1->4->5
*/

class LinkNode {
  num val = 0;
  LinkNode next;
  LinkNode(this.val);
  void printInfo() => print("val = $val");
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

  final head = a;
  printInfo(head);

  print("k = 2");
  var r = reverseKGroup(head, 2);
  printInfo(r);

  // print("k = 3");
  // var r2 = reverseKGroup(head, 3);
  // printInfo(r2);
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

// 按K组翻转链表
LinkNode reverseKGroup(LinkNode head, num k) {

  final origin = LinkNode(0);
  origin.next = head;
  
  var pre = origin;
  var tail = origin;

  num count = 0;

  while(tail.next != null) {

    if (count < k) {
      count++;
      tail = tail.next;
    } else {
      var start = pre.next;
      var temp = tail.next;
      tail.next = null;
      pre.next = reverseLink(start);
      start.next = temp;
      
      pre = start;
      tail = pre;
      count = 0;
    }
  }
  return origin.next;
}
// 20. 有效的括号 https://leetcode-cn.com/problems/valid-parentheses

/**
给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：

左括号必须用相同类型的右括号闭合。
左括号必须以正确的顺序闭合。
注意空字符串可被认为是有效字符串。
 * */

import 'dart:collection';

/**
示例 1:
输入: "()"
输出: true

示例 2:
输入: "()[]{}"
输出: true

示例 3:
输入: "(]"
输出: false

示例 4:
输入: "([)]"
输出: false

示例 5:
输入: "{[]}"
输出: true
 * 
 */


bool isValid(String S) {
  Map mapping = <String, String>{')':'(', '}':'{', ']':'['};

  Queue stack = Queue();

  for (int i = 0; i < S.length; i++) {
    var c = S[i];
    if (mapping.containsKey(c)) {
      var topElement = stack.isEmpty ? '#' : stack.removeLast();
      if (topElement != mapping[c]) {
        return false;
      }
    } else {
      stack.addLast(c);
    }
  }
  return stack.isEmpty;
}

void main() {
  final r1 = isValid("()[]{}");
  print(r1);
  
  final r2 = isValid("([)]");
  print(r2);
}
// 给定 S 和 T 两个字符串，当它们分别被输入到空白的文本编辑器后，判断二者是否相等，并返回结果。 # 代表退格字符。

// 1 <= S.length <= 200
// 1 <= T.length <= 200
// S 和 T 只含有小写字母以及字符 '#'。

// 示例

import 'dart:collection';

/**
输入：S = "ab#c", T = "ad#c"
输出：true
解释：S 和 T 都会变成 “ac”。

输入：S = "ab##", T = "c#d#"
输出：true
解释：S 和 T 都会变成 “”。

输入：S = "a##c", T = "#a#c"
输出：true
解释：S 和 T 都会变成 “c”。

输入：S = "a#c", T = "b"
输出：false
解释：S 会变成 “c”，但 T 仍然是 “b”。
*/

bool backspaceCompare(String S, String T) {
  Queue s = Queue();
  for (int i = 0; i < S.length; i++) {
    if (S[i] == '#') {
      if (s.isEmpty) {
        continue;
      } else {
        s.removeLast();
      }
    } else {
      s.addLast(S[i]);
    }
  }

  Queue t = Queue();
  for (int j = 0; j < T.length; j++) {
    if (T[j] == '#' ) {
      if (t.isEmpty) {
        continue;
      } else {
        t.removeLast();
      }
    } else {
      t.addFirst(T[j]);
    }
  }

  // 判断t和s
  if (s.length != t.length) {
    return false;
  }

  for (int k = 0; k < s.length; k++) {
    if (s.removeLast() == t.removeLast()) {
      continue;
    } else {
      return false;
    }
  }

  return true;
}

void main() {
  var r1 = backspaceCompare("ab#c", "ad#c");
  print(r1);

  var r2 = backspaceCompare("ab##", "c#d#");
  print(r2);

  var r3 = backspaceCompare("a##c", "#a#c");
  print(r3); 

  var r4 = backspaceCompare("a#c", "b");
  print(r4);
}
// 242. 有效的字母异位词

/*
给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

示例 1:

输入: s = "anagram", t = "nagaram"
输出: true


示例 2:

输入: s = "rat", t = "car"
输出: false

说明:
你可以假设字符串只包含小写字母。
*/

// 思路一 ： 排序
bool isAnagram(String s, String t) {
  if (s.length != t.length) {
    return false;
  }

  var ss = List.from(s.codeUnits);
  ss.sort();
  print(ss);

  var tt = List.from(t.codeUnits);
  tt.sort();
  print(tt);
  return ss.toString() == tt.toString();
}

// 思路二 ： Map
bool isAnagram2(String s, String t) {
  if (s.length != t.length) return false;

  var smap = Map<int, int>();
  var tmap = Map<int, int>();
  for (int i = 0; i < s.length; i++) {
    final se = s.codeUnitAt(i);
    final te = s.codeUnitAt(i);

    final st = smap[se];
    smap[se] = st == null ? 1 : st + 1;

    final tt = tmap[te];
    tmap[te] = tt == null ? 1 : tt + 1;
  }

  print(smap.toString());
  return smap.toString() == tmap.toString();

}

void main() {
  final sortedResult = isAnagram("anagram", "nagaram");
  print(sortedResult);

  final mapResult = isAnagram2("anagram", "nagaram");
  print(mapResult);

}
/*
29. 两数相除
https://leetcode-cn.com/problems/divide-two-integers/

给定两个整数，被除数 dividend 和除数 divisor。将两数相除，要求不使用乘法、除法和 mod 运算符。

返回被除数 dividend 除以除数 divisor 得到的商。

示例 1:

输入: dividend = 10, divisor = 3
输出: 3
示例 2:

输入: dividend = 7, divisor = -3
输出: -2
说明:

被除数和除数均为 32 位有符号整数。
除数不为 0。
假设我们的环境只能存储 32 位有符号整数，其数值范围是 [−231,  231 − 1]。本题中，如果除法结果溢出，则返回 231 − 1。

*/

int divide(int dividend, int divisor) {

  // 除数不能为0
  if (divisor == 0) return null;

  // 判断符号位
  bool pos = dividend * divisor > 0 ? true : false;

  final positiveDividend = dividend.abs();
  final positiveDivisor = divisor.abs();

  final res = binarySearch(positiveDividend, positiveDivisor, 1, positiveDivisor);

  return res;
}

int binarySearch(int dividend, int divisor, int start, int end) {
  final mid = (start + end) ~/ 2;

  if (mid * divisor < dividend && (mid+1)*divisor > dividend) {
    return mid;
  }

  if (start >= end) {
    return null;
  }

  if (mid * divisor > dividend) {
    return binarySearch(dividend, divisor, start, mid-1);
  } else {
    return binarySearch(dividend, divisor, mid+1, end);
  }
}

void main() {
  final res = divide(10, 3);
  print(res);
}
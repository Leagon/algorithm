/*
实现 pow(x, n) ，即计算 x 的 n 次幂函数。

示例 1:
输入: 2.00000, 10
输出: 1024.00000

示例 2:
输入: 2.10000, 3
输出: 9.26100

示例 3:
输入: 2.00000, -2
输出: 0.25000
解释: 2^-2 = (1/2)^2 = 1/4 = 0.25


说明:
-100.0 < x < 100.0
n 是 32 位有符号整数，其数值范围是 [−231, 231 − 1] 。

*/


// 递归算法
double fastPow(double x, int n) {
  if (n == 0) return 1.0;
  if (n == 1) return x;

  double half = fastPow(x, n~/2);
  
  if (n % 2 == 0) {
    return half * half;
  } else {
    return half * half * x;
  }
}

double myPow(double x, int n) {

  if (n < 0) {
    x = 1 / x;
    n = -n;
  }

  return fastPow(x, n);

}

// 幂算法

double myPow2(double x, int n) {
  if (n < 0) {
    x = 1 / x;
    n = -n;
  }

  var rs = 1.0;
  var current = x;
  for (int i = n; i != 0; i ~/= 2) {
    if (i % 2 == 1) {
      rs = rs * current;
    }
    current = current * current;
  }
  return rs;
}


void main() {
  print(myPow(2, 10));
  print(myPow(2.1, 3));
  print(myPow(2, -2));


  print(myPow2(2, 10));
  print(myPow2(2.1, 3));
  print(myPow2(2, -2));
}
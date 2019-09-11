/*
493. 翻转对

https://leetcode-cn.com/problems/reverse-pairs/

给定一个数组 nums ，如果 i < j 且 nums[i] > 2*nums[j] 我们就将 (i, j) 称作一个重要翻转对。

你需要返回给定数组中的重要翻转对的数量。

示例 1:

输入: [1,3,2,3,1]
输出: 2
示例 2:

输入: [2,4,3,5,1]
输出: 3

注意:
给定数组的长度不会超过50000。
输入数组中的所有数字都在32位整数的表示范围内。
*/

// 归并排序

int reversePairs(List<int> nums) {
  return mergeSort(nums, 0, nums.length-1);
}

int mergeSort(List<int> nums, int low, int high) {
  if (low == high) return 0;

  final mid = (low + high) ~/ 2;

  final leftCount = mergeSort(nums, low, mid);
  final rightCount = mergeSort(nums, mid+1, high);
  return leftCount + rightCount + merge(nums, low, mid, high);
}

int merge(List<int> nums, int low, int mid, int high) {

  int i = low;
  int l = low;
  int j = mid + 1;
  int r = mid + 1;

  int count = high - low + 1;
  var temp = List.filled(count, 0);
  var index = 0;

  var reverseCount = 0;

  while (l <= mid && r <= high) {
    if (nums[l] > 2 * nums[r]) {
      reverseCount += mid - l + 1;
      r++;
    } else {
      l++;
    }
  }

  while (i <= mid && j <= high) {

    if (nums[i] < nums[j]) {
      temp[index++] = nums[i++];
    } else {
      temp[index++] = nums[j++];
    }
  }

  while (i <= mid) {
    temp[index++] = nums[i++];
  }

  while (j <= high) {
    temp[index++] = nums[j++];
  }

  for (int m = 0; m < count; m++) {
    nums[low+m] = temp[m];
  }

  return reverseCount;
}

void main() {
  print(reversePairs([1,3,2,3,1]));
  print(reversePairs([2,4,3,5,1]));
}
/*
167. 两数之和 II - 输入有序数组

给定一个已按照升序排列 的有序数组，找到两个数使得它们相加之和等于目标数。

函数应该返回这两个下标值 index1 和 index2，其中 index1 必须小于 index2。

说明:

返回的下标值（index1 和 index2）不是从零开始的。
你可以假设每个输入只对应唯一的答案，而且你不可以重复使用相同的元素。
示例:

输入: numbers = [2, 7, 11, 15], target = 9
输出: [1,2]
解释: 2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。
*/


List<int> twoSum(List<int> nums, int target) {

  for (int i = 0; i < nums.length; i++) {
    final current = nums[i];
    final remained = target - current;

    final r = binarySearch(nums, remained, i+1, nums.length-1);
    if (r != null) {
      return [i+1, r+1];
    }
  }
  return null;
}

int binarySearch(List<int> nums, int target, int start, int end) {

  final mid = (start + end) ~/ 2;
  final midVal = nums[mid];

  if (target == midVal) {
    return mid;
  }

  if (start >= end) {
    return null;
  }

  if (midVal > target) {
    return binarySearch(nums, target, start, mid-1);
  } else if (midVal < target) {
    return binarySearch(nums, target, mid+1, end);
  }
}


void main() {
  final numbers = [2, 7, 11, 15];
  final res = twoSum(numbers, 9);
  print(res);

  final numbers2 = [12,13,23,28,43,44,59,60,61,68,70,86,88,92,124,125,136,168,173,173,180,199,212,221,227,230,277,282,306,314,316,321,325,328,336,337,363,365,368,370,370,371,375,384,387,394,400,404,414,422,422,427,430,435,457,493,506,527,531,538,541,546,568,583,585,587,650,652,677,691,730,737,740,751,755,764,778,783,785,789,794,803,809,815,847,858,863,863,874,887,896,916,920,926,927,930,933,957,981,997];
  final res2 = twoSum(numbers2, 542);
  print(res2);
}
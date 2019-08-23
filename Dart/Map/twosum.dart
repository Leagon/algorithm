/*
  给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

  你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

  示例:

  给定 nums = [2, 7, 11, 15], target = 9

  因为 nums[0] + nums[1] = 2 + 7 = 9
  所以返回 [0, 1]
*/

List<int> twoSum_on2(List<int> nums, int target) {

  for (int i = 0; i < nums.length; i++) {
    for (int j = 1; j < nums.length; j++) {
      if (nums[i] + nums[j] == target) {
        return [i, j];
      }
    }
  }

  return null;
}


List<int> twoSum(List<int> nums, int target) {

  Map<int, int> map = {};

  for(int i = 0; i < nums.length; i++) {
    final int remind = target - nums[i];
    if (map[remind] == null) {
      map[nums[i]] = i;
    } else {
      return [map[remind], i];
    }
  }

  return null;
}


void main() {
  final nums = [2, 7, 11, 15];
  final rs = twoSum_on2(nums, 9);
  print("on2 result is : $rs");

  final rs2 = twoSum(nums, 9);
  print("on1 result is : $rs2");
}
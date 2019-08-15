/*
  给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。

  注意：答案中不可以包含重复的三元组。

  例如, 给定数组 nums = [-1, 0, 1, 2, -1, -4]，

  满足要求的三元组集合为：
  [
    [-1, 0, 1],
    [-1, -1, 2]
  ]
*/


// 暴力解法，三层for循环嵌套，时间复杂度O(n^3)
List<List<int>>threeSum_on3(List<int> nums, int target) {

  Set<List<int>> list = {};

  for (int i = 0; i < nums.length; i++) {
    for (int j = i+1; j < nums.length; j++) {
      for (int k = j+1; k < nums.length; k++) {
        if (nums[i] + nums[j] + nums[k] == target && i != j && j != k && i != k) {
          list.add([nums[i], nums[j], nums[k]]);
        }
      }
    }
  }

  return list.toList();
}

// 使用Map, c=target-(a+b), 时间复杂度O(n^2), 空间复杂度O(N)
List<List<int>>threeSum_on2(List<int> nums, int target) {
  
  List<List<int>> list = [];
  Map<int, int> map = {};

  for (int i = 0; i < nums.length; i++) {
    for (int j = i + 1; j < nums.length; j++) {
      final int remind = target - (nums[i] + nums[j]);
      final int index = map[remind];
      if (index == null) {
        map[nums[i]] = i;
        map[nums[j]] = j;
      } else if (i != index && j != index) {
        list.add([nums[i], nums[j], remind]);
      }
    }
  }

  return list;
}

// 不使用Map，时间复杂度O(n^2)，空间复杂度O(1)
/* 
提前结束一些不可能的组合, 
首先安排所有人按照顺序排队站好，这是一个需要花时间的操作，不过磨刀不误砍柴工，付出这个时间还是值得的。
然后我们选择一个人做C位，既然是C位，那么就需要左右各有一个人。
先选择队伍最左边（最小值）和队伍最右边（最大值）两个人，加上你，算一下总和。如果大于 0，说明实力太强了，就把就把右侧的人选调左一位，反之，则调整左边的人选，增强一下实力。
当某边选到紧挨着你的人的时候，就意味着组队结束，以你为 C位的所有可能都已经尝试完毕了。
*/

List<List<int>>threeSum_on(List<int> nums, int target) {
  List<List<int>> list = [];

  // 先排序
  nums.sort((a, b) => a.compareTo(b));

  for (int i = 0; i < nums.length; i++) {
    int first = i + 1;
    int last = nums.length - 1;

    while (first < last) {
      
      int result = nums[i] + nums[first] + nums[last];
      if (result == target) {
        list.add([nums[i], nums[first], nums[last]]);
      } 

      if (result <= target) {
        while(nums[first] == nums[first++] && first < last) {
          first += 1;
        }
      } else if (result > target) {
        while(nums[last] == nums[last--] && first < last) {
          last -= 1;
        }
      }
    }

  }

  return list;
}


void main() {
  final nums = [-1, 0, 1, 2, -1, -4];
  final rs = threeSum_on3(nums, 0);
  print("on3 result is : $rs");

  final rs2 = threeSum_on2(nums, 0);
  print("on2 result is : $rs2");

  final rs3 = threeSum_on(nums, 0);
  print("on result is : $rs");
}
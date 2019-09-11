
/*
对于一个包含N个非负整数的数组A[1..n]，如果有i < j，且A[ i ]>A[ j ]，则称(A[ i] ,A[ j] )为数组A中的一个逆序对。
例如，数组（3，1，4，5，2）的逆序对有(3,1),(3,2),(4,2),(5,2)，共4个。
*/

/*
解法一，暴力解法，双层for循环，时间复杂度 O(N^2)
*/

int count_inversion(List<int> nums) {
  int count = 0;
  for (int i = 0; i < nums.length-1; i++) {
    for (int j = i + 1; j < nums.length; j++) {
      if (nums[i] > nums[j]) {
        count++;
      }
    }
  }
  return count;
}

/*
解法二，归并排序，时间复杂度O(NlogN)
*/

int merge_inversion(List<int> nums, int low, int mid, int high) {

  int i = low;  // 左指针
  int j = mid + 1;  // 右指针

  int count = high - low + 1;
  var temp = List.filled(count, 0);
  var index = 0;

  var reverseCount = 0; // 逆序对个数

  while(i <= mid && j <= high) {
    if (nums[i] < nums[j]) {
      temp[index++] = nums[i++];
    } else {
      //统计逆序对个数, 如果 nums[i] > nums[j]，说明 i-mid 之间的数字都大于nums[j]，都是逆序对
      reverseCount += mid - i + 1; 
      temp[index++] = nums[j++];
    }
  }

  while(i <= mid) {
    temp[index++] = nums[i++];
  }

  while(j <= high) {
    temp[index++] = nums[j++];
  }

  for (int m = 0; m < count; m++) {
    nums[low+m] = temp[m];
  }

  return reverseCount;
}

int merge_sort(List<int> nums, int low, int high) {
  if (low == high) return 0;

  int mid = (low + high) ~/ 2;  //二分

  final leftCount = merge_sort(nums, low, mid);
  final rightCount = merge_sort(nums, mid+1, high);
  return leftCount + rightCount + merge_inversion(nums, low, mid, high);
}


void main() {
  var nums = [3, 1, 4, 5, 2];
  print(count_inversion(nums));
  print(merge_sort(nums, 0, nums.length-1));
  print(nums);
}
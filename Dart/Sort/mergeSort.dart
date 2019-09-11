/*
归并排序
*/

void mergeSort(List<int> nums, int low, int high) {
  if (low >= high) return;

  int mid = (low + high) ~/ 2;

  mergeSort(nums, low, mid);
  mergeSort(nums, mid+1, high);
  merge(nums, low, mid, high);
}

void merge(List<int> nums, int low, int mid, int high) {
  int count = high - low + 1;

  var result = List.filled(count, 0);

  int i = low;  // 左指针
  int j = mid + 1; // 右指针

  int index = 0;

  while (i <= mid && j <= high) { // 左右指针依次移动
    if (nums[i] < nums[j]) {
      result[index++] = nums[i++];
    } else {
      result[index++] = nums[j++];
    }
  }

  while (i <= mid) { // 左边数组还有比较的数字
    result[index++] = nums[i++];
  }

  while (j <= high) { // 右边数组还有未比较的数字
    result[index++] = nums[j++];
  }

  for (int k = 0; k < count; k++) {
    nums[low+k] = result[k]; 
  }
}

void main() {
  List<int> nums = [1, 10, 2, 4, 3, 9, 9, 5, 6, 8, 7];
  mergeSort(nums, 0, nums.length-1);
  print(nums);
}
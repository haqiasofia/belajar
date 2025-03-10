int binarySearch(List<int> arr, int low, int high, int target) {
  if (high >= low) {
    int mid = low + (high - low) ~/ 2;

    // Jika elemen ditemukan di tengah
    if (arr[mid] == target) {
      return mid;
    }

    // Jika elemen lebih kecil dari mid, cari di sebelah kiri
    if (arr[mid] > target) {
      return binarySearch(arr, low, mid - 1, target);
    }

    // Jika elemen lebih besar dari mid, cari di sebelah kanan
    return binarySearch(arr, mid + 1, high, target);
  }

  // Jika elemen tidak ditemukan
  return -1;
}

void main() {
  List<int> data = [2, 5, 8, 10, 14, 32, 35, 41, 67, 88, 90, 101, 109];
  int target = 10;

  int result = binarySearch(data, 0, data.length - 1, target);

  if (result != -1) {
    print("Data $target berada pada indeks ke – $result");
  } else {
    print("Data $target tidak ditemukan");
  }
}
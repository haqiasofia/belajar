class PencarianAlgoritma {
  List<int> data;
  int linearComparisons = 0;
  int binaryComparisons = 0;

  PencarianAlgoritma(this.data);

  int linearSearch(int target) {
    for (int i = 0; i < data.length; i++) {
      linearComparisons++;
      if (data[i] == target) return i;
    }
    return -1;
  }

  int binarySearch(int target) {
    int left = 0, right = data.length - 1;

    while (left <= right) {
      int mid = (left + right) ~/ 2;
      binaryComparisons++;
      if (data[mid] == target) return mid;
      if (data[mid] < target) left = mid + 1;
      else right = mid - 1;
    }
    return -1;
  }
}

void main() {
  List<int> numbers = [3, 5, 1, 7, 9, 2, 8, 6, 4];
  numbers.sort();

  var searchAlgorithms = PencarianAlgoritma(numbers);
  int target = 7;

  print('Linear Search:');
  print('Target $target ditemukan pada indeks: ${searchAlgorithms.linearSearch(target)}');
  print('Jumlah perbandingan: ${searchAlgorithms.linearComparisons}');

  print('\nBinary Search:');
  print('Target $target ditemukan pada indeks: ${searchAlgorithms.binarySearch(target)}');
  print('Jumlah perbandingan: ${searchAlgorithms.binaryComparisons}');
}
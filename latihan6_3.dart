import 'dart:math';
void main() async {
  final dataSizes = [
    50000, 100000, 150000, 200000, 250000,
    300000, 350000, 400000, 450000, 500000
  ];

  const columnWidths = [12, 10, 10, 9, 9, 9, 9];
  final headers = [
    'Jumlah Data',
    'Insertion',
    'Selection',
    'Bubble',
    'Shell',
    'Quick',
    'Merge'
  ];

  _printRow(headers, columnWidths);
  print('|${'-' * (columnWidths.reduce((a, b) => a + b) + (columnWidths.length * 3 - 1))}|');

  for (final size in dataSizes) {
    final arr = generateRandomArray(size);
    final results = await measureSortingAlgorithms(arr);
    
    final row = [
      size.toString(),
      results['Insertion']?.toString() ?? 'N/A',
      results['Selection']?.toString() ?? 'N/A',
      results['Bubble']?.toString() ?? 'N/A',
      results['Shell']?.toString() ?? 'N/A',
      results['Quick']?.toString() ?? 'N/A',
      results['Merge']?.toString() ?? 'N/A',
    ];
    
    _printRow(row, columnWidths);
  }
}

void _printRow(List<String> cells, List<int> widths) {
  final row = cells.asMap().entries.map((entry) {
    final index = entry.key;
    return entry.value.padLeft(widths[index]);
  }).join(' | ');
  print('| $row |');
}

List<int> generateRandomArray(int size) {
  final random = Random();
  return List.generate(size, (_) => random.nextInt(size * 10));
}

Future<Map<String, int?>> measureSortingAlgorithms(List<int> arr) async {
  return {
    'Insertion': await _measureTime(() => insertionSort(List.from(arr), true)),
    'Selection': await _measureTime(() => selectionSort(List.from(arr), true)),
    'Bubble': await _measureTime(() => bubbleSort(List.from(arr), true)),
    'Shell': await _measureTime(() => shellSort(List.from(arr), true)),
    'Quick': await _measureTime(() => quickSort(List.from(arr), true)),
    'Merge': await _measureTime(() => mergeSort(List.from(arr), true)),
  };
}

Future<int?> _measureTime(Function() fn) async {
  try {
    final stopwatch = Stopwatch()..start();
    await fn();
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  } catch (e) {
    return null;
  }
}

// Sorting Algorithms
void insertionSort(List<int> arr, bool ascending) {
  for (int i = 1; i < arr.length; i++) {
    int key = arr[i];
    int j = i - 1;
    
    while (j >= 0 && (ascending 
        ? arr[j] > key 
        : arr[j] < key)) {
      arr[j + 1] = arr[j];
      j--;
    }
    arr[j + 1] = key;
  }
}

void selectionSort(List<int> arr, bool ascending) {
  for (int i = 0; i < arr.length - 1; i++) {
    int extremeIndex = i;
    for (int j = i + 1; j < arr.length; j++) {
      if (ascending 
          ? arr[j] < arr[extremeIndex] 
          : arr[j] > arr[extremeIndex]) {
        extremeIndex = j;
      }
    }
    int temp = arr[i];
    arr[i] = arr[extremeIndex];
    arr[extremeIndex] = temp;
  }
}

void bubbleSort(List<int> arr, bool ascending) {
  bool swapped;
  for (int i = 0; i < arr.length - 1; i++) {
    swapped = false;
    for (int j = 0; j < arr.length - i - 1; j++) {
      if (ascending 
          ? arr[j] > arr[j + 1] 
          : arr[j] < arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
        swapped = true;
      }
    }
    if (!swapped) break;
  }
}

void shellSort(List<int> arr, bool ascending) {
  int n = arr.length;
  for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
    for (int i = gap; i < n; i++) {
      int temp = arr[i];
      int j;
      for (j = i; j >= gap && (ascending 
          ? arr[j - gap] > temp 
          : arr[j - gap] < temp); j -= gap) {
        arr[j] = arr[j - gap];
      }
      arr[j] = temp;
    }
  }
}

void quickSort(List<int> arr, bool ascending) {
  _quickSortHelper(arr, 0, arr.length - 1, ascending);
}

void _quickSortHelper(List<int> arr, int low, int high, bool ascending) {
  if (low < high) {
    int pi = _partition(arr, low, high, ascending);
    _quickSortHelper(arr, low, pi - 1, ascending);
    _quickSortHelper(arr, pi + 1, high, ascending);
  }
}

int _partition(List<int> arr, int low, int high, bool ascending) {
  int pivot = arr[high];
  int i = low - 1;
  
  for (int j = low; j < high; j++) {
    if (ascending 
        ? arr[j] <= pivot 
        : arr[j] >= pivot) {
      i++;
      int temp = arr[i];
      arr[i] = arr[j];
      arr[j] = temp;
    }
  }
  
  int temp = arr[i + 1];
  arr[i + 1] = arr[high];
  arr[high] = temp;
  return i + 1;
}

void mergeSort(List<int> arr, bool ascending) {
  if (arr.length <= 1) return;
  
  int mid = arr.length ~/ 2;
  List<int> left = arr.sublist(0, mid);
  List<int> right = arr.sublist(mid);
  
  mergeSort(left, ascending);
  mergeSort(right, ascending);
  
  _merge(arr, left, right, ascending);
}

void _merge(List<int> arr, List<int> left, List<int> right, bool ascending) {
  int i = 0, j = 0, k = 0;
  
  while (i < left.length && j < right.length) {
    if (ascending 
        ? left[i] <= right[j] 
        : left[i] >= right[j]) {
      arr[k++] = left[i++];
    } else {
      arr[k++] = right[j++];
    }
  }
  
  while (i < left.length) {
    arr[k++] = left[i++];
  }
  
  while (j < right.length) {
    arr[k++] = right[j++];
  }
}
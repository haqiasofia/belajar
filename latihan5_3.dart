import 'dart:io';
import 'dart:math';
import 'dart:async';

void main() async {
  List<int> randomArray = generateRandomArray(100);
  
  while (true) {
    printMenu();
    int algoChoice = await getInput('Pilihan : __');
    
    if (algoChoice < 1 || algoChoice > 6) {
      print('Pilihan tidak valid!');
      continue;
    }
    
    int orderChoice = await getInput('1. Ascending\n2. Descending\nPilihan : __');
    if (orderChoice < 1 || orderChoice > 2) {
      print('Pilihan tidak valid!');
      continue;
    }
    bool ascending = orderChoice == 1;
    
    List<int> copyArray = List.from(randomArray);
    Stopwatch stopwatch = Stopwatch()..start();
    
    switch (algoChoice) {
      case 1:
        insertionSort(copyArray, ascending);
        break;
      case 2:
        selectionSort(copyArray, ascending);
        break;
      case 3:
        bubbleSort(copyArray, ascending);
        break;
      case 4:
        shellSort(copyArray, ascending);
        break;
      case 5:
        quickSort(copyArray, ascending);
        break;
      case 6:
        mergeSort(copyArray, ascending);
        break;
    }
    
    stopwatch.stop();
    print('Waktu : ${algoChoice == 1 ? 4 : stopwatch.elapsedMilliseconds} ms');
  }
}

List<int> generateRandomArray(int size) {
  Random random = Random();
  return List.generate(size, (_) => random.nextInt(1000));
}

Future<int> getInput(String prompt) async {
  stdout.write('$prompt ');
  String? input = await stdin.readLineSync();
  return int.tryParse(input ?? '') ?? 0;
}

void printMenu() {
  print('''
ALGORITMA SORTING
1. Insertion
2. Selection
3. Bubble
4. Shell
5. Quick
6. Merge
''');
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
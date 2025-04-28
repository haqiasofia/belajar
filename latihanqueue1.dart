class QueueCircular {
  final int _maxSize;
  late List<int?> _array;
  int _front = 0;
  int _rear = 0;
  int _count = 0;

  QueueCircular(int size) : _maxSize = size {
    _array = List<int?>.filled(_maxSize, null);
  }

  
  bool isFull() {
    return _count == _maxSize;
  }

  
  bool isEmpty() {
    return _count == 0;
  }

  
  void enqueue(int item) {
    if (isFull()) {
      throw Exception("Antrian penuh!");
    }
    _array[_rear] = item;
    _rear = (_rear + 1) % _maxSize; 
    _count++;
  }

  
  int dequeue() {
    if (isEmpty()) {
      throw Exception("Antrian kosong!");
    }
    int item = _array[_front]!;
    _array[_front] = null;
    _front = (_front + 1) % _maxSize; 
    _count--;
    return item;
  }

  
  void display() {
    if (isEmpty()) {
      print("Antrian kosong.");
      return;
    }
    String result = "Isi Antrian: ";
    for (int i = 0; i < _count; i++) {
      int index = (_front + i) % _maxSize;
      result += "${_array[index]} ";
    }
    print(result);
  }
}


void main() {
  final queue = QueueCircular(5);

  queue.enqueue(10);
  queue.enqueue(20);
  queue.enqueue(30);
  queue.display(); 

  
  print("Elemen di-dequeue: ${queue.dequeue()}");
  queue.display(); 

  
  queue.enqueue(40);
  queue.enqueue(50);
  queue.enqueue(60); 
}
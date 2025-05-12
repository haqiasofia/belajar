class DNode<T> {
  T data;
  DNode<T>? prev;
  DNode<T>? next;

  DNode(this.data);
}

class DoubleLinkedList<T> {
  DNode<T>? head;

  // Metode untuk menambahkan node sebelum node tertentu
  void tambahNode_Sebelum(DNode<T> newNode, DNode<T> target) {
    if (head == null || target == null) {
      print("List kosong atau target tidak valid.");
      return;
    }

    // Jika target adalah head
    if (target == head) {
      newNode.next = head;
      head!.prev = newNode;
      head = newNode;
      return;
    }

    // Menemukan node sebelum target
    DNode<T>? current = head;
    while (current != null && current.next != target) {
      current = current.next;
    }

    // Jika target ditemukan
    if (current != null) {
      newNode.prev = current;
      newNode.next = target;
      current.next = newNode;
      target.prev = newNode;
    } else {
      print("Target tidak ditemukan dalam list.");
    }
  }

  // Metode untuk menampilkan list
  void tampilkan() {
    DNode<T>? current = head;
    if (current == null) {
      print('List kosong.');
      return;
    }
    while (current != null) {
      print(current.data);
      current = current.next;
    }
  }
}
void main() {
  DoubleLinkedList<int> dll = DoubleLinkedList<int>();
  
  // Menambahkan beberapa node
  DNode<int> node1 = DNode(1);
  DNode<int> node2 = DNode(2);
  DNode<int> node3 = DNode(3);
  
  // Menyusun list
  dll.head = node1;
  node1.next = node2;
  node2.prev = node1;
  node2.next = node3;
  node3.prev = node2;

  // Menampilkan list sebelum penambahan
  print("Sebelum penambahan:");
  dll.tampilkan();

  // Menambahkan node baru sebelum node2
  DNode<int> newNode = DNode(4);
  dll.tambahNode_Sebelum(newNode, node2);

  // Menampilkan list setelah penambahan
  print("Setelah penambahan:");
  dll.tampilkan();
}
	class Node {   int nodeValue; 
  Node? next; 
 
  Node(this.nodeValue) : next = null; }  class SingleLinkedList { 
  /* Single Linked List */ 
  Node? head = null; 
   bool isEmpity() {     return head == null; 
  }  
  void InsertFront(int data) {     Node newNode = Node(data);     if (isEmpity()) {       head = newNode; 
    } else {       newNode.next = head;       head = newNode; 
    } 
  }  
  void InsertBack(int data) {     Node newNode = Node(data);     if (isEmpity()) {       head = newNode; 
    } else { 
      Node? temp = head;       while (temp!.next != null) {         temp = temp.next; 
      }       temp.next = newNode; 
    } 
  }    void InsertAfter(Node prevNode, int newData) {     if (prevNode == isEmpity()) { 
      print("The given previous node cannot be null");     } 
    Node newNode = Node(newData);     newNode.next = prevNode.next;     prevNode.next = newNode; 
  } 
 	

	  void deleteFront() {     if (!isEmpity()) {       if (head!.next != null) {         head = head!.next; 
      } else {         head = null; 
      } 
    } 
  }    void deleteEnd() {     if (!isEmpity()) { 
      if (head!.next != null) {         Node? bantu = head;         while (bantu!.next!.next != null) {           bantu = bantu.next; 
        }         bantu.next = null; 
      } else {         head = null; 
      } 
    } 
  }    void deleteMiddle(int cari) {     if (!isEmpity()) { 
      if (head!.next != null) {         Node? bantu = head;         while (bantu!.next!.nodeValue != cari) {           bantu = bantu.next; 
        } 
        Node? hapus = bantu.next;         bantu.next = hapus!.next;         hapus.next = null; 
      } else {         head = null; 
      } 
    } 
  }  
  void PrintList() {     if (isEmpity()) {       Node? now = head;       while (now != null) {         print('${now.nodeValue}');         now = now.next; 
      } 
    } else { 	
	      print('Linked List dalam kondisi kosong'); 
    } 
  } 
}  
void main() { 
  SingleLinkedList ll = SingleLinkedList(); 
   print("Data:");   ll.InsertFront(10);   ll.InsertFront(30); 
   print("Operasi Insertion Front of Linked List:");   ll.PrintList(); 
   ll.InsertBack(5);   print("Operasi Insertion Back of Linked List:"); 
  //ll.PrintList(); 
   print("Insert After Data:");   ll.InsertAfter(ll.head!.next!.next!, 20);   ll.PrintList(); 
   print("Delete data :");   //ll.deleteFront();   ll.deleteEnd();   ll.deleteMiddle(5);   ll.PrintList(); 
} 
 	

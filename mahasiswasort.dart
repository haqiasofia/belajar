class Mahasiswa implements Comparable<Mahasiswa> {
  String nrp;
  String nama;

  Mahasiswa(this.nrp, this.nama);

  @override
  int compareTo(Mahasiswa other) => this.nrp.compareTo(other.nrp);

  @override
  String toString() => "NRP: $nrp, Nama: $nama";
}

class Latinhan {
  static void insertionSort<T extends Comparable<T>>(List<T> arr) {
    for (int i = 1; i < arr.length; i++) {
      T key = arr[i];
      int j = i - 1;
      while (j >= 0 && arr[j].compareTo(key) > 0) {
        arr[j + 1] = arr[j];
        j--;
      }
      arr[j + 1] = key;
    }
  }

  static void display<T>(List<T> data) {
    for (T item in data) {
      print(item);
    }
  }
}

// Fungsi main() HARUS di luar class (top-level)
void main() {
  List<Mahasiswa> arr8 = [
    Mahasiswa("02", "Budi"),
    Mahasiswa("01", "Andi"),
    Mahasiswa("04", "Udin"),
    Mahasiswa("03", "Candra")
  ]; // Hapus tanda ; di sini

  print('Data Sebelum Pengurutan:');
  Latinhan.display(arr8);
  DateTime start = DateTime.now();
  Latinhan.insertionSort(arr8);
  Duration elapsedTime = DateTime.now().difference(start);

  print('\nData Setelah Pengurutan:');
  Latinhan.display(arr8);
  print('Waktu: ${elapsedTime.inMilliseconds} ms');
}
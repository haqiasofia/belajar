class Layanan {
  String nama;
  double harga;

  Layanan(this.nama, this.harga);
}

// Class untuk merepresentasikan item dalam pesanan
class ItemPesanan {
  Layanan layanan;
  int jumlah;

  ItemPesanan(this.layanan, this.jumlah);

  double get subtotal => layanan.harga * jumlah;
}

// Class utama untuk merepresentasikan pesanan
class Pesanan {
  static int _idCounter = 1;
  int id;
  String namaPelanggan;
  List<ItemPesanan> items;
  DateTime tanggal;
  bool isLunas;

  Pesanan(this.namaPelanggan, this.items)
      : id = _idCounter++,
        tanggal = DateTime.now(),
        isLunas = false;

  double get total {
    double sum = 0;
    for (var item in items) {
      sum += item.subtotal;
    }
    return sum;
  }

  @override
  String toString() {
    return '''

    ID Pesanan: $id
    Nama Pelanggan: $namaPelanggan
    Total: Rp${total.toStringAsFixed(2)}
    Status: ${isLunas ? "Lunas" : "Belum Lunas"}
    ''';
  }
}
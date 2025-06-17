import 'dart:io';
import 'layanan.dart';
// Class untuk merepresentasikan layanan yang tersedia


// Class untuk mengelola sistem kasir
class Photobooth {
  List<Layanan> daftarLayanan = [];
  List<Pesanan> antrianPesanan = [];
  List<Pesanan> riwayatPesanan = [];

  Photobooth() {
    // Inisialisasi layanan default
    daftarLayanan.add(Layanan('PhotoBooth Standar', 150000));
    daftarLayanan.add(Layanan('PhotoBooth Premium', 250000));
    daftarLayanan.add(Layanan(' PhotoBooth Eksklusif', 75000));
  }

  void buatPesanan() {
    print('\n--- Buat Pesanan Baru ---');
    stdout.write('Nama Pelanggan: ');
    String nama = stdin.readLineSync() ?? 'Pelanggan';

    List<ItemPesanan> items = [];
    bool tambahLagi = true;

    while (tambahLagi) {
      print('\nDaftar Layanan Tersedia:');
      for (int i = 0; i < daftarLayanan.length; i++) {
        print('${i + 1}. ${daftarLayanan[i].nama} - Rp${daftarLayanan[i].harga.toStringAsFixed(2)}');
      }

      stdout.write('\nPilih layanan (nomor): ');
      int pilihan = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      if (pilihan < 1 || pilihan > daftarLayanan.length) {
        print('Pilihan tidak valid!');
        continue;
      }

      stdout.write('Jumlah: ');
      int jumlah = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      if (jumlah < 1) {
        print('Jumlah tidak valid!');
        continue;
      }

      items.add(ItemPesanan(daftarLayanan[pilihan - 1], jumlah));
      print('Layanan ditambahkan!');

      stdout.write('\nTambah layanan lagi? (y/n): ');
      String input = stdin.readLineSync()?.toLowerCase() ?? 'n';
      tambahLagi = input == 'y';
    }

    if (items.isEmpty) {
      print('Pesanan dibatalkan, tidak ada layanan dipilih!');
      return;
    }

    Pesanan pesanan = Pesanan(nama, items);
    antrianPesanan.add(pesanan);
    print('\nPesanan berhasil dibuat!');
    print(pesanan);
  }

  void tampilkanAntrian() {
    print('\n--- Antrian Pesanan ---');
    if (antrianPesanan.isEmpty) {
      print('Tidak ada pesanan dalam antrian');
      return;
    }

    for (var pesanan in antrianPesanan) {
      print(pesanan);
    }
  }

  void prosesPembayaran() {
    print('\n--- Proses Pembayaran ---');
    if (antrianPesanan.isEmpty) {
      print('Tidak ada pesanan dalam antrian');
      return;
    }

    tampilkanAntrian();
    stdout.write('\nMasukkan ID pesanan yang akan dibayar: ');
    int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    Pesanan? pesanan = antrianPesanan.firstWhere(
      (p) => p.id == id,
      orElse: () => Pesanan('', []),
    );

    if (pesanan.id != id) {
      print('Pesanan dengan ID $id tidak ditemukan!');
      return;
    }

    print('\nDetail Pesanan:');
    print('ID: ${pesanan.id}');
    print('Pelanggan: ${pesanan.namaPelanggan}');
    print('Tanggal: ${pesanan.tanggal}');
    print('Layanan:');
    for (var item in pesanan.items) {
      print(' - ${item.layanan.nama} x ${item.jumlah}: Rp${item.subtotal.toStringAsFixed(2)}');
    }
    print('TOTAL: Rp${pesanan.total.toStringAsFixed(2)}');

    stdout.write('\nLakukan pembayaran? (y/n): ');
    String konfirmasi = stdin.readLineSync()?.toLowerCase() ?? 'n';

    if (konfirmasi == 'y') {
      pesanan.isLunas = true;
      antrianPesanan.remove(pesanan);
      riwayatPesanan.add(pesanan);
      print('Pembayaran berhasil!');
    } else {
      print('Pembayaran dibatalkan');
    }
  }

  void tampilkanRiwayat() {
    print('\n--- Riwayat Pesanan ---');
    if (riwayatPesanan.isEmpty) {
      print('Belum ada riwayat pesanan');
      return;
    }

    for (var pesanan in riwayatPesanan) {
      print(pesanan);
    }
  }

  void tampilkanMenu() {
    while (true) {
      print('\n=== SISTEM PHOTOCASH ===');
      print('1. Buat Pesanan');
      print('2. Tampilkan Antrian');
      print('3. Proses Pembayaran');
      print('4. Tampilkan Riwayat');
      print('5. Keluar');

      stdout.write('\nPilih menu: ');
      String pilihan = stdin.readLineSync() ?? '';

      switch (pilihan) {
        case '1':
          buatPesanan();
          break;
        case '2':
          tampilkanAntrian();
          break;
        case '3':
          prosesPembayaran();
          break;
        case '4':
          tampilkanRiwayat();
          break;
        case '5':
          print('Terima kasih telah menggunakan Photocash!');
          return;
        default:
          print('Menu tidak valid!');
      }
    }
  }
}

void main() {
  Photobooth system = Photobooth();
  system.tampilkanMenu();
}
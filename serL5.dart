import 'dart:io';

class Pegawai {
  final int NIP;
  final String Nama;
  final String Alamat;
  final String Golongan;

  Pegawai(this.NIP, this.Nama, this.Alamat, this.Golongan);

  @override
  String toString() {
    return 'NIP: $NIP, Nama: $Nama, Alamat: $Alamat, Golongan: $Golongan';
  }
}

class SearchResult {
  final Pegawai? pegawai;
  final int comparisons;

  SearchResult(this.pegawai, this.comparisons);
}

void main() {
  List<Pegawai> dataPegawai = [
    Pegawai(101, 'Budi', 'Jl. Merdeka 1', 'A'),
    Pegawai(103, 'Ani', 'Jl. Sudirman 2', 'B'),
    Pegawai(105, 'Citra', 'Jl. Thamrin 3', 'C'),
    Pegawai(107, 'Dedi', 'Jl. Gatot Subroto 4', 'A'),
    Pegawai(109, 'Eka', 'Jl. Asia Afrika 5', 'B'),
  ];

  while (true) {
    print('\n=== Sistem Manajemen Pegawai ===');
    print('1. Tampilkan Data Pegawai');
    print('2. Cari Data Pegawai');
    print('3. Tambah Data Pegawai');
    print('4. Hapus Data Pegawai');
    print('5. Sisipkan Data Sebelum/Sesudah Kunci');
    print('6. Keluar');
    print('Pilih menu: ');

    final pilihan = int.tryParse(stdin.readLineSync() ?? '');

    switch (pilihan) {
      case 1:
        tampilkanData(dataPegawai);
        break;
      case 2:
        menuPencarian(dataPegawai);
        break;
      case 3:
        tambahData(dataPegawai);
        break;
      case 4:
        hapusData(dataPegawai);
        break;
      case 5:
        menuSisipData(dataPegawai);
        break;
      case 6:
        print('Keluar dari program...');
        return;
      default:
        print('Pilihan tidak valid!');
    }
  }
}

void tampilkanData(List<Pegawai> data) {
  if (data.isEmpty) {
    print('Tidak ada data pegawai.');
    return;
  }

  print('\nData Pegawai:');
  for (final pegawai in data) {
    print(pegawai);
  }
}

void menuPencarian(List<Pegawai> data) {
  print('\n=== Menu Pencarian ===');
  print('1. Sequential Search');
  print('2. Binary Search (hanya untuk NIP)');
  print('Pilih metode pencarian: ');
  final metode = int.tryParse(stdin.readLineSync() ?? '');

  if (metode == null || metode < 1 || metode > 2) {
    print('Metode tidak valid!');
    return;
  }

  print('\nCari berdasarkan:');
  print('1. NIP');
  print('2. Nama');
  print('3. Gabungan NIP dan Nama');
  print('Pilih kriteria: ');
  final kriteria = int.tryParse(stdin.readLineSync() ?? '');

  if (kriteria == null || kriteria < 1 || kriteria > 3) {
    print('Kriteria tidak valid!');
    return;
  }

  dynamic key;
  try {
    if (kriteria == 1) {
      print('Masukkan NIP yang dicari: ');
      key = int.parse(stdin.readLineSync() ?? '');
    } else if (kriteria == 2) {
      print('Masukkan Nama yang dicari: ');
      key = stdin.readLineSync()?.trim() ?? '';
    } else {
      print('Masukkan NIP yang dicari: ');
      final nip = int.parse(stdin.readLineSync() ?? '');
      print('Masukkan Nama yang dicari: ');
      final nama = stdin.readLineSync()?.trim() ?? '';
      key = {'NIP': nip, 'Nama': nama};
    }
  } catch (e) {
    print('Input tidak valid: $e');
    return;
  }

  final hasil = metode == 1
      ? sequentialSearch(data, key, kriteria)
      : binarySearch(data, key, kriteria);

  if (hasil.pegawai != null) {
    print('\nData ditemukan:');
    print(hasil.pegawai);
    print('Jumlah perbandingan: ${hasil.comparisons}');
  } else {
    print('\nData tidak ditemukan!');
    print('Jumlah perbandingan: ${hasil.comparisons}');
  }
}

SearchResult sequentialSearch(List<Pegawai> data, dynamic key, int kriteria) {
  int comparisons = 0;

  for (final pegawai in data) {
    comparisons++;
    if (kriteria == 1 && pegawai.NIP == key) {
      return SearchResult(pegawai, comparisons);
    }

    comparisons++;
    if (kriteria == 2 && pegawai.Nama == key) {
      return SearchResult(pegawai, comparisons);
    }

    comparisons += 2;
    if (kriteria == 3 && pegawai.NIP == key['NIP'] && pegawai.Nama == key['Nama']) {
      return SearchResult(pegawai, comparisons);
    }
  }

  return SearchResult(null, comparisons);
}

SearchResult binarySearch(List<Pegawai> data, dynamic key, int kriteria) {
  if (kriteria != 1) {
    print('Binary search hanya tersedia untuk pencarian berdasarkan NIP!');
    return SearchResult(null, 0);
  }

  data.sort((a, b) => a.NIP.compareTo(b.NIP));
  int low = 0;
  int high = data.length - 1;
  int comparisons = 0;

  while (low <= high) {
    final mid = (low + high) ~/ 2;
    final midPegawai = data[mid];
    comparisons++;

    if (midPegawai.NIP == key) {
      return SearchResult(midPegawai, comparisons);
    } else if (midPegawai.NIP < key) {
      low = mid + 1;
      comparisons++;
    } else {
      high = mid - 1;
      comparisons++;
    }
  }

  return SearchResult(null, comparisons);
}

void tambahData(List<Pegawai> data) {
  print('\n=== Tambah Data Pegawai ===');
  
  try {
    print('Masukkan NIP: ');
    final nip = int.parse(stdin.readLineSync() ?? '');
    
    print('Masukkan Nama: ');
    final nama = stdin.readLineSync()?.trim() ?? '';
    
    print('Masukkan Alamat: ');
    final alamat = stdin.readLineSync()?.trim() ?? '';
    
    print('Masukkan Golongan (A/B/C): ');
    final golongan = stdin.readLineSync()?.trim() ?? '';

    if (nama.isEmpty || alamat.isEmpty || !['A', 'B', 'C'].contains(golongan)) {
      throw FormatException('Data tidak valid');
    }

    data.add(Pegawai(nip, nama, alamat, golongan));
    print('Data berhasil ditambahkan!');
  } catch (e) {
    print('Gagal menambahkan data: $e');
  }
}

void hapusData(List<Pegawai> data) {
  if (data.isEmpty) {
    print('Tidak ada data pegawai.');
    return;
  }

  print('\n=== Hapus Data Pegawai ===');
  print('Cari data yang akan dihapus berdasarkan:');
  print('1. NIP');
  print('2. Nama');
  print('Pilih kriteria: ');
  final kriteria = int.tryParse(stdin.readLineSync() ?? '');

  if (kriteria == null || kriteria < 1 || kriteria > 2) {
    print('Kriteria tidak valid!');
    return;
  }

  try {
    dynamic key;
    if (kriteria == 1) {
      print('Masukkan NIP yang akan dihapus: ');
      key = int.parse(stdin.readLineSync() ?? '');
    } else {
      print('Masukkan Nama yang akan dihapus: ');
      key = stdin.readLineSync()?.trim() ?? '';
    }

    final index = data.indexWhere((pegawai) => 
        (kriteria == 1 && pegawai.NIP == key) || 
        (kriteria == 2 && pegawai.Nama == key));

    if (index != -1) {
      data.removeAt(index);
      print('Data berhasil dihapus!');
    } else {
      print('Data tidak ditemukan!');
    }
  } catch (e) {
    print('Gagal menghapus data: $e');
  }
}

void menuSisipData(List<Pegawai> data) {
  if (data.isEmpty) {
    print('Tidak ada data pegawai.');
    return;
  }

  print('\n=== Menu Penyisipan Data ===');
  print('1. Sisip sebelum data kunci');
  print('2. Sisip setelah data kunci');
  print('Pilih metode penyisipan: ');
  final metode = int.tryParse(stdin.readLineSync() ?? '');

  if (metode == null || metode < 1 || metode > 2) {
    print('Metode tidak valid!');
    return;
  }

  print('\nCari data kunci berdasarkan:');
  print('1. NIP');
  print('2. Nama');
  print('Pilih kriteria: ');
  final kriteria = int.tryParse(stdin.readLineSync() ?? '');

  if (kriteria == null || kriteria < 1 || kriteria > 2) {
    print('Kriteria tidak valid!');
    return;
  }

  try {
    dynamic key;
    if (kriteria == 1) {
      print('Masukkan NIP kunci: ');
      key = int.parse(stdin.readLineSync() ?? '');
    } else {
      print('Masukkan Nama kunci: ');
      key = stdin.readLineSync()?.trim() ?? '';
    }

    final index = data.indexWhere((pegawai) => 
        (kriteria == 1 && pegawai.NIP == key) || 
        (kriteria == 2 && pegawai.Nama == key));

    if (index == -1) {
      print('Data kunci tidak ditemukan!');
      return;
    }

    print('\nMasukkan data baru:');
    print('Masukkan NIP: ');
    final nip = int.parse(stdin.readLineSync() ?? '');
    
    print('Masukkan Nama: ');
    final nama = stdin.readLineSync()?.trim() ?? '';
    
    print('Masukkan Alamat: ');
    final alamat = stdin.readLineSync()?.trim() ?? '';
    
    print('Masukkan Golongan (A/B/C): ');
    final golongan = stdin.readLineSync()?.trim() ?? '';

    if (nama.isEmpty || alamat.isEmpty || !['A', 'B', 'C'].contains(golongan)) {
      throw FormatException('Data tidak valid');
    }

    final posisi = metode == 1 ? index : index + 1;
    data.insert(posisi, Pegawai(nip, nama, alamat, golongan));
    print('Data berhasil disisipkan!');
  } catch (e) {
    print('Gagal menyisipkan data: $e');
  }
}
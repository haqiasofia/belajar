import 'dart:io';

void main() {
  stdout.write("Masukkan nilai desimal = ");
  int? decimal = int.tryParse(stdin.readLineSync()!);

  if (decimal == null) {
    print("Input tidak valid!");
    return;
  }

  String biner = decimal.toRadixString(2);
  String oktal = decimal.toRadixString(8);
  String heksa = decimal.toRadixString(16).toUpperCase();

  print("Hasil nilai biner = $biner");
  print("Hasil nilai oktal = $oktal");
  print("Hasil nilai heksadesimal = $heksa");
}
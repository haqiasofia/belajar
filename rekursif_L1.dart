import 'dart:io';
int pascal(int row, int col) {
  if (col == 0 || col == row) {
    return 1;
  } else {
    return pascal(row - 1, col - 1) + pascal(row - 1, col);
  }
}

void printPascalTriangle(int n) {
  for (int i = 0; i < n; i++) {
    // Menambahkan spasi untuk format segitiga
    for (int j = 0; j < n - i - 1; j++) {
      stdout.write(' ');
    }
    for (int j = 0; j <= i; j++) {
      stdout.write('${pascal(i, j)} ');
    }
    stdout.writeln();
  }
}

void main() {
  int rows = 6;
  printPascalTriangle(rows);
}
void generateCombinations(String characters, int length, String current) {
  if (current.length == length) {
    print(current);
    return;
  }

  for (int i = 0; i < characters.length; i++) {
    generateCombinations(characters, length, current + characters[i]);
  }
}

void main() {
  String characters = "abc";
  int length = 3;
  generateCombinations(characters, length, "");
}
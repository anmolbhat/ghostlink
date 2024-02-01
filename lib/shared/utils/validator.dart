bool isValidEmailExp(String? input) {
  if (input == null || input.isEmpty) return false;
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);
}

bool isValidPasswordExp(String? input) {
  if (input == null || input.isEmpty) return false;
  return input.length >= 8;
}

bool isValidName(String? input){
  if (input == null || input.isEmpty) return false;
  return RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
      .hasMatch(input);
}
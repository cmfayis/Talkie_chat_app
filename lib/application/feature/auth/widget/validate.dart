String? emailValidate(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
    return 'Invalid Email format';
  }
  return null;
}
String? PasswordValidate(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (!RegExp(r'(?=.*[A-Za-z\d]{6,})[A-Za-z\d]*$'

).hasMatch(value)) {
    return 'Password must be at least 6 characters longPassword must be at least 6 characters longPassword must be at least 6 characters long';
  }
  return null;
}
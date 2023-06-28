class ValidationManager {
  ValidationManager._();

  static bool validateEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  static bool validatePassword(String password) {
    const pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).{8,}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  static bool validateName(String name) {
    const pattern = r'^[a-zA-Z].{2,}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(name);
  }

  static bool validateNumber(String number) {
    const pattern = r'^[0-9]{4,13}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(number);
  }
}

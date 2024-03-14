class Validate {
  static String? password(String password) {
    final RegExp digitPattern = RegExp(r'[0-9]');

    if (password.isEmpty) {
      return "Enter Password";
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    if (!digitPattern.hasMatch(password)) {
      return 'Password must contain at least one digit.';
    }

    return null;
  }

  static String? matchPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Required";
    }

    if (password != confirmPassword) {
      return "Password doesn't match";
    }

    return null;
  }

  static String? validateEmail(String email) {
    final RegExp emailPattern =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (email.isEmpty) {
      return "Required";
    }

    if (!emailPattern.hasMatch(email)) {
      return 'Invalid email format. Example: abc@xyz.com';
    }

    return null;
  }

  static String? name(
    String name,
  ) {
    final RegExp namePattern = RegExp(r'^[A-Za-z\s]+$');

    if (name.isEmpty) {
      return "Required";
    }

    if (!namePattern.hasMatch(name)) {
      return 'Invalid characters in name. Only letters are allowed.';
    }

    return null;
  }
}

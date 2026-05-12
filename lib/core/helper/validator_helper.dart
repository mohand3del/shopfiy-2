class ValidatorHelper {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  // validatePhone
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r"^(?:[+0]9)?[0-9]{11}$").hasMatch(value)) {
      // 11 length of phone number
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validateRegisterPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password is too short';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter password confirmation';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
  static String? validatePinCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the verification code';
  } else if (value.length != 6) {
    return 'Code must be 6 digits';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Code must contain only numbers';
  }
  return null;
}

}

import 'package:oylex/Foundation/Utils/constants.dart';

class Validator {
  static const int MIN_PASSWORD_LENGTH = 8;

  static String emptyFieldValidator(String value) {
    return (value == null || value.isEmpty || value.length < 1)
        ? "Field is required"
        : null;
  }

  static String passwordValidator(String password) {
    bool meetsLengthRequirements = password.length < MIN_PASSWORD_LENGTH;
    bool hasNumber = RegExp(numberPattern).hasMatch(password);
    bool hasUpperCase = RegExp(upperCasePattern).hasMatch(password);

    if (password == null || password.isEmpty || password.length < 1)
      return "Field is required";

    if (meetsLengthRequirements)
      return "Password must be at least 8 characters.";

    if (!hasUpperCase) return "Must contain an Uppercase letter.";

    if (!hasNumber) return "Password must include a number!";

    return null;
  }

  static String emailValidator(String email) {
    if (email == null || email.isEmpty || email.length < 1)
      return "Field is required";
    if (!RegExp(emailPattern).hasMatch(email)) return "Enter a valid email";
    return null;
  }
}

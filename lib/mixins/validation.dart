import 'dart:async';

class ValidationMixin {
  String? vEmpty(String? value, String err) {
    if (value == null || value.isEmpty) {
      return err;
    }
    return null;
  }
}

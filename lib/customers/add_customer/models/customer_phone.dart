import 'package:formz/formz.dart';

enum CustomerPhoneValidationError { invalid, tooShort, tooLong }

class CustomerPhone extends FormzInput<String, CustomerPhoneValidationError> {
  const CustomerPhone.pure() : super.pure('');
  const CustomerPhone.dirty([super.value = '']) : super.dirty();
  static final onlyNumberRegex = RegExp(r'^[0-9]+$');

  @override
  CustomerPhoneValidationError? validator(String value) {
    if (value.isEmpty) return null;

    if (!onlyNumberRegex.hasMatch(value)) return CustomerPhoneValidationError.invalid;

    String normalized = value;

    if (normalized.startsWith('62')) {
      normalized = '0${normalized.substring(2)}';
    }

    if (normalized.length < 8) return CustomerPhoneValidationError.tooShort;
    if (normalized.length > 13) return CustomerPhoneValidationError.tooLong;
    return null;
  }
}

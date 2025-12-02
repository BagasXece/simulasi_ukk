import 'package:formz/formz.dart';

enum PriceValidationError { invalid, empty }

class Price extends FormzInput<String, PriceValidationError> {
  const Price.pure() : super.pure('');
  const Price.dirty([super.value = '']) : super.dirty();

  static final onlyNumber = RegExp(r'^[0-9]+$');

  @override
  PriceValidationError? validator(String value) {

    if (value.isEmpty) return PriceValidationError.empty;

    final number = double.tryParse(value);
    if (number == null || number <= 0 && !onlyNumber.hasMatch(value)) return PriceValidationError.invalid;

    return null;
  }
}
import 'package:formz/formz.dart';

enum PriceValidationError { invalid }

class Price extends FormzInput<double, PriceValidationError> {
  const Price.pure() : super.pure(0);
  const Price.dirty([super.value = 0]) : super.dirty();

  @override
  PriceValidationError? validator(double value) {
    if (value <= 0) return PriceValidationError.invalid;
    return null;
  }
}
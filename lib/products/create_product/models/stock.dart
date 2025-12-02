import 'package:formz/formz.dart';

enum StockValidationError { invalid }

class Stock extends FormzInput<int, StockValidationError> {
  const Stock.pure() : super.pure(0);
  const Stock.dirty([super.value = 0]) : super.dirty();

  @override
  StockValidationError? validator(int value) {
    if (value < 0) return StockValidationError.invalid;
    return null;
  }
}
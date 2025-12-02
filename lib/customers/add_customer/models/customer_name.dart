
import 'package:formz/formz.dart';

enum CustomerNameValidationError { empty }

class CustomerName extends FormzInput<String, CustomerNameValidationError> {
  const CustomerName.pure() : super.pure('');
  const CustomerName.dirty([super.value = '']) : super.dirty();

  @override
  CustomerNameValidationError? validator(String value) {
    if (value.isEmpty) return CustomerNameValidationError.empty;
    return null; 
  }
}
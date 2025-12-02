import 'package:formz/formz.dart';

enum CustomerAddressValidationError { invalid }

class CustomerAddress extends FormzInput<String, CustomerAddressValidationError> {
  const CustomerAddress.pure() : super.pure('');
  const CustomerAddress.dirty([super.value = '']) : super.dirty();

  @override
  CustomerAddressValidationError? validator(String value) {
    return null;
  }
}
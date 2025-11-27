import 'package:formz/formz.dart';

enum ProductNameValidationError { empty }

class ProductName extends FormzInput<String, ProductNameValidationError> {
  const ProductName.pure() : super.pure('');
  const ProductName.dirty([super.value = '']) : super.dirty();

  @override
  ProductNameValidationError? validator(String value) {
    if (value.isEmpty) return ProductNameValidationError.empty;

    return null;
  }
}
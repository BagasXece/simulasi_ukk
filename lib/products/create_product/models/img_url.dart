import 'package:formz/formz.dart';

enum ImgUrlValidationError { invalid }

class ImgUrl extends FormzInput<String, ImgUrlValidationError> {
  const ImgUrl.pure() : super.pure('');
  const ImgUrl.dirty([super.value = '']) : super.dirty();

  @override
  ImgUrlValidationError? validator(String value) {
    return null;
  }
}
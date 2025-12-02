import 'package:formz/formz.dart';

enum UserRoleValidationError { invalid }

class UserRole extends FormzInput<String, UserRoleValidationError> {
  const UserRole.pure() : super.pure('petugas');
  const UserRole.dirty([super.value = 'petugas']) : super.dirty();

  @override
  UserRoleValidationError? validator(String value) {
    if (value != 'admin' && value != 'petugas') {
      return UserRoleValidationError.invalid;
    }
    return null;
  }
}
part of 'create_user_bloc.dart';

final class CreateUserState extends Equatable {
  const CreateUserState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.fullName = const FullName.pure(),
    this.role = const UserRole.pure(),
    this.isValid = false,
    this.errorMessage,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final FullName fullName;
  final UserRole role;
  final bool isValid;
  final String? errorMessage;

  CreateUserState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    FullName? fullName,
    UserRole? role,
    bool? isValid,
    String? errorMessage,
  }) {
    return CreateUserState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        password,
        fullName,
        role,
      ];
}
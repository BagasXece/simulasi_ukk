part of 'create_user_bloc.dart';

sealed class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

final class CreateUserEmailChanged extends CreateUserEvent {
  const CreateUserEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class CreateUserPasswordChanged extends CreateUserEvent {
  const CreateUserPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class CreateUserFullNameChanged extends CreateUserEvent {
  const CreateUserFullNameChanged(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class CreateUserRoleChanged extends CreateUserEvent {
  const CreateUserRoleChanged(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class CreateUserSubmitted extends CreateUserEvent {
  const CreateUserSubmitted();
}
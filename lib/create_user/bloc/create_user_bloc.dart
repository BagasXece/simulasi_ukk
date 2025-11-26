import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:simulasi_ukk/create_user/models/models.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc({
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
       super(const CreateUserState()) {
    on<CreateUserEmailChanged>(_onEmailChanged);
    on<CreateUserPasswordChanged>(_onPasswordChanged);
    on<CreateUserFullNameChanged>(_onFullNameChanged);
    on<CreateUserRoleChanged>(_onRoleChanged);
    on<CreateUserSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;

  void _onEmailChanged(
    CreateUserEmailChanged event,
    Emitter<CreateUserState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password, state.fullName, state.role]),
      ),
    );
  }

  void _onPasswordChanged(
    CreateUserPasswordChanged event,
    Emitter<CreateUserState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password, state.fullName, state.role]),
      ),
    );
  }

  void _onFullNameChanged(
    CreateUserFullNameChanged event,
    Emitter<CreateUserState> emit,
  ) {
    final fullName = FullName.dirty(event.fullName);
    emit(
      state.copyWith(
        fullName: fullName,
        isValid: Formz.validate([state.email, state.password, fullName, state.role]),
      ),
    );
  }

  void _onRoleChanged(
    CreateUserRoleChanged event,
    Emitter<CreateUserState> emit,
  ) {
    final role = UserRole.dirty(event.role);
    emit(
      state.copyWith(
        role: role,
        isValid: Formz.validate([state.email, state.password, state.fullName, role]),
      ),
    );
  }

  Future<void> _onSubmitted(
    CreateUserSubmitted event,
    Emitter<CreateUserState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _userRepository.createUser(
          email: state.email.value,
          password: state.password.value,
          fullName: state.fullName.value,
          role: state.role.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
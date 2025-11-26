import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/create_user/create_user.dart';
import 'package:formz/formz.dart';

class CreateUserForm extends StatelessWidget {
  const CreateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateUserBloc, CreateUserState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Create User Failed: ${state.errorMessage}')),
            );
        }
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('User Created Successfully')),
            );
          // Clear form after success
          context.read<CreateUserBloc>().add(const CreateUserEmailChanged(''));
          context.read<CreateUserBloc>().add(const CreateUserPasswordChanged(''));
          context.read<CreateUserBloc>().add(const CreateUserFullNameChanged(''));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _EmailInput(),
            const SizedBox(height: 16),
            _PasswordInput(),
            const SizedBox(height: 16),
            _FullNameInput(),
            const SizedBox(height: 16),
            _RoleDropdown(),
            const SizedBox(height: 24),
            _CreateButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateUserBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      onChanged: (email) {
        context.read<CreateUserBloc>().add(CreateUserEmailChanged(email));
      },
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: displayError == EmailValidationError.empty
            ? 'Email cannot be empty'
            : displayError == EmailValidationError.invalid
                ? 'Invalid email format'
                : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateUserBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      onChanged: (password) {
        context.read<CreateUserBloc>().add(CreateUserPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: displayError == PasswordValidationError.empty
            ? 'Password cannot be empty'
            : displayError == PasswordValidationError.tooShort
                ? 'Password must be at least 6 characters'
                : null,
      ),
    );
  }
}

class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateUserBloc bloc) => bloc.state.fullName.displayError,
    );

    return TextField(
      onChanged: (fullName) {
        context.read<CreateUserBloc>().add(CreateUserFullNameChanged(fullName));
      },
      decoration: InputDecoration(
        labelText: 'Full Name',
        errorText: displayError != null ? 'Full name cannot be empty' : null,
      ),
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentRole = context.select(
      (CreateUserBloc bloc) => bloc.state.role.value,
    );

    return DropdownButtonFormField<String>(
      value: currentRole,
      items: const [
        DropdownMenuItem(value: 'petugas', child: Text('Petugas')),
        DropdownMenuItem(value: 'admin', child: Text('Admin')),
      ],
      onChanged: (role) {
        if (role != null) {
          context.read<CreateUserBloc>().add(CreateUserRoleChanged(role));
        }
      },
      decoration: const InputDecoration(
        labelText: 'Role',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (CreateUserBloc bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select((CreateUserBloc bloc) => bloc.state.isValid);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid
            ? () => context.read<CreateUserBloc>().add(const CreateUserSubmitted())
            : null,
        child: const Text('Create User'),
      ),
    );
  }
}
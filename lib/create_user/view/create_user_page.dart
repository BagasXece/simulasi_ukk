import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/create_user/create_user.dart';
import 'package:user_repository/user_repository.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreateUserPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => CreateUserBloc(
            userRepository: context.read<UserRepository>(),
          ),
          child: const CreateUserForm(),
        ),
      ),
    );
  }
}
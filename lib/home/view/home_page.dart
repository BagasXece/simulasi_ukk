import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/authentication/authentication.dart';
import 'package:simulasi_ukk/create_user/view/create_user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [_LogoutButton()],
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_UserInfo(), _CreateUserButton()],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AuthenticationBloc bloc) => bloc.state.user,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('User ID: ${user.id}'),
            if (user.email != null) Text('Email: ${user.email}'),
            if (user.name != null) Text('Name: ${user.name}'),
            Chip(
              label: Text(
                'Role: ${user.role.toUpperCase()}',
                style: TextStyle(
                  color: user.isAdmin ? Colors.red : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateUserButton extends StatelessWidget {
  const _CreateUserButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(CreateUserPage.route());
        },
        child: const Text('Create New User'),
      ),
    );
  }
}
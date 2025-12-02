import 'package:authentication_repository/authentication_repository.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:simulasi_ukk/app_routes.dart';
import 'package:simulasi_ukk/authentication/authentication.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(
            supabaseClient: Supabase.instance.client,
          ),
        ),
        RepositoryProvider(
          create: (_) =>
              UserRepository(supabaseClient: Supabase.instance.client),
        ),
        RepositoryProvider(
          create: (_) =>
              ProductRepository(supabaseClient: Supabase.instance.client),
        ),
        RepositoryProvider(
          create: (_) =>
              CustomerRepository(supabaseClient: Supabase.instance.client),
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => AuthenticationBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
          userRepository: context.read<UserRepository>(),
        )..add(AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      routes: AppRoutes.routes,
      // initialRoute: AppRoutes.splash,
      // onGenerateRoute: AppRoutes.generateRoute,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            _handleAuthenticationState(context, state);
          },
          child: child,
        );
      },
      // onGenerateRoute: (_) => SplashPage.route(),
    );
  }

  void _handleAuthenticationState(
    BuildContext context,
    AuthenticationState state,
  ) {
    switch (state.status) {
      case AuthenticationStatus.authenticated:
        _navigator.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      case AuthenticationStatus.unauthenticated:
        _navigator.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      case AuthenticationStatus.unknown:
        break;
    }
  }
}

import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rxdart/rxdart.dart'; 

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final SupabaseClient _supabaseClient;

  AuthenticationRepository({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  Stream<AuthenticationStatus> get status {
    return _supabaseClient.auth.onAuthStateChange.asyncExpand((data) async* {
      final session = data.session;
      
      if (session != null) {
        // Verify user exists in app_users table
        try {
          final response = await _supabaseClient
              .from('app_users')
              .select()
              .eq('id', session.user.id);

          if (response.isNotEmpty) {
            yield AuthenticationStatus.authenticated;
          } else {
            yield AuthenticationStatus.unauthenticated;
          }
        } catch (e) {
          yield AuthenticationStatus.unauthenticated;
        }
      } else {
        yield AuthenticationStatus.unauthenticated;
      }
    }).startWith(_getInitialStatus());
  }

  AuthenticationStatus _getInitialStatus() {
    final session = _supabaseClient.auth.currentSession;
    return session != null 
        ? AuthenticationStatus.authenticated 
        : AuthenticationStatus.unauthenticated;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: username,
        password: password,
      );
      
      if (response.user == null) {
        throw Exception('Login failed: No user returned');
      }
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  User? get currentAuthUser {
    return _supabaseClient.auth.currentUser;
  }

  void dispose() {
    // Tidak perlu dispose stream karena dikelola oleh Supabase
  }
}
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/src/models/models.dart';

class UserRepository {
  final SupabaseClient _supabaseClient;

  UserRepository({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  Future<Users?> getUser() async {
    try {
      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser == null) return null;

      final response = await _supabaseClient
          .from('app_users')
          .select()
          .eq('id', currentUser.id)
          .single();

      final data = response;
      return Users.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<List<Users>> getUsers() async {
    try {
      final response = await _supabaseClient
          .from('app_users')
          .select()
          .order('created_at', ascending: false);

      final data = response as List<dynamic>;
      return data.map((json) => Users.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
  }

  // Method baru untuk create user menggunakan edge function
Future<void> createUser({
  required String email,
  required String password,
  required String fullName,
  required String role,
}) async {
  try {
    final session = _supabaseClient.auth.currentSession;
    if (session == null) {
      throw Exception('User not authenticated');
    }

    final token = session.accessToken;

    final response = await _supabaseClient.functions.invoke(
      'create-user',
      body: {
        'email': email,
        'password': password,
        'full_name': fullName,
        'role': role,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


    if (response.status != 200) {
      final data = response.data as Map<String, dynamic>?;
      final errorMessage = data?['error'] as String? ?? 'Unknown error with status ${response.status}';
      throw Exception(errorMessage);
    }

    // Success
    return;
  } catch (e) {
    throw Exception('Failed to create user: ${e.toString()}');
  }
}
}
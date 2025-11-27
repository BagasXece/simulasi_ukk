import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Mock classes
class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockGoTrueClient extends Mock implements GoTrueClient {}
class MockAuthResponse extends Mock implements AuthResponse {}
class MockUser extends Mock implements User {}
class MockSession extends Mock implements Session {}

// Test utilities
void registerFallbackValues() {
  registerFallbackValue(MockSupabaseClient());
  registerFallbackValue(MockGoTrueClient());
  registerFallbackValue(AuthChangeEvent.signedIn);
}
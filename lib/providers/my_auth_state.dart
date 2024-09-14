import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateProvider {
  final SupabaseClient _supabaseClient;

  AuthStateProvider(this._supabaseClient);

  Future<void> signIn(String email, String password) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on AuthException catch (error) {
      throw Exception("Sign In Error: ${error.message}");
    } catch (error) {
      throw Exception("Unexpected error occurred during sign in: $error");
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _supabaseClient.auth.signUp(
        email: email.trim(),
        password: password.trim(),
      );
    } on AuthException catch (error) {
      throw Exception("Sign Up Error: ${error.message}");
    } catch (error) {
      throw Exception("Unexpected error occurred during sign up: $error");
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException catch (error) {
      throw Exception("Sign Out Error: ${error.message}");
    } catch (error) {
      throw Exception("Unexpected error occurred during sign out: $error");
    }
  }

  Stream<AuthState> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange;
  }

  Session? get currentSession {
    return _supabaseClient.auth.currentSession;
  }
}
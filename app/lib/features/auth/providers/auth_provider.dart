import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../data/models/user.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<User?> build() async {
    // Check if user is already logged in
    // For now, return null (not logged in)
    return null;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final apiClient = ref.read(apiClientProvider);
    
    try {
      final response = await apiClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      // Store tokens
      final accessToken = response.data['access_token'];
      // TODO: Store in secure storage
      
      // Fetch user profile
      final userResponse = await apiClient.get('/auth/me');
      state = AsyncValue.data(User.fromJson(userResponse.data));
      return true;
    } catch (e) {
      state = const AsyncValue.data(null);
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    String? nickname,
  }) async {
    final apiClient = ref.read(apiClientProvider);
    
    try {
      await apiClient.post('/auth/register', data: {
        'email': email,
        'password': password,
        'nickname': nickname,
      });
      
      // Auto login after registration
      return await login(email: email, password: password);
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    // TODO: Clear tokens from secure storage
    state = const AsyncValue.data(null);
  }

  bool get isAuthenticated => state.valueOrNull != null;
  User? get currentUser => state.valueOrNull;
}

@riverpod
Future<bool> checkAuth(CheckAuthRef ref) async {
  final authState = ref.watch(authStateProvider);
  return authState.valueOrNull != null;
}

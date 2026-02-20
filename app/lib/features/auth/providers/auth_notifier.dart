import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../data/models/user.dart';

/// 认证状态
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
}

/// 认证状态类
class AuthState {
  final AuthStatus status;
  final User? user;
  final String? accessToken;
  final String? refreshToken;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? accessToken,
    String? refreshToken,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: errorMessage,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
}

/// 认证 Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final Ref _ref;

  AuthNotifier(this._apiService, this._ref) : super(const AuthState());

  /// 登录
  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      final accessToken = response['access_token'] as String;
      final refreshToken = response['refresh_token'] as String;
      
      // 保存 Token
      _ref.read(authTokenProvider.notifier).state = accessToken;
      
      // 获取用户信息
      final userResponse = await _apiService.getCurrentUser();
      final user = User.fromJson(userResponse);

      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return true;
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// 注册
  Future<bool> register(String email, String password, String? nickname) async {
    try {
      await _apiService.register(
        email: email,
        password: password,
        nickname: nickname,
      );
      
      // 注册成功后自动登录
      return await login(email, password);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// 登出
  Future<void> logout() async {
    _ref.read(authTokenProvider.notifier).state = null;
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  /// 检查登录状态
  Future<void> checkAuthStatus() async {
    final token = _ref.read(authTokenProvider);
    if (token == null) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }

    try {
      final userResponse = await _apiService.getCurrentUser();
      final user = User.fromJson(userResponse);
      
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
        accessToken: token,
      );
    } catch (e) {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }
}

/// 认证 Provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthNotifier(apiService, ref);
});

/// 是否已认证
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).isAuthenticated;
});

/// 当前用户
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).user;
});

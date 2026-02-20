import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// API 配置
class ApiConfig {
  // 后端地址 - 根据实际情况修改
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  static BaseOptions get options => BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );
}

/// Dio 客户端 Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(ApiConfig.options);
  
  // 添加拦截器用于 Token
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // TODO: 添加 Token
      final token = ref.read(authTokenProvider);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (error, handler) {
      // 处理 401 错误
      if (error.response?.statusCode == 401) {
        // TODO: Token 过期处理
      }
      return handler.next(error);
    },
  ));
  
  return dio;
});

/// Token Provider
final authTokenProvider = StateProvider<String?>((ref) => null);

/// API 服务
class ApiService {
  final Dio _dio;
  
  ApiService(this._dio);
  
  /// 健康检查
  Future<Map<String, dynamic>> healthCheck() async {
    final response = await _dio.get('/health');
    return response.data;
  }
  
  /// 用户注册
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? nickname,
  }) async {
    final response = await _dio.post('/auth/register', data: {
      'email': email,
      'password': password,
      'nickname': nickname,
    });
    return response.data;
  }
  
  /// 用户登录
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return response.data;
  }
  
  /// 获取当前用户
  Future<Map<String, dynamic>> getCurrentUser() async {
    final response = await _dio.get('/auth/me');
    return response.data;
  }
  
  /// 获取箱子列表
  Future<List<dynamic>> getBoxes() async {
    final response = await _dio.get('/boxes');
    return response.data;
  }
  
  /// 获取箱子详情
  Future<Map<String, dynamic>> getBox(String id) async {
    final response = await _dio.get('/boxes/$id');
    return response.data;
  }
  
  /// 创建箱子
  Future<Map<String, dynamic>> createBox(Map<String, dynamic> data) async {
    final response = await _dio.post('/boxes', data: data);
    return response.data;
  }
  
  /// 更新箱子
  Future<Map<String, dynamic>> updateBox(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('/boxes/$id', data: data);
    return response.data;
  }
  
  /// 删除箱子
  Future<void> deleteBox(String id) async {
    await _dio.delete('/boxes/$id');
  }
  
  /// AI 识别物品
  Future<Map<String, dynamic>> recognizeItems(String imagePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
    });
    final response = await _dio.post('/ai/recognize', data: formData);
    return response.data;
  }
  
  /// AI 识别位置
  Future<Map<String, dynamic>> recognizeLocation(String imagePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
    });
    final response = await _dio.post('/ai/recognize-location', data: formData);
    return response.data;
  }
  
  /// 发送聊天消息
  Future<Map<String, dynamic>> sendMessage(String message, {String? sessionId}) async {
    final response = await _dio.post('/chat/message', data: {
      'message': message,
      'session_id': sessionId,
    });
    return response.data;
  }
  
  /// 获取聊天历史
  Future<List<dynamic>> getChatHistory(String sessionId) async {
    final response = await _dio.get('/chat/history/$sessionId');
    return response.data;
  }
}

/// API 服务 Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';

part 'ai_provider.g.dart';

@riverpod
class AIRecognition extends _$AIRecognition {
  @override
  FutureOr<List<Map<String, dynamic>>> build() {
    return [];
  }

  Future<List<Map<String, dynamic>>> recognizeItems(String imagePath) async {
    final apiClient = ref.read(apiClientProvider);
    
    state = const AsyncValue.loading();
    
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath),
      });
      
      final response = await apiClient.dio.post(
        '/ai/recognize-items',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      
      final items = (response.data['items'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      
      state = AsyncValue.data(items);
      return items;
    } catch (e) {
      state = const AsyncValue.data([]);
      return [];
    }
  }

  Future<Map<String, dynamic>?> recognizeLocation(String imagePath) async {
    final apiClient = ref.read(apiClientProvider);
    
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath),
      });
      
      final response = await apiClient.dio.post(
        '/ai/recognize-location',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      return null;
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

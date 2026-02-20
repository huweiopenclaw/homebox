import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../data/models/box.dart';

part 'box_provider.g.dart';

@riverpod
class BoxList extends _$BoxList {
  @override
  Future<List<Box>> build() async {
    final apiClient = ref.watch(apiClientProvider);
    
    try {
      final response = await apiClient.get('/boxes');
      final data = response.data as List;
      return data.map((json) => Box.fromJson(json)).toList();
    } catch (e) {
      // Return empty list on error for now
      return [];
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> createBox({
    required String name,
    String? category,
    String? itemPhoto,
    String? locPhoto,
  }) async {
    final apiClient = ref.read(apiClientProvider);
    
    await apiClient.post('/boxes', data: {
      'name': name,
      'category': category,
      'item_photo': itemPhoto,
      'loc_photo': locPhoto,
    });
    
    await refresh();
  }

  Future<void> deleteBox(String boxId) async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.delete('/boxes/$boxId');
    await refresh();
  }
}

@riverpod
class BoxDetail extends _$BoxDetail {
  @override
  Future<Box?> build(String boxId) async {
    final apiClient = ref.watch(apiClientProvider);
    
    try {
      final response = await apiClient.get('/boxes/$boxId');
      return Box.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateBox({
    required String name,
    String? category,
  }) async {
    final apiClient = ref.read(apiClientProvider);
    
    await apiClient.put('/boxes/${state.value?.id}', data: {
      'name': name,
      'category': category,
    });
    
    ref.invalidateSelf();
  }

  Future<void> addItem({
    required String name,
    int quantity = 1,
  }) async {
    final apiClient = ref.read(apiClientProvider);
    
    await apiClient.post('/boxes/${state.value?.id}/items', data: {
      'name': name,
      'quantity': quantity,
    });
    
    ref.invalidateSelf();
  }

  Future<void> removeItem(String itemId) async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.delete('/items/$itemId');
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<Box>> searchItems(SearchItemsRef ref, String query) async {
  if (query.isEmpty) return [];
  
  final apiClient = ref.watch(apiClientProvider);
  
  try {
    final response = await apiClient.get('/boxes/search', queryParameters: {
      'q': query,
    });
    final data = response.data as List;
    return data.map((json) => Box.fromJson(json)).toList();
  } catch (e) {
    return [];
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../data/models/box.dart';

/// 箱子列表状态
class BoxesState {
  final List<Box> boxes;
  final bool isLoading;
  final String? errorMessage;

  const BoxesState({
    this.boxes = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  BoxesState copyWith({
    List<Box>? boxes,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BoxesState(
      boxes: boxes ?? this.boxes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// 箱子管理 Notifier
class BoxesNotifier extends StateNotifier<BoxesState> {
  final ApiService _apiService;

  BoxesNotifier(this._apiService) : super(const BoxesState());

  /// 加载箱子列表
  Future<void> loadBoxes() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final response = await _apiService.getBoxes();
      final boxes = (response as List).map((e) => Box.fromJson(e)).toList();
      state = BoxesState(boxes: boxes);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '加载失败: ${e.toString()}',
      );
    }
  }

  /// 创建箱子
  Future<bool> createBox(BoxCreate boxCreate) async {
    try {
      final response = await _apiService.createBox(boxCreate.toJson());
      final newBox = Box.fromJson(response);
      state = BoxesState(boxes: [...state.boxes, newBox]);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: '创建失败: ${e.toString()}');
      return false;
    }
  }

  /// 更新箱子
  Future<bool> updateBox(String id, Map<String, dynamic> data) async {
    try {
      final response = await _apiService.updateBox(id, data);
      final updatedBox = Box.fromJson(response);
      final boxes = state.boxes.map((b) => b.id == id ? updatedBox : b).toList();
      state = BoxesState(boxes: boxes);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: '更新失败: ${e.toString()}');
      return false;
    }
  }

  /// 删除箱子
  Future<bool> deleteBox(String id) async {
    try {
      await _apiService.deleteBox(id);
      final boxes = state.boxes.where((b) => b.id != id).toList();
      state = BoxesState(boxes: boxes);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: '删除失败: ${e.toString()}');
      return false;
    }
  }

  /// 搜索物品
  List<Box> searchItems(String query) {
    if (query.isEmpty) return state.boxes;
    
    return state.boxes.where((box) {
      final nameMatch = box.name.toLowerCase().contains(query.toLowerCase());
      final itemMatch = box.items.any((item) => 
        item.name.toLowerCase().contains(query.toLowerCase()));
      return nameMatch || itemMatch;
    }).toList();
  }
}

/// 箱子 Provider
final boxesProvider = StateNotifierProvider<BoxesNotifier, BoxesState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return BoxesNotifier(apiService);
});

/// 搜素 Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = Provider<List<Box>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final boxesNotifier = ref.watch(boxesProvider.notifier);
  return boxesNotifier.searchItems(query);
});

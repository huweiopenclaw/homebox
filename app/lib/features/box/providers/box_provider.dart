import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/box.dart';

final boxesProvider = StateNotifierProvider<BoxesNotifier, AsyncValue<List<Box>>>((ref) {
  return BoxesNotifier();
});

class BoxesNotifier extends StateNotifier<AsyncValue<List<Box>>> {
  BoxesNotifier() : super(const AsyncValue.data([]));

  Future<void> loadBoxes() async {
    state = const AsyncValue.loading();
    try {
      // TODO: Implement actual API call
      state = const AsyncValue.data([]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addBox(Box box) async {
    final currentBoxes = state.valueOrNull ?? [];
    state = AsyncValue.data([...currentBoxes, box]);
  }
}

// Search items across all boxes
final searchItemsProvider = FutureProvider.family<List<Item>, String>((ref, query) async {
  // TODO: Implement actual search
  return [];
});

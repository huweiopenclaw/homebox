import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiLoadingProvider = StateProvider<bool>((ref) => false);

final aiResultProvider = StateProvider<String?>((ref) => null);

class AIRecognitionService {
  Future<Map<String, dynamic>> recognizeItems(String imagePath) async {
    // TODO: Implement actual API call
    return {'items': [], 'summary': ''};
  }

  Future<Map<String, dynamic>> recognizeLocation(String imagePath) async {
    // TODO: Implement actual API call
    return {'room': '', 'furniture': '', 'position': ''};
  }
}

final aiServiceProvider = Provider<AIRecognitionService>((ref) {
  return AIRecognitionService();
});

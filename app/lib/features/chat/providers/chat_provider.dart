import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/chat.dart';

final chatSessionsProvider = StateNotifierProvider<ChatSessionsNotifier, List<ChatSession>>((ref) {
  return ChatSessionsNotifier();
});

class ChatSessionsNotifier extends StateNotifier<List<ChatSession>> {
  ChatSessionsNotifier() : super([]);

  void addSession(ChatSession session) {
    state = [...state, session];
  }

  void addMessage(String sessionId, ChatMessage message) {
    state = state.map((s) {
      if (s.id == sessionId) {
        return ChatSession(
          id: s.id,
          title: s.title,
          messages: [...s.messages, message],
          createdAt: s.createdAt,
          updatedAt: DateTime.now(),
        );
      }
      return s;
    }).toList();
  }
}

final currentSessionProvider = StateProvider<ChatSession?>((ref) => null);

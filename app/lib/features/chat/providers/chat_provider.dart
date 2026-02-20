import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../data/models/chat.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatHistory extends _$ChatHistory {
  @override
  Future<List<ChatSession>> build() async {
    final apiClient = ref.watch(apiClientProvider);
    
    try {
      final response = await apiClient.get('/chat/sessions');
      final data = response.data as List;
      return data.map((json) => ChatSession.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}

@riverpod
class ActiveChatSession extends _$ActiveChatSession {
  @override
  Future<ChatSession?> build(String? sessionId) async {
    if (sessionId == null) return null;
    
    final apiClient = ref.watch(apiClientProvider);
    
    try {
      final response = await apiClient.get('/chat/sessions/$sessionId');
      return ChatSession.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<void> sendMessage(String content) async {
    final apiClient = ref.read(apiClientProvider);
    final currentSession = state.valueOrNull;
    
    try {
      final response = await apiClient.post('/chat/message', data: {
        'session_id': currentSession?.id,
        'content': content,
      });
      
      // Update with new messages
      if (currentSession != null) {
        final updatedSession = ChatSession.fromJson(response.data);
        state = AsyncValue.data(updatedSession);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> createNewSession() async {
    final apiClient = ref.read(apiClientProvider);
    
    try {
      final response = await apiClient.post('/chat/sessions');
      state = AsyncValue.data(ChatSession.fromJson(response.data));
    } catch (e) {
      // Handle error
    }
  }
}

@riverpod
Future<ChatMessage> askAssistant(
  AskAssistantRef ref, {
  required String question,
  String? sessionId,
}) async {
  final apiClient = ref.watch(apiClientProvider);
  
  final response = await apiClient.post('/chat/ask', data: {
    'question': question,
    'session_id': sessionId,
  });
  
  return ChatMessage.fromJson(response.data);
}

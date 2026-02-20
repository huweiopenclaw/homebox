import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../data/models/chat.dart';

/// 聊天状态
class ChatState {
  final List<ChatSession> sessions;
  final ChatSession? currentSession;
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? errorMessage;

  const ChatState({
    this.sessions = const [],
    this.currentSession,
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ChatSession>? sessions,
    ChatSession? currentSession,
    List<ChatMessage>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      sessions: sessions ?? this.sessions,
      currentSession: currentSession ?? this.currentSession,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// 聊天 Notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final ApiService _apiService;

  ChatNotifier(this._apiService) : super(const ChatState());

  /// 发送消息
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // 添加用户消息
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'user',
      content: content,
      createdAt: DateTime.now(),
    );
    
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    );

    try {
      final response = await _apiService.sendMessage(
        content,
        sessionId: state.currentSession?.id,
      );

      final assistantMessage = ChatMessage(
        id: response['message_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        role: 'assistant',
        content: response['content'] ?? response['message'] ?? '抱歉，我没有理解您的问题。',
        createdAt: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, assistantMessage],
        isLoading: false,
        currentSession: state.currentSession != null
            ? ChatSession(
                id: state.currentSession!.id,
                title: response['title'] ?? state.currentSession!.title,
                messages: [...state.messages, userMessage, assistantMessage],
                createdAt: state.currentSession!.createdAt,
                updatedAt: DateTime.now(),
              )
            : ChatSession(
                id: response['session_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                title: response['title'] ?? '新对话',
                messages: [userMessage, assistantMessage],
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '发送失败: ${e.toString()}',
      );
    }
  }

  /// 清除当前对话
  void clearCurrentChat() {
    state = state.copyWith(
      currentSession: null,
      messages: [],
    );
  }

  /// 加载对话历史
  Future<void> loadChatHistory(String sessionId) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await _apiService.getChatHistory(sessionId);
      final messages = (response as List)
          .map((e) => ChatMessage.fromJson(e))
          .toList();
      
      state = state.copyWith(
        messages: messages,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '加载失败: ${e.toString()}',
      );
    }
  }
}

/// 聊天 Provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ChatNotifier(apiService);
});

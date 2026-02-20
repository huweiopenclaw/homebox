import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/chat_provider.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text;
    if (message.isEmpty) return;

    _messageController.clear();
    
    await ref.read(chatProvider.notifier).sendMessage(message);
    
    // 滚动到底部
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('智能助手'),
        actions: [
          if (chatState.messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(chatProvider.notifier).clearCurrentChat();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: chatState.messages.isEmpty
                ? _buildEmptyState()
                : _buildMessageList(chatState),
          ),
          
          // 输入框
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: '问我任何关于收纳的问题...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    maxLines: 3,
                    minLines: 1,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: chatState.isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            '智能收纳助手',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('问我任何关于收纳的问题'),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSuggestion('我的螺丝刀在哪里？'),
              _buildSuggestion('如何整理厨房？'),
              _buildSuggestion('列出所有箱子'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestion(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _messageController.text = text;
        _sendMessage();
      },
    );
  }

  Widget _buildMessageList(ChatState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: state.messages.length + (state.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.messages.length) {
          return _buildTypingIndicator();
        }

        final message = state.messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(message) {
    final isUser = message.role == 'user';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.deepPurple : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.content,
                style: TextStyle(color: isUser ? Colors.white : Colors.black87),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              child: Icon(Icons.person, size: 20),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const SizedBox(
              width: 40,
              height: 20,
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

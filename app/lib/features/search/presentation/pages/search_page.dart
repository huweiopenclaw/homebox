import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../box/providers/boxes_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '搜索物品或箱子...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
        ],
      ),
      body: _searchController.text.isEmpty
          ? _buildEmptyState()
          : _buildSearchResults(searchResults),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('输入关键词搜索物品', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List boxes) {
    if (boxes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('没有找到 "${_searchController.text}"'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: boxes.length,
      itemBuilder: (context, index) {
        final box = boxes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.withOpacity(0.1),
              child: const Icon(Icons.inventory_2, color: Colors.deepPurple),
            ),
            title: Text(box.name),
            subtitle: Text('${box.items.length} 件物品 · ${box.room ?? "未分类"}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // 跳转到箱子详情
              Navigator.pop(context);
              // context.push('/boxes/${box.id}');
            },
          ),
        );
      },
    );
  }
}

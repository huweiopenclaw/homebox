import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/box_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '搜索物品...',
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() => _isSearching = false);
            }
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() => _isSearching = false);
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (!_isSearching) {
      return _buildSuggestions();
    }

    final searchResults = ref.watch(
      searchItemsProvider(_searchController.text),
    );

    return searchResults.when(
      data: (boxes) {
        if (boxes.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text('未找到 "${_searchController.text}" 相关的物品'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: boxes.length,
          itemBuilder: (context, index) {
            final box = boxes[index];
            return ListTile(
              leading: const Icon(Icons.inventory_2),
              title: Text(box.name),
              subtitle: Text(box.locationDescription ?? ''),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push('/boxes/${box.id}');
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('搜索出错: $error')),
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '快捷搜索',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSuggestionChip('围巾'),
              _buildSuggestionChip('护照'),
              _buildSuggestionChip('充电器'),
              _buildSuggestionChip('冬季衣物'),
              _buildSuggestionChip('工具'),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            '搜索示例',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          _buildExampleItem(
            question: '我的围巾在哪里？',
            description: '直接询问物品位置',
          ),
          _buildExampleItem(
            question: '护照在哪个箱子？',
            description: '查找特定物品',
          ),
          _buildExampleItem(
            question: '有什么冬季衣物？',
            description: '按类别搜索',
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        _searchController.text = label;
        _performSearch(label);
      },
    );
  }

  Widget _buildExampleItem({
    required String question,
    required String description,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.help_outline, color: AppColors.primaryLight),
      ),
      title: Text(question),
      subtitle: Text(description),
      onTap: () {
        _searchController.text = question;
        _performSearch(question);
      },
    );
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() => _isSearching = true);
  }
}

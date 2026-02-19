import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

class BoxListPage extends ConsumerStatefulWidget {
  const BoxListPage({super.key});

  @override
  ConsumerState<BoxListPage> createState() => _BoxListPageState();
}

class _BoxListPageState extends ConsumerState<BoxListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('所有箱子'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _BoxListTile(
            name: '箱子 ${index + 1}',
            room: ['卧室', '客厅', '储藏室', '书房', '阳台'][index],
            furniture: '衣柜',
            itemCount: 3 + index,
            onTap: () {
              // Navigate to detail
            },
          );
        },
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '筛选',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: ['全部', '卧室', '客厅', '储藏室', '书房', '阳台']
                    .map((room) => FilterChip(
                          label: Text(room),
                          selected: room == '全部',
                          onSelected: (selected) {},
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: ['全部', '衣物', '书籍', '杂物', '电子产品']
                    .map((category) => FilterChip(
                          label: Text(category),
                          selected: category == '全部',
                          onSelected: (selected) {},
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BoxListTile extends StatelessWidget {
  final String name;
  final String room;
  final String furniture;
  final int itemCount;
  final VoidCallback onTap;

  const _BoxListTile({
    required this.name,
    required this.room,
    required this.furniture,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.inventory_2,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '$room · $furniture',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$itemCount 件',
                      style: const TextStyle(
                        color: AppColors.secondaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

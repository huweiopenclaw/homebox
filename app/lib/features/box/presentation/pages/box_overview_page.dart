import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/boxes_provider.dart';

class BoxOverviewPage extends ConsumerStatefulWidget {
  const BoxOverviewPage({super.key});

  @override
  ConsumerState<BoxOverviewPage> createState() => _BoxOverviewPageState();
}

class _BoxOverviewPageState extends ConsumerState<BoxOverviewPage> {
  @override
  void initState() {
    super.initState();
    // 加载箱子列表
    Future.microtask(() => ref.read(boxesProvider.notifier).loadBoxes());
  }

  @override
  Widget build(BuildContext context) {
    final boxesState = ref.watch(boxesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收纳'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: _buildBody(boxesState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-box'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BoxesState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(state.errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(boxesProvider.notifier).loadBoxes(),
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (state.boxes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('还没有箱子', style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 8),
            Text('点击右下角按钮添加第一个箱子'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(boxesProvider.notifier).loadBoxes(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.boxes.length,
        itemBuilder: (context, index) {
          final box = state.boxes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                child: const Icon(Icons.inventory_2, color: Colors.deepPurple),
              ),
              title: Text(box.name),
              subtitle: Text(
                '${box.items.length} 件物品 · ${box.room ?? '未分类'}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/boxes/${box.id}'),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../box/providers/boxes_provider.dart';
import '../../../auth/providers/auth_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // 加载数据
    Future.microtask(() {
      ref.read(boxesProvider.notifier).loadBoxes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _BoxesTab(),
          _ChatTab(),
          _ProfileTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: '收纳',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: '助手',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

class _BoxesTab extends ConsumerWidget {
  const _BoxesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: _buildBody(context, ref, boxesState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-box'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, BoxesState state) {
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('还没有箱子', style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('点击右下角按钮添加第一个箱子'),
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

class _ChatTab extends StatelessWidget {
  const _ChatTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('智能助手')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('问我任何关于收纳的问题'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push('/chat'),
              icon: const Icon(Icons.chat),
              label: const Text('开始对话'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTab extends ConsumerWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: ListView(
        children: [
          // 用户信息卡片
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      user?.nickname?.substring(0, 1) ?? 
                      user?.email.substring(0, 1).toUpperCase() ?? '?',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.nickname ?? '用户',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => context.push('/settings'),
                  ),
                ],
              ),
            ),
          ),

          // 功能入口
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('拍照识别'),
            subtitle: const Text('拍照识别物品并添加到箱子'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 拍照识别
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text('扫码'),
            subtitle: const Text('扫描箱子二维码快速定位'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 扫码
            },
          ),
          
          const Divider(),
          
          // 统计信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('箱子', '0'),
                _buildStatItem('物品', '0'),
                _buildStatItem('房间', '0'),
              ],
            ),
          ),
          
          if (!authState.isAuthenticated)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => context.push('/login'),
                child: const Text('登录/注册'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

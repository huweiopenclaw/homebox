import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/providers/auth_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          // 用户信息
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
                      user?.nickname?.substring(0, 1) ?? user?.email.substring(0, 1).toUpperCase() ?? '?',
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
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),
          
          // 设置选项
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('个人资料'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 编辑个人资料
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('修改密码'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 修改密码
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('通知设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 通知设置
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('主题设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 主题设置
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('语言'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 语言设置
            },
          ),
          
          const SizedBox(height: 16),
          
          // 关于
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('关于'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'HomeBox',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2026 HomeBox',
                children: const [
                  SizedBox(height: 16),
                  Text('智能家庭收纳助手'),
                  SizedBox(height: 8),
                  Text('使用 AI 技术帮助你管理家庭物品'),
                ],
              );
            },
          ),
          
          const SizedBox(height: 32),
          
          // 登出按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: authState.isAuthenticated
                  ? () async {
                      await ref.read(authStateProvider.notifier).logout();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    }
                  : null,
              child: const Text('退出登录'),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

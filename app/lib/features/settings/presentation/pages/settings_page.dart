import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          _buildSection('外观', [
            SwitchListTile(
              title: const Text('深色模式'),
              subtitle: const Text('切换深色/浅色主题'),
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
              },
            ),
          ]),
          _buildSection('通知', [
            SwitchListTile(
              title: const Text('推送通知'),
              subtitle: const Text('接收物品过期提醒'),
              value: _notifications,
              onChanged: (value) {
                setState(() => _notifications = value);
              },
            ),
          ]),
          _buildSection('数据', [
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('备份数据'),
              subtitle: const Text('将数据备份到云端'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('恢复数据'),
              subtitle: const Text('从云端恢复数�?),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: AppColors.errorLight),
              title: const Text('清除所有数�?, style: TextStyle(color: AppColors.errorLight)),
              subtitle: const Text('删除所有本地数�?),
              onTap: () {
                _showClearDataConfirmDialog();
              },
            ),
          ]),
          _buildSection('关于', [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('版本'),
              trailing: const Text('1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('用户协议'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('隐私政策'),
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondaryLight,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }

  void _showClearDataConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('清除所有数�?),
          content: const Text('此操作将删除所有本地存储的收纳数据，且不可恢复。确定要继续吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('数据已清�?)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorLight,
              ),
              child: const Text('清除'),
            ),
          ],
        );
      },
    );
  }
}

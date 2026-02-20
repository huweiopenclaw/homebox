import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/box.dart';
import '../../providers/boxes_provider.dart';

class BoxDetailPage extends ConsumerStatefulWidget {
  final String boxId;

  const BoxDetailPage({super.key, required this.boxId});

  @override
  ConsumerState<BoxDetailPage> createState() => _BoxDetailPageState();
}

class _BoxDetailPageState extends ConsumerState<BoxDetailPage> {
  Box? _box;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBox();
  }

  void _loadBox() {
    final boxesState = ref.read(boxesProvider);
    final box = boxesState.boxes.where((b) => b.id == widget.boxId).firstOrNull;
    
    if (box != null) {
      setState(() {
        _box = box;
        _isLoading = false;
      });
    } else {
      // 如果列表中没有，从 API 加载
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('加载中...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_box == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('箱子详情')),
        body: const Center(child: Text('箱子不存在')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_box!.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('删除箱子'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 位置信息
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('位置信息', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.room, '房间', _box!.room),
                    _buildInfoRow(Icons.chair, '家具', _box!.furniture),
                    _buildInfoRow(Icons.place, '位置', _box!.position),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 物品列表
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '物品 (${_box!.items.length})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('添加物品'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            if (_box!.items.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text('还没有物品', style: TextStyle(color: Colors.grey)),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _box!.items.length,
                itemBuilder: (context, index) {
                  final item = _box!.items[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        child: Text('${item.quantity}'),
                      ),
                      title: Text(item.name),
                      subtitle: item.note != null ? Text(item.note!) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(color: Colors.grey)),
          Text(value ?? '未设置'),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除箱子'),
        content: Text('确定要删除 "${_box!.name}" 吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final success = await ref.read(boxesProvider.notifier).deleteBox(widget.boxId);
              if (success && mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

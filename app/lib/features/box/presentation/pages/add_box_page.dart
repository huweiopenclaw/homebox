import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/box.dart';
import '../../providers/boxes_provider.dart';

class AddBoxPage extends ConsumerStatefulWidget {
  const AddBoxPage({super.key});

  @override
  ConsumerState<AddBoxPage> createState() => _AddBoxPageState();
}

class _AddBoxPageState extends ConsumerState<AddBoxPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roomController = TextEditingController();
  final _furnitureController = TextEditingController();
  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _roomController.dispose();
    _furnitureController.dispose();
    _positionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final boxCreate = BoxCreate(
      name: _nameController.text,
      room: _roomController.text.isEmpty ? null : _roomController.text,
      furniture: _furnitureController.text.isEmpty ? null : _furnitureController.text,
      position: _positionController.text.isEmpty ? null : _positionController.text,
      locationDescription: _descriptionController.text.isEmpty ? null : _descriptionController.text,
    );

    final success = await ref.read(boxesProvider.notifier).createBox(boxCreate);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('箱子创建成功')),
        );
        context.pop();
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('创建失败，请重试')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加箱子'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submit,
            child: const Text('保存'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 箱子名称
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '箱子名称 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory_2),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入箱子名称';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 房间
            TextFormField(
              controller: _roomController,
              decoration: const InputDecoration(
                labelText: '房间',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.room),
                hintText: '如：客厅、卧室',
              ),
            ),
            const SizedBox(height: 16),
            
            // 家具
            TextFormField(
              controller: _furnitureController,
              decoration: const InputDecoration(
                labelText: '家具',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.chair),
                hintText: '如：书架、衣柜',
              ),
            ),
            const SizedBox(height: 16),
            
            // 位置
            TextFormField(
              controller: _positionController,
              decoration: const InputDecoration(
                labelText: '具体位置',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place),
                hintText: '如：第2层、左边',
              ),
            ),
            const SizedBox(height: 16),
            
            // 描述
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '备注',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            // 提示
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.white),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '创建箱子后，可以使用拍照功能快速添加物品',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}

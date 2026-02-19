import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class AddBoxPage extends ConsumerStatefulWidget {
  const AddBoxPage({super.key});

  @override
  ConsumerState<AddBoxPage> createState() => _AddBoxPageState();
}

class _AddBoxPageState extends ConsumerState<AddBoxPage> {
  final _nameController = TextEditingController();
  int _currentStep = 0;
  String? _itemImagePath;
  String? _locationImagePath;
  List<Map<String, dynamic>> _recognizedItems = [];
  Map<String, dynamic>? _recognizedLocation;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加箱子'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 2 ? '完成' : '下一步'),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('上一步'),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('物品照片'),
            isActive: _currentStep >= 0,
            content: _buildItemPhotoStep(),
          ),
          Step(
            title: const Text('位置照片'),
            isActive: _currentStep >= 1,
            content: _buildLocationPhotoStep(),
          ),
          Step(
            title: const Text('确认保存'),
            isActive: _currentStep >= 2,
            content: _buildConfirmStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildItemPhotoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '请拍摄箱子内的物品',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _pickItemPhoto,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _itemImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _itemImagePath!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('点击拍照或选择照片'),
                    ],
                  ),
          ),
        ),
        if (_recognizedItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'AI 识别结果:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...(_recognizedItems.map((item) => ListTile(
                leading: const Icon(Icons.check_circle, color: AppColors.successLight),
                title: Text(item['name']),
                trailing: Text('x${item['quantity']}'),
              ))),
        ],
      ],
    );
  }

  Widget _buildLocationPhotoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '请拍摄箱子存放的位置',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _pickLocationPhoto,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _locationImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _locationImagePath!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('点击拍照或选择照片'),
                    ],
                  ),
          ),
        ),
        if (_recognizedLocation != null) ...[
          const SizedBox(height: 16),
          Text(
            'AI 识别位置:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _recognizedLocation?['description'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildConfirmStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '箱子名称',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: '例如: 冬季衣物-1',
            prefixIcon: Icon(Icons.edit),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '识别的物品 (${_recognizedItems.length}件)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...(_recognizedItems.map((item) => Card(
              child: ListTile(
                leading: const Icon(Icons.inventory_2),
                title: Text(item['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (item['quantity'] > 1) {
                            item['quantity']--;
                          }
                        });
                      },
                    ),
                    Text('${item['quantity']}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          item['quantity']++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ))),
      ],
    );
  }

  void _pickItemPhoto() {
    // Simulate photo pick and AI recognition
    setState(() {
      _itemImagePath = 'assets/images/placeholder_box.jpg';
      _recognizedItems = [
        {'name': '红色毛衣', 'quantity': 2, 'confidence': 0.95},
        {'name': '灰色围巾', 'quantity': 1, 'confidence': 0.90},
        {'name': '毛线帽', 'quantity': 1, 'confidence': 0.88},
      ];
    });
  }

  void _pickLocationPhoto() {
    // Simulate photo pick and AI recognition
    setState(() {
      _locationImagePath = 'assets/images/placeholder_location.jpg';
      _recognizedLocation = {
        'room': '卧室',
        'furniture': '衣柜',
        'position': '左侧顶层',
        'description': '卧室衣柜左侧顶层',
      };
    });
  }

  void _onStepContinue() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Save and go back
      _saveBox();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _saveBox() {
    // TODO: Implement save logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('箱子保存成功！')),
    );
    context.pop();
  }
}

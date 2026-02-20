import 'package:flutter/material.dart';

class AddBoxPage extends StatefulWidget {
  const AddBoxPage({super.key});

  @override
  State<AddBoxPage> createState() => _AddBoxPageState();
}

class _AddBoxPageState extends State<AddBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('添加箱子')),
      body: const Center(child: Text('添加箱子')),
    );
  }
}

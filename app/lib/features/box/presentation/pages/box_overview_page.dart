import 'package:flutter/material.dart';

class BoxOverviewPage extends StatefulWidget {
  const BoxOverviewPage({super.key});

  @override
  State<BoxOverviewPage> createState() => _BoxOverviewPageState();
}

class _BoxOverviewPageState extends State<BoxOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('箱子列表')),
      body: const Center(child: Text('箱子列表')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

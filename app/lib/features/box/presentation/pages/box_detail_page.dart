import 'package:flutter/material.dart';

class BoxDetailPage extends StatefulWidget {
  final String boxId;
  
  const BoxDetailPage({super.key, required this.boxId});

  @override
  State<BoxDetailPage> createState() => _BoxDetailPageState();
}

class _BoxDetailPageState extends State<BoxDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('箱子详情: ${widget.boxId}')),
      body: Center(child: Text('箱子ID: ${widget.boxId}')),
    );
  }
}

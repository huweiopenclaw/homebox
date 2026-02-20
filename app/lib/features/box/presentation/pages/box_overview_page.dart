import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/models/enums.dart';

class BoxOverviewPage extends ConsumerStatefulWidget {
  const BoxOverviewPage({super.key});

  @override
  ConsumerState<BoxOverviewPage> createState() => _BoxOverviewPageState();
}

class _BoxOverviewPageState extends ConsumerState<BoxOverviewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedRoom;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收纳总览'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '按房间'),
            Tab(text: '按分类'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildByRoom(),
          _buildByCategory(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-box'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildByRoom() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: Room.defaults.length,
      itemBuilder: (context, index) {
        final room = Room.defaults[index];
        return _buildRoomCard(room);
      },
    );
  }

  Widget _buildRoomCard(Room room) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showRoomDetail(room),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    room.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${room.boxCount} 个箱子',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildByCategory() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: Category.defaults.length,
      itemBuilder: (context, index) {
        final category = Category.defaults[index];
        return _buildCategoryCard(category);
      },
    );
  }

  Widget _buildCategoryCard(Category category) {
    return Card(
      child: InkWell(
        onTap: () => _showCategoryDetail(category),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.icon,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${category.itemCount} 件',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRoomDetail(Room room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.25,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        room.icon,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        room.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: Furniture.defaults
                        .where((f) => f.roomId == room.id)
                        .length,
                    itemBuilder: (context, index) {
                      final furniture = Furniture.defaults
                          .where((f) => f.roomId == room.id)
                          .elementAt(index);
                      return ListTile(
                        leading: Text(furniture.icon),
                        title: Text(furniture.name),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Navigate to furniture detail
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showCategoryDetail(Category category) {
    // Navigate to category filter
    context.push('/boxes');
  }
}

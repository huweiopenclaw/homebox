class Room {
  final String id;
  final String name;
  final String icon;
  final int boxCount;

  const Room({
    required this.id,
    required this.name,
    required this.icon,
    this.boxCount = 0,
  });

  static const List<Room> defaults = [
    Room(id: 'living_room', name: '客厅', icon: '🛋️'),
    Room(id: 'bedroom', name: '卧室', icon: '🛏️'),
    Room(id: 'kitchen', name: '厨房', icon: '🍳'),
    Room(id: 'bathroom', name: '卫生间', icon: '🚿'),
    Room(id: 'study', name: '书房', icon: '📚'),
    Room(id: 'storage', name: '储藏室', icon: '📦'),
    Room(id: 'garage', name: '车库', icon: '🚗'),
    Room(id: 'balcony', name: '阳台', icon: '🌱'),
  ];
}

class Furniture {
  final String id;
  final String name;
  final String icon;
  final String roomId;

  const Furniture({
    required this.id,
    required this.name,
    required this.icon,
    required this.roomId,
  });

  static const List<Furniture> defaults = [
    // Living room
    Furniture(id: 'sofa', name: '沙发', icon: '🛋️', roomId: 'living_room'),
    Furniture(id: 'tv_cabinet', name: '电视柜', icon: '📺', roomId: 'living_room'),
    Furniture(id: 'coffee_table', name: '茶几', icon: '☕', roomId: 'living_room'),
    Furniture(id: 'bookshelf', name: '书架', icon: '📚', roomId: 'living_room'),
    
    // Bedroom
    Furniture(id: 'wardrobe', name: '衣柜', icon: '🚪', roomId: 'bedroom'),
    Furniture(id: 'bed', name: '床', icon: '🛏️', roomId: 'bedroom'),
    Furniture(id: 'bedside_table', name: '床头柜', icon: '🪑', roomId: 'bedroom'),
    Furniture(id: 'dresser', name: '梳妆台', icon: '🪞', roomId: 'bedroom'),
    
    // Kitchen
    Furniture(id: 'cabinet', name: '橱柜', icon: '🗄️', roomId: 'kitchen'),
    Furniture(id: 'refrigerator', name: '冰箱', icon: '❄️', roomId: 'kitchen'),
    Furniture(id: 'pantry', name: '储物柜', icon: '🥫', roomId: 'kitchen'),
    
    // Study
    Furniture(id: 'desk', name: '书桌', icon: '🖥️', roomId: 'study'),
    Furniture(id: 'file_cabinet', name: '文件柜', icon: '📁', roomId: 'study'),
    
    // Storage
    Furniture(id: 'shelf', name: '架子', icon: '📐', roomId: 'storage'),
    Furniture(id: 'box', name: '收纳箱', icon: '📦', roomId: 'storage'),
  ];
}

class Category {
  final String id;
  final String name;
  final String icon;
  final int itemCount;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    this.itemCount = 0,
  });

  static const List<Category> defaults = [
    Category(id: 'clothing', name: '衣物', icon: '👕'),
    Category(id: 'books', name: '书籍', icon: '📚'),
    Category(id: 'electronics', name: '电子产品', icon: '📱'),
    Category(id: 'documents', name: '文件', icon: '📄'),
    Category(id: 'tools', name: '工具', icon: '🔧'),
    Category(id: 'toys', name: '玩具', icon: '🎮'),
    Category(id: 'kitchenware', name: '厨具', icon: '🍳'),
    Category(id: 'decorations', name: '装饰品', icon: '🎨'),
    Category(id: 'sports', name: '运动用品', icon: '⚽'),
    Category(id: 'medicine', name: '药品', icon: '💊'),
    Category(id: 'food', name: '食品', icon: '🍜'),
    Category(id: 'other', name: '其他', icon: '📦'),
  ];
}

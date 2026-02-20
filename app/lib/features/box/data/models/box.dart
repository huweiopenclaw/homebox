class Box {
  final String id;
  final String name;
  final String? category;
  final String? room;
  final String? furniture;
  final String? position;
  final String? locationDescription;
  final List<Item> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Box({
    required this.id,
    required this.name,
    this.category,
    this.room,
    this.furniture,
    this.position,
    this.locationDescription,
    this.items = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      room: json['room'] as String?,
      furniture: json['furniture'] as String?,
      position: json['position'] as String?,
      locationDescription: json['location_description'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'room': room,
      'furniture': furniture,
      'position': position,
      'location_description': locationDescription,
      'items': items.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Item {
  final String id;
  final String name;
  final int quantity;
  final String? note;
  final DateTime? expiryDate;
  final double? confidence;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    required this.id,
    required this.name,
    required this.quantity,
    this.note,
    this.expiryDate,
    this.confidence,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      note: json['note'] as String?,
      expiryDate: json['expiry_date'] != null
          ? DateTime.parse(json['expiry_date'] as String)
          : null,
      confidence: (json['confidence'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'note': note,
      'expiry_date': expiryDate?.toIso8601String(),
      'confidence': confidence,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class BoxCreate {
  final String name;
  final String? category;
  final String? room;
  final String? furniture;
  final String? position;
  final String? locationDescription;

  const BoxCreate({
    required this.name,
    this.category,
    this.room,
    this.furniture,
    this.position,
    this.locationDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'room': room,
      'furniture': furniture,
      'position': position,
      'location_description': locationDescription,
    };
  }
}

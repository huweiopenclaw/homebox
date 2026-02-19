// Unit tests for Box model

import 'package:flutter_test/flutter_test.dart';
import 'package:homebox/features/box/data/models/box.dart';

void main() {
  group('Box Model', () {
    test('should create a Box instance', () {
      final box = Box(
        id: 'box_123',
        name: 'Test Box',
        items: [],
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      expect(box.id, 'box_123');
      expect(box.name, 'Test Box');
      expect(box.items, isEmpty);
    });

    test('should serialize to JSON', () {
      final box = Box(
        id: 'box_123',
        name: 'Test Box',
        room: '卧室',
        items: [],
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      final json = box.toJson();
      
      expect(json['id'], 'box_123');
      expect(json['name'], 'Test Box');
      expect(json['room'], '卧室');
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'box_456',
        'name': 'Another Box',
        'room': '客厅',
        'items': [],
        'createdAt': '2026-01-01T00:00:00.000Z',
        'updatedAt': '2026-01-01T00:00:00.000Z',
      };

      final box = Box.fromJson(json);
      
      expect(box.id, 'box_456');
      expect(box.name, 'Another Box');
      expect(box.room, '客厅');
    });
  });

  group('Item Model', () {
    test('should create an Item instance', () {
      final item = Item(
        id: 'item_123',
        boxId: 'box_123',
        name: '红色毛衣',
        quantity: 2,
        createdAt: DateTime(2026, 1, 1),
      );

      expect(item.id, 'item_123');
      expect(item.name, '红色毛衣');
      expect(item.quantity, 2);
    });

    test('should have default quantity of 1', () {
      final item = Item(
        id: 'item_456',
        boxId: 'box_456',
        name: '围巾',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(item.quantity, 1);
    });
  });
}

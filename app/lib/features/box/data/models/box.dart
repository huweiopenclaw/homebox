import 'package:freezed_annotation/freezed_annotation.dart';

part 'box.freezed.dart';
part 'box.g.dart';

@freezed
class Box with _$Box {
  const factory Box({
    required String id,
    required String name,
    String? category,
    String? room,
    String? furniture,
    String? position,
    String? locationDescription,
    String? itemPhotoUrl,
    String? locPhotoUrl,
    required List<Item> items,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Box;

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String boxId,
    required String name,
    @Default(1) int quantity,
    String? note,
    DateTime? expiryDate,
    double? confidence,
    @Default(false) bool userModified,
    required DateTime createdAt,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class BoxCreate with _$BoxCreate {
  const factory BoxCreate({
    required String name,
    String? category,
    String? itemPhoto,
    String? locPhoto,
    @Default(true) bool autoRecognize,
  }) = _BoxCreate;

  factory BoxCreate.fromJson(Map<String, dynamic> json) => _$BoxCreateFromJson(json);
}

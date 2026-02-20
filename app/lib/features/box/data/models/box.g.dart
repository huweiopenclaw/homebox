// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoxImpl _$$BoxImplFromJson(Map<String, dynamic> json) => _$BoxImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      room: json['room'] as String?,
      furniture: json['furniture'] as String?,
      position: json['position'] as String?,
      locationDescription: json['locationDescription'] as String?,
      itemPhotoUrl: json['itemPhotoUrl'] as String?,
      locPhotoUrl: json['locPhotoUrl'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BoxImplToJson(_$BoxImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'room': instance.room,
      'furniture': instance.furniture,
      'position': instance.position,
      'locationDescription': instance.locationDescription,
      'itemPhotoUrl': instance.itemPhotoUrl,
      'locPhotoUrl': instance.locPhotoUrl,
      'items': instance.items,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      id: json['id'] as String,
      boxId: json['boxId'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      note: json['note'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      confidence: (json['confidence'] as num?)?.toDouble(),
      userModified: json['userModified'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boxId': instance.boxId,
      'name': instance.name,
      'quantity': instance.quantity,
      'note': instance.note,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'confidence': instance.confidence,
      'userModified': instance.userModified,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$BoxCreateImpl _$$BoxCreateImplFromJson(Map<String, dynamic> json) =>
    _$BoxCreateImpl(
      name: json['name'] as String,
      category: json['category'] as String?,
      itemPhoto: json['itemPhoto'] as String?,
      locPhoto: json['locPhoto'] as String?,
      autoRecognize: json['autoRecognize'] as bool? ?? true,
    );

Map<String, dynamic> _$$BoxCreateImplToJson(_$BoxCreateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'itemPhoto': instance.itemPhoto,
      'locPhoto': instance.locPhoto,
      'autoRecognize': instance.autoRecognize,
    };

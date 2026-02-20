// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'box.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Box _$BoxFromJson(Map<String, dynamic> json) {
  return _Box.fromJson(json);
}

/// @nodoc
mixin _$Box {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get room => throw _privateConstructorUsedError;
  String? get furniture => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  String? get locationDescription => throw _privateConstructorUsedError;
  String? get itemPhotoUrl => throw _privateConstructorUsedError;
  String? get locPhotoUrl => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Box to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Box
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoxCopyWith<Box> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoxCopyWith<$Res> {
  factory $BoxCopyWith(Box value, $Res Function(Box) then) =
      _$BoxCopyWithImpl<$Res, Box>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? category,
      String? room,
      String? furniture,
      String? position,
      String? locationDescription,
      String? itemPhotoUrl,
      String? locPhotoUrl,
      List<Item> items,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$BoxCopyWithImpl<$Res, $Val extends Box> implements $BoxCopyWith<$Res> {
  _$BoxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Box
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? room = freezed,
    Object? furniture = freezed,
    Object? position = freezed,
    Object? locationDescription = freezed,
    Object? itemPhotoUrl = freezed,
    Object? locPhotoUrl = freezed,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      furniture: freezed == furniture
          ? _value.furniture
          : furniture // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      locationDescription: freezed == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      itemPhotoUrl: freezed == itemPhotoUrl
          ? _value.itemPhotoUrl
          : itemPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      locPhotoUrl: freezed == locPhotoUrl
          ? _value.locPhotoUrl
          : locPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoxImplCopyWith<$Res> implements $BoxCopyWith<$Res> {
  factory _$$BoxImplCopyWith(_$BoxImpl value, $Res Function(_$BoxImpl) then) =
      __$$BoxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? category,
      String? room,
      String? furniture,
      String? position,
      String? locationDescription,
      String? itemPhotoUrl,
      String? locPhotoUrl,
      List<Item> items,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$BoxImplCopyWithImpl<$Res> extends _$BoxCopyWithImpl<$Res, _$BoxImpl>
    implements _$$BoxImplCopyWith<$Res> {
  __$$BoxImplCopyWithImpl(_$BoxImpl _value, $Res Function(_$BoxImpl) _then)
      : super(_value, _then);

  /// Create a copy of Box
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? room = freezed,
    Object? furniture = freezed,
    Object? position = freezed,
    Object? locationDescription = freezed,
    Object? itemPhotoUrl = freezed,
    Object? locPhotoUrl = freezed,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BoxImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      furniture: freezed == furniture
          ? _value.furniture
          : furniture // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      locationDescription: freezed == locationDescription
          ? _value.locationDescription
          : locationDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      itemPhotoUrl: freezed == itemPhotoUrl
          ? _value.itemPhotoUrl
          : itemPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      locPhotoUrl: freezed == locPhotoUrl
          ? _value.locPhotoUrl
          : locPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoxImpl implements _Box {
  const _$BoxImpl(
      {required this.id,
      required this.name,
      this.category,
      this.room,
      this.furniture,
      this.position,
      this.locationDescription,
      this.itemPhotoUrl,
      this.locPhotoUrl,
      required final List<Item> items,
      required this.createdAt,
      required this.updatedAt})
      : _items = items;

  factory _$BoxImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoxImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? category;
  @override
  final String? room;
  @override
  final String? furniture;
  @override
  final String? position;
  @override
  final String? locationDescription;
  @override
  final String? itemPhotoUrl;
  @override
  final String? locPhotoUrl;
  final List<Item> _items;
  @override
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Box(id: $id, name: $name, category: $category, room: $room, furniture: $furniture, position: $position, locationDescription: $locationDescription, itemPhotoUrl: $itemPhotoUrl, locPhotoUrl: $locPhotoUrl, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.furniture, furniture) ||
                other.furniture == furniture) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.locationDescription, locationDescription) ||
                other.locationDescription == locationDescription) &&
            (identical(other.itemPhotoUrl, itemPhotoUrl) ||
                other.itemPhotoUrl == itemPhotoUrl) &&
            (identical(other.locPhotoUrl, locPhotoUrl) ||
                other.locPhotoUrl == locPhotoUrl) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      category,
      room,
      furniture,
      position,
      locationDescription,
      itemPhotoUrl,
      locPhotoUrl,
      const DeepCollectionEquality().hash(_items),
      createdAt,
      updatedAt);

  /// Create a copy of Box
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoxImplCopyWith<_$BoxImpl> get copyWith =>
      __$$BoxImplCopyWithImpl<_$BoxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoxImplToJson(
      this,
    );
  }
}

abstract class _Box implements Box {
  const factory _Box(
      {required final String id,
      required final String name,
      final String? category,
      final String? room,
      final String? furniture,
      final String? position,
      final String? locationDescription,
      final String? itemPhotoUrl,
      final String? locPhotoUrl,
      required final List<Item> items,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$BoxImpl;

  factory _Box.fromJson(Map<String, dynamic> json) = _$BoxImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get category;
  @override
  String? get room;
  @override
  String? get furniture;
  @override
  String? get position;
  @override
  String? get locationDescription;
  @override
  String? get itemPhotoUrl;
  @override
  String? get locPhotoUrl;
  @override
  List<Item> get items;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Box
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoxImplCopyWith<_$BoxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  String get boxId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  bool get userModified => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Item to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String id,
      String boxId,
      String name,
      int quantity,
      String? note,
      DateTime? expiryDate,
      double? confidence,
      bool userModified,
      DateTime createdAt});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? boxId = null,
    Object? name = null,
    Object? quantity = null,
    Object? note = freezed,
    Object? expiryDate = freezed,
    Object? confidence = freezed,
    Object? userModified = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      boxId: null == boxId
          ? _value.boxId
          : boxId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      userModified: null == userModified
          ? _value.userModified
          : userModified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String boxId,
      String name,
      int quantity,
      String? note,
      DateTime? expiryDate,
      double? confidence,
      bool userModified,
      DateTime createdAt});
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? boxId = null,
    Object? name = null,
    Object? quantity = null,
    Object? note = freezed,
    Object? expiryDate = freezed,
    Object? confidence = freezed,
    Object? userModified = null,
    Object? createdAt = null,
  }) {
    return _then(_$ItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      boxId: null == boxId
          ? _value.boxId
          : boxId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      userModified: null == userModified
          ? _value.userModified
          : userModified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl implements _Item {
  const _$ItemImpl(
      {required this.id,
      required this.boxId,
      required this.name,
      this.quantity = 1,
      this.note,
      this.expiryDate,
      this.confidence,
      this.userModified = false,
      required this.createdAt});

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  final String id;
  @override
  final String boxId;
  @override
  final String name;
  @override
  @JsonKey()
  final int quantity;
  @override
  final String? note;
  @override
  final DateTime? expiryDate;
  @override
  final double? confidence;
  @override
  @JsonKey()
  final bool userModified;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Item(id: $id, boxId: $boxId, name: $name, quantity: $quantity, note: $note, expiryDate: $expiryDate, confidence: $confidence, userModified: $userModified, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.boxId, boxId) || other.boxId == boxId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.userModified, userModified) ||
                other.userModified == userModified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, boxId, name, quantity, note,
      expiryDate, confidence, userModified, createdAt);

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {required final String id,
      required final String boxId,
      required final String name,
      final int quantity,
      final String? note,
      final DateTime? expiryDate,
      final double? confidence,
      final bool userModified,
      required final DateTime createdAt}) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  String get id;
  @override
  String get boxId;
  @override
  String get name;
  @override
  int get quantity;
  @override
  String? get note;
  @override
  DateTime? get expiryDate;
  @override
  double? get confidence;
  @override
  bool get userModified;
  @override
  DateTime get createdAt;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BoxCreate _$BoxCreateFromJson(Map<String, dynamic> json) {
  return _BoxCreate.fromJson(json);
}

/// @nodoc
mixin _$BoxCreate {
  String get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get itemPhoto => throw _privateConstructorUsedError;
  String? get locPhoto => throw _privateConstructorUsedError;
  bool get autoRecognize => throw _privateConstructorUsedError;

  /// Serializes this BoxCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoxCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoxCreateCopyWith<BoxCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoxCreateCopyWith<$Res> {
  factory $BoxCreateCopyWith(BoxCreate value, $Res Function(BoxCreate) then) =
      _$BoxCreateCopyWithImpl<$Res, BoxCreate>;
  @useResult
  $Res call(
      {String name,
      String? category,
      String? itemPhoto,
      String? locPhoto,
      bool autoRecognize});
}

/// @nodoc
class _$BoxCreateCopyWithImpl<$Res, $Val extends BoxCreate>
    implements $BoxCreateCopyWith<$Res> {
  _$BoxCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoxCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = freezed,
    Object? itemPhoto = freezed,
    Object? locPhoto = freezed,
    Object? autoRecognize = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      itemPhoto: freezed == itemPhoto
          ? _value.itemPhoto
          : itemPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      locPhoto: freezed == locPhoto
          ? _value.locPhoto
          : locPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRecognize: null == autoRecognize
          ? _value.autoRecognize
          : autoRecognize // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoxCreateImplCopyWith<$Res>
    implements $BoxCreateCopyWith<$Res> {
  factory _$$BoxCreateImplCopyWith(
          _$BoxCreateImpl value, $Res Function(_$BoxCreateImpl) then) =
      __$$BoxCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? category,
      String? itemPhoto,
      String? locPhoto,
      bool autoRecognize});
}

/// @nodoc
class __$$BoxCreateImplCopyWithImpl<$Res>
    extends _$BoxCreateCopyWithImpl<$Res, _$BoxCreateImpl>
    implements _$$BoxCreateImplCopyWith<$Res> {
  __$$BoxCreateImplCopyWithImpl(
      _$BoxCreateImpl _value, $Res Function(_$BoxCreateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoxCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = freezed,
    Object? itemPhoto = freezed,
    Object? locPhoto = freezed,
    Object? autoRecognize = null,
  }) {
    return _then(_$BoxCreateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      itemPhoto: freezed == itemPhoto
          ? _value.itemPhoto
          : itemPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      locPhoto: freezed == locPhoto
          ? _value.locPhoto
          : locPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRecognize: null == autoRecognize
          ? _value.autoRecognize
          : autoRecognize // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoxCreateImpl implements _BoxCreate {
  const _$BoxCreateImpl(
      {required this.name,
      this.category,
      this.itemPhoto,
      this.locPhoto,
      this.autoRecognize = true});

  factory _$BoxCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoxCreateImplFromJson(json);

  @override
  final String name;
  @override
  final String? category;
  @override
  final String? itemPhoto;
  @override
  final String? locPhoto;
  @override
  @JsonKey()
  final bool autoRecognize;

  @override
  String toString() {
    return 'BoxCreate(name: $name, category: $category, itemPhoto: $itemPhoto, locPhoto: $locPhoto, autoRecognize: $autoRecognize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoxCreateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.itemPhoto, itemPhoto) ||
                other.itemPhoto == itemPhoto) &&
            (identical(other.locPhoto, locPhoto) ||
                other.locPhoto == locPhoto) &&
            (identical(other.autoRecognize, autoRecognize) ||
                other.autoRecognize == autoRecognize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, category, itemPhoto, locPhoto, autoRecognize);

  /// Create a copy of BoxCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoxCreateImplCopyWith<_$BoxCreateImpl> get copyWith =>
      __$$BoxCreateImplCopyWithImpl<_$BoxCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoxCreateImplToJson(
      this,
    );
  }
}

abstract class _BoxCreate implements BoxCreate {
  const factory _BoxCreate(
      {required final String name,
      final String? category,
      final String? itemPhoto,
      final String? locPhoto,
      final bool autoRecognize}) = _$BoxCreateImpl;

  factory _BoxCreate.fromJson(Map<String, dynamic> json) =
      _$BoxCreateImpl.fromJson;

  @override
  String get name;
  @override
  String? get category;
  @override
  String? get itemPhoto;
  @override
  String? get locPhoto;
  @override
  bool get autoRecognize;

  /// Create a copy of BoxCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoxCreateImplCopyWith<_$BoxCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

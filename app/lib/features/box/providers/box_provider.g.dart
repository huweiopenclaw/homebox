// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchItemsHash() => r'2c4b94ed6fcf2bbb25f7a7737986504230f74266';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchItems].
@ProviderFor(searchItems)
const searchItemsProvider = SearchItemsFamily();

/// See also [searchItems].
class SearchItemsFamily extends Family<AsyncValue<List<Box>>> {
  /// See also [searchItems].
  const SearchItemsFamily();

  /// See also [searchItems].
  SearchItemsProvider call(
    String query,
  ) {
    return SearchItemsProvider(
      query,
    );
  }

  @override
  SearchItemsProvider getProviderOverride(
    covariant SearchItemsProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchItemsProvider';
}

/// See also [searchItems].
class SearchItemsProvider extends AutoDisposeFutureProvider<List<Box>> {
  /// See also [searchItems].
  SearchItemsProvider(
    String query,
  ) : this._internal(
          (ref) => searchItems(
            ref as SearchItemsRef,
            query,
          ),
          from: searchItemsProvider,
          name: r'searchItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchItemsHash,
          dependencies: SearchItemsFamily._dependencies,
          allTransitiveDependencies:
              SearchItemsFamily._allTransitiveDependencies,
          query: query,
        );

  SearchItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Box>> Function(SearchItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchItemsProvider._internal(
        (ref) => create(ref as SearchItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Box>> createElement() {
    return _SearchItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchItemsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchItemsRef on AutoDisposeFutureProviderRef<List<Box>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<Box>> with SearchItemsRef {
  _SearchItemsProviderElement(super.provider);

  @override
  String get query => (origin as SearchItemsProvider).query;
}

String _$boxListHash() => r'2258c3a47d5d2eb03007d0e686042c4aaafd3a20';

/// See also [BoxList].
@ProviderFor(BoxList)
final boxListProvider =
    AutoDisposeAsyncNotifierProvider<BoxList, List<Box>>.internal(
  BoxList.new,
  name: r'boxListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$boxListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BoxList = AutoDisposeAsyncNotifier<List<Box>>;
String _$boxDetailHash() => r'c2f03abb247b35ea837a2e0ebe78c17a154316fc';

abstract class _$BoxDetail extends BuildlessAutoDisposeAsyncNotifier<Box?> {
  late final String boxId;

  FutureOr<Box?> build(
    String boxId,
  );
}

/// See also [BoxDetail].
@ProviderFor(BoxDetail)
const boxDetailProvider = BoxDetailFamily();

/// See also [BoxDetail].
class BoxDetailFamily extends Family<AsyncValue<Box?>> {
  /// See also [BoxDetail].
  const BoxDetailFamily();

  /// See also [BoxDetail].
  BoxDetailProvider call(
    String boxId,
  ) {
    return BoxDetailProvider(
      boxId,
    );
  }

  @override
  BoxDetailProvider getProviderOverride(
    covariant BoxDetailProvider provider,
  ) {
    return call(
      provider.boxId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'boxDetailProvider';
}

/// See also [BoxDetail].
class BoxDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BoxDetail, Box?> {
  /// See also [BoxDetail].
  BoxDetailProvider(
    String boxId,
  ) : this._internal(
          () => BoxDetail()..boxId = boxId,
          from: boxDetailProvider,
          name: r'boxDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boxDetailHash,
          dependencies: BoxDetailFamily._dependencies,
          allTransitiveDependencies: BoxDetailFamily._allTransitiveDependencies,
          boxId: boxId,
        );

  BoxDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.boxId,
  }) : super.internal();

  final String boxId;

  @override
  FutureOr<Box?> runNotifierBuild(
    covariant BoxDetail notifier,
  ) {
    return notifier.build(
      boxId,
    );
  }

  @override
  Override overrideWith(BoxDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: BoxDetailProvider._internal(
        () => create()..boxId = boxId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        boxId: boxId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BoxDetail, Box?> createElement() {
    return _BoxDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoxDetailProvider && other.boxId == boxId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boxId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BoxDetailRef on AutoDisposeAsyncNotifierProviderRef<Box?> {
  /// The parameter `boxId` of this provider.
  String get boxId;
}

class _BoxDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BoxDetail, Box?>
    with BoxDetailRef {
  _BoxDetailProviderElement(super.provider);

  @override
  String get boxId => (origin as BoxDetailProvider).boxId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

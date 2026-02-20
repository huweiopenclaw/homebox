// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$askAssistantHash() => r'8e69c211586a8cb4bd73c0f44d36c36dea996121';

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

/// See also [askAssistant].
@ProviderFor(askAssistant)
const askAssistantProvider = AskAssistantFamily();

/// See also [askAssistant].
class AskAssistantFamily extends Family<AsyncValue<ChatMessage>> {
  /// See also [askAssistant].
  const AskAssistantFamily();

  /// See also [askAssistant].
  AskAssistantProvider call({
    required String question,
    String? sessionId,
  }) {
    return AskAssistantProvider(
      question: question,
      sessionId: sessionId,
    );
  }

  @override
  AskAssistantProvider getProviderOverride(
    covariant AskAssistantProvider provider,
  ) {
    return call(
      question: provider.question,
      sessionId: provider.sessionId,
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
  String? get name => r'askAssistantProvider';
}

/// See also [askAssistant].
class AskAssistantProvider extends AutoDisposeFutureProvider<ChatMessage> {
  /// See also [askAssistant].
  AskAssistantProvider({
    required String question,
    String? sessionId,
  }) : this._internal(
          (ref) => askAssistant(
            ref as AskAssistantRef,
            question: question,
            sessionId: sessionId,
          ),
          from: askAssistantProvider,
          name: r'askAssistantProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$askAssistantHash,
          dependencies: AskAssistantFamily._dependencies,
          allTransitiveDependencies:
              AskAssistantFamily._allTransitiveDependencies,
          question: question,
          sessionId: sessionId,
        );

  AskAssistantProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.question,
    required this.sessionId,
  }) : super.internal();

  final String question;
  final String? sessionId;

  @override
  Override overrideWith(
    FutureOr<ChatMessage> Function(AskAssistantRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AskAssistantProvider._internal(
        (ref) => create(ref as AskAssistantRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        question: question,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChatMessage> createElement() {
    return _AskAssistantProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AskAssistantProvider &&
        other.question == question &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, question.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AskAssistantRef on AutoDisposeFutureProviderRef<ChatMessage> {
  /// The parameter `question` of this provider.
  String get question;

  /// The parameter `sessionId` of this provider.
  String? get sessionId;
}

class _AskAssistantProviderElement
    extends AutoDisposeFutureProviderElement<ChatMessage> with AskAssistantRef {
  _AskAssistantProviderElement(super.provider);

  @override
  String get question => (origin as AskAssistantProvider).question;
  @override
  String? get sessionId => (origin as AskAssistantProvider).sessionId;
}

String _$chatHistoryHash() => r'c411f13b63992e05dd1d7baba71ef3e07745f4f6';

/// See also [ChatHistory].
@ProviderFor(ChatHistory)
final chatHistoryProvider =
    AutoDisposeAsyncNotifierProvider<ChatHistory, List<ChatSession>>.internal(
  ChatHistory.new,
  name: r'chatHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatHistory = AutoDisposeAsyncNotifier<List<ChatSession>>;
String _$activeChatSessionHash() => r'258a435e0deef573b98e1d90955ecddec6b9d262';

abstract class _$ActiveChatSession
    extends BuildlessAutoDisposeAsyncNotifier<ChatSession?> {
  late final String? sessionId;

  FutureOr<ChatSession?> build(
    String? sessionId,
  );
}

/// See also [ActiveChatSession].
@ProviderFor(ActiveChatSession)
const activeChatSessionProvider = ActiveChatSessionFamily();

/// See also [ActiveChatSession].
class ActiveChatSessionFamily extends Family<AsyncValue<ChatSession?>> {
  /// See also [ActiveChatSession].
  const ActiveChatSessionFamily();

  /// See also [ActiveChatSession].
  ActiveChatSessionProvider call(
    String? sessionId,
  ) {
    return ActiveChatSessionProvider(
      sessionId,
    );
  }

  @override
  ActiveChatSessionProvider getProviderOverride(
    covariant ActiveChatSessionProvider provider,
  ) {
    return call(
      provider.sessionId,
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
  String? get name => r'activeChatSessionProvider';
}

/// See also [ActiveChatSession].
class ActiveChatSessionProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ActiveChatSession, ChatSession?> {
  /// See also [ActiveChatSession].
  ActiveChatSessionProvider(
    String? sessionId,
  ) : this._internal(
          () => ActiveChatSession()..sessionId = sessionId,
          from: activeChatSessionProvider,
          name: r'activeChatSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activeChatSessionHash,
          dependencies: ActiveChatSessionFamily._dependencies,
          allTransitiveDependencies:
              ActiveChatSessionFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  ActiveChatSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String? sessionId;

  @override
  FutureOr<ChatSession?> runNotifierBuild(
    covariant ActiveChatSession notifier,
  ) {
    return notifier.build(
      sessionId,
    );
  }

  @override
  Override overrideWith(ActiveChatSession Function() create) {
    return ProviderOverride(
      origin: this,
      override: ActiveChatSessionProvider._internal(
        () => create()..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ActiveChatSession, ChatSession?>
      createElement() {
    return _ActiveChatSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveChatSessionProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActiveChatSessionRef
    on AutoDisposeAsyncNotifierProviderRef<ChatSession?> {
  /// The parameter `sessionId` of this provider.
  String? get sessionId;
}

class _ActiveChatSessionProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ActiveChatSession,
        ChatSession?> with ActiveChatSessionRef {
  _ActiveChatSessionProviderElement(super.provider);

  @override
  String? get sessionId => (origin as ActiveChatSessionProvider).sessionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

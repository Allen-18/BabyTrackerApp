// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kids.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getStreamKidsForCurrentParentHash() =>
    r'ab38f3da321d20b162f8d693c0e3501d31399009';

/// See also [getStreamKidsForCurrentParent].
@ProviderFor(getStreamKidsForCurrentParent)
final getStreamKidsForCurrentParentProvider =
    AutoDisposeStreamProvider<List<Kid>>.internal(
  getStreamKidsForCurrentParent,
  name: r'getStreamKidsForCurrentParentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStreamKidsForCurrentParentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetStreamKidsForCurrentParentRef
    = AutoDisposeStreamProviderRef<List<Kid>>;
String _$getKidsForCurrentParentHash() =>
    r'2ec71669548d3b03f6fed7fbae45ebe35afe7682';

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

/// See also [getKidsForCurrentParent].
@ProviderFor(getKidsForCurrentParent)
const getKidsForCurrentParentProvider = GetKidsForCurrentParentFamily();

/// See also [getKidsForCurrentParent].
class GetKidsForCurrentParentFamily extends Family<AsyncValue<List<Kid>>> {
  /// See also [getKidsForCurrentParent].
  const GetKidsForCurrentParentFamily();

  /// See also [getKidsForCurrentParent].
  GetKidsForCurrentParentProvider call({
    required List<Kid> kids,
  }) {
    return GetKidsForCurrentParentProvider(
      kids: kids,
    );
  }

  @override
  GetKidsForCurrentParentProvider getProviderOverride(
    covariant GetKidsForCurrentParentProvider provider,
  ) {
    return call(
      kids: provider.kids,
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
  String? get name => r'getKidsForCurrentParentProvider';
}

/// See also [getKidsForCurrentParent].
class GetKidsForCurrentParentProvider
    extends AutoDisposeFutureProvider<List<Kid>> {
  /// See also [getKidsForCurrentParent].
  GetKidsForCurrentParentProvider({
    required List<Kid> kids,
  }) : this._internal(
          (ref) => getKidsForCurrentParent(
            ref as GetKidsForCurrentParentRef,
            kids: kids,
          ),
          from: getKidsForCurrentParentProvider,
          name: r'getKidsForCurrentParentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getKidsForCurrentParentHash,
          dependencies: GetKidsForCurrentParentFamily._dependencies,
          allTransitiveDependencies:
              GetKidsForCurrentParentFamily._allTransitiveDependencies,
          kids: kids,
        );

  GetKidsForCurrentParentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.kids,
  }) : super.internal();

  final List<Kid> kids;

  @override
  Override overrideWith(
    FutureOr<List<Kid>> Function(GetKidsForCurrentParentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetKidsForCurrentParentProvider._internal(
        (ref) => create(ref as GetKidsForCurrentParentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        kids: kids,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Kid>> createElement() {
    return _GetKidsForCurrentParentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetKidsForCurrentParentProvider && other.kids == kids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, kids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetKidsForCurrentParentRef on AutoDisposeFutureProviderRef<List<Kid>> {
  /// The parameter `kids` of this provider.
  List<Kid> get kids;
}

class _GetKidsForCurrentParentProviderElement
    extends AutoDisposeFutureProviderElement<List<Kid>>
    with GetKidsForCurrentParentRef {
  _GetKidsForCurrentParentProviderElement(super.provider);

  @override
  List<Kid> get kids => (origin as GetKidsForCurrentParentProvider).kids;
}

String _$getKidForCurrentParentHash() =>
    r'2448e8ab989423a0db9241c82bf6a8fc2a316921';

/// See also [getKidForCurrentParent].
@ProviderFor(getKidForCurrentParent)
final getKidForCurrentParentProvider =
    AutoDisposeFutureProvider<List<Kid>>.internal(
  getKidForCurrentParent,
  name: r'getKidForCurrentParentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getKidForCurrentParentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetKidForCurrentParentRef = AutoDisposeFutureProviderRef<List<Kid>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

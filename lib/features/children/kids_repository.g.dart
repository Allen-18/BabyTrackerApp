// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kids_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$kidsRepositoryHash() => r'45961bc09d69a66eb04892f755625724edf024d8';

/// See also [kidsRepository].
@ProviderFor(kidsRepository)
final kidsRepositoryProvider = AutoDisposeProvider<KidsRepository>.internal(
  kidsRepository,
  name: r'kidsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$kidsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KidsRepositoryRef = AutoDisposeProviderRef<KidsRepository>;
String _$getKidHash() => r'41de7bc5f771abfedd50ce63a838c2f786f1c3f0';

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

/// See also [getKid].
@ProviderFor(getKid)
const getKidProvider = GetKidFamily();

/// See also [getKid].
class GetKidFamily extends Family<AsyncValue<Kid?>> {
  /// See also [getKid].
  const GetKidFamily();

  /// See also [getKid].
  GetKidProvider call({
    required String? id,
  }) {
    return GetKidProvider(
      id: id,
    );
  }

  @override
  GetKidProvider getProviderOverride(
    covariant GetKidProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'getKidProvider';
}

/// See also [getKid].
class GetKidProvider extends AutoDisposeFutureProvider<Kid?> {
  /// See also [getKid].
  GetKidProvider({
    required String? id,
  }) : this._internal(
          (ref) => getKid(
            ref as GetKidRef,
            id: id,
          ),
          from: getKidProvider,
          name: r'getKidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getKidHash,
          dependencies: GetKidFamily._dependencies,
          allTransitiveDependencies: GetKidFamily._allTransitiveDependencies,
          id: id,
        );

  GetKidProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    FutureOr<Kid?> Function(GetKidRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetKidProvider._internal(
        (ref) => create(ref as GetKidRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Kid?> createElement() {
    return _GetKidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetKidProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetKidRef on AutoDisposeFutureProviderRef<Kid?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetKidProviderElement extends AutoDisposeFutureProviderElement<Kid?>
    with GetKidRef {
  _GetKidProviderElement(super.provider);

  @override
  String? get id => (origin as GetKidProvider).id;
}

String _$getKidStreamHash() => r'0cba9229d8e7d9477468f7d8bcbe8f1be415cc5d';

/// See also [getKidStream].
@ProviderFor(getKidStream)
const getKidStreamProvider = GetKidStreamFamily();

/// See also [getKidStream].
class GetKidStreamFamily extends Family<AsyncValue<Kid?>> {
  /// See also [getKidStream].
  const GetKidStreamFamily();

  /// See also [getKidStream].
  GetKidStreamProvider call({
    required String kidId,
  }) {
    return GetKidStreamProvider(
      kidId: kidId,
    );
  }

  @override
  GetKidStreamProvider getProviderOverride(
    covariant GetKidStreamProvider provider,
  ) {
    return call(
      kidId: provider.kidId,
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
  String? get name => r'getKidStreamProvider';
}

/// See also [getKidStream].
class GetKidStreamProvider extends AutoDisposeStreamProvider<Kid?> {
  /// See also [getKidStream].
  GetKidStreamProvider({
    required String kidId,
  }) : this._internal(
          (ref) => getKidStream(
            ref as GetKidStreamRef,
            kidId: kidId,
          ),
          from: getKidStreamProvider,
          name: r'getKidStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getKidStreamHash,
          dependencies: GetKidStreamFamily._dependencies,
          allTransitiveDependencies:
              GetKidStreamFamily._allTransitiveDependencies,
          kidId: kidId,
        );

  GetKidStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.kidId,
  }) : super.internal();

  final String kidId;

  @override
  Override overrideWith(
    Stream<Kid?> Function(GetKidStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetKidStreamProvider._internal(
        (ref) => create(ref as GetKidStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        kidId: kidId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Kid?> createElement() {
    return _GetKidStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetKidStreamProvider && other.kidId == kidId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, kidId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetKidStreamRef on AutoDisposeStreamProviderRef<Kid?> {
  /// The parameter `kidId` of this provider.
  String get kidId;
}

class _GetKidStreamProviderElement
    extends AutoDisposeStreamProviderElement<Kid?> with GetKidStreamRef {
  _GetKidStreamProviderElement(super.provider);

  @override
  String get kidId => (origin as GetKidStreamProvider).kidId;
}

String _$getKidFutureHash() => r'da7a5c3ccffc704320354bd8bd1ea696c55b2600';

/// See also [getKidFuture].
@ProviderFor(getKidFuture)
const getKidFutureProvider = GetKidFutureFamily();

/// See also [getKidFuture].
class GetKidFutureFamily extends Family<AsyncValue<Kid?>> {
  /// See also [getKidFuture].
  const GetKidFutureFamily();

  /// See also [getKidFuture].
  GetKidFutureProvider call({
    required String kidId,
  }) {
    return GetKidFutureProvider(
      kidId: kidId,
    );
  }

  @override
  GetKidFutureProvider getProviderOverride(
    covariant GetKidFutureProvider provider,
  ) {
    return call(
      kidId: provider.kidId,
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
  String? get name => r'getKidFutureProvider';
}

/// See also [getKidFuture].
class GetKidFutureProvider extends AutoDisposeFutureProvider<Kid?> {
  /// See also [getKidFuture].
  GetKidFutureProvider({
    required String kidId,
  }) : this._internal(
          (ref) => getKidFuture(
            ref as GetKidFutureRef,
            kidId: kidId,
          ),
          from: getKidFutureProvider,
          name: r'getKidFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getKidFutureHash,
          dependencies: GetKidFutureFamily._dependencies,
          allTransitiveDependencies:
              GetKidFutureFamily._allTransitiveDependencies,
          kidId: kidId,
        );

  GetKidFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.kidId,
  }) : super.internal();

  final String kidId;

  @override
  Override overrideWith(
    FutureOr<Kid?> Function(GetKidFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetKidFutureProvider._internal(
        (ref) => create(ref as GetKidFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        kidId: kidId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Kid?> createElement() {
    return _GetKidFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetKidFutureProvider && other.kidId == kidId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, kidId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetKidFutureRef on AutoDisposeFutureProviderRef<Kid?> {
  /// The parameter `kidId` of this provider.
  String get kidId;
}

class _GetKidFutureProviderElement
    extends AutoDisposeFutureProviderElement<Kid?> with GetKidFutureRef {
  _GetKidFutureProviderElement(super.provider);

  @override
  String get kidId => (origin as GetKidFutureProvider).kidId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

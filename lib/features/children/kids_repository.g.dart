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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

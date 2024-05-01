// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersRepositoryHash() => r'93800a2298b7e9c2578b767216c2f06bc1dc49bb';

/// See also [usersRepository].
@ProviderFor(usersRepository)
final usersRepositoryProvider = AutoDisposeProvider<UsersRepository>.internal(
  usersRepository,
  name: r'usersRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersRepositoryRef = AutoDisposeProviderRef<UsersRepository>;
String _$getUserHash() => r'60bc80498bc3f20f6c293aef80a6b27a87e58198';

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

/// See also [getUser].
@ProviderFor(getUser)
const getUserProvider = GetUserFamily();

/// See also [getUser].
class GetUserFamily extends Family<AsyncValue<User?>> {
  /// See also [getUser].
  const GetUserFamily();

  /// See also [getUser].
  GetUserProvider call({
    required String? id,
  }) {
    return GetUserProvider(
      id: id,
    );
  }

  @override
  GetUserProvider getProviderOverride(
    covariant GetUserProvider provider,
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
  String? get name => r'getUserProvider';
}

/// See also [getUser].
class GetUserProvider extends AutoDisposeFutureProvider<User?> {
  /// See also [getUser].
  GetUserProvider({
    required String? id,
  }) : this._internal(
          (ref) => getUser(
            ref as GetUserRef,
            id: id,
          ),
          from: getUserProvider,
          name: r'getUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserHash,
          dependencies: GetUserFamily._dependencies,
          allTransitiveDependencies: GetUserFamily._allTransitiveDependencies,
          id: id,
        );

  GetUserProvider._internal(
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
    FutureOr<User?> Function(GetUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserProvider._internal(
        (ref) => create(ref as GetUserRef),
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
  AutoDisposeFutureProviderElement<User?> createElement() {
    return _GetUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserRef on AutoDisposeFutureProviderRef<User?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetUserProviderElement extends AutoDisposeFutureProviderElement<User?>
    with GetUserRef {
  _GetUserProviderElement(super.provider);

  @override
  String? get id => (origin as GetUserProvider).id;
}

String _$getCurrentUserHash() => r'a364a5ba9a2d2138bd0844104356dc526d8c18a8';

/// See also [getCurrentUser].
@ProviderFor(getCurrentUser)
final getCurrentUserProvider = AutoDisposeFutureProvider<User?>.internal(
  getCurrentUser,
  name: r'getCurrentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCurrentUserRef = AutoDisposeFutureProviderRef<User?>;
String _$getCurrentUserStreamHash() =>
    r'87fe8b2ce124b7ad18dcff449ef59fb7024d999d';

/// See also [getCurrentUserStream].
@ProviderFor(getCurrentUserStream)
final getCurrentUserStreamProvider = StreamProvider<User?>.internal(
  getCurrentUserStream,
  name: r'getCurrentUserStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentUserStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCurrentUserStreamRef = StreamProviderRef<User?>;
String _$getUserStreamHash() => r'4fcbb884a94eaa0c0223927a7f9fa41b01d4113c';

/// See also [getUserStream].
@ProviderFor(getUserStream)
const getUserStreamProvider = GetUserStreamFamily();

/// See also [getUserStream].
class GetUserStreamFamily extends Family<AsyncValue<User?>> {
  /// See also [getUserStream].
  const GetUserStreamFamily();

  /// See also [getUserStream].
  GetUserStreamProvider call({
    String? uid,
  }) {
    return GetUserStreamProvider(
      uid: uid,
    );
  }

  @override
  GetUserStreamProvider getProviderOverride(
    covariant GetUserStreamProvider provider,
  ) {
    return call(
      uid: provider.uid,
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
  String? get name => r'getUserStreamProvider';
}

/// See also [getUserStream].
class GetUserStreamProvider extends AutoDisposeStreamProvider<User?> {
  /// See also [getUserStream].
  GetUserStreamProvider({
    String? uid,
  }) : this._internal(
          (ref) => getUserStream(
            ref as GetUserStreamRef,
            uid: uid,
          ),
          from: getUserStreamProvider,
          name: r'getUserStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserStreamHash,
          dependencies: GetUserStreamFamily._dependencies,
          allTransitiveDependencies:
              GetUserStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  GetUserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String? uid;

  @override
  Override overrideWith(
    Stream<User?> Function(GetUserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserStreamProvider._internal(
        (ref) => create(ref as GetUserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<User?> createElement() {
    return _GetUserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserStreamRef on AutoDisposeStreamProviderRef<User?> {
  /// The parameter `uid` of this provider.
  String? get uid;
}

class _GetUserStreamProviderElement
    extends AutoDisposeStreamProviderElement<User?> with GetUserStreamRef {
  _GetUserStreamProviderElement(super.provider);

  @override
  String? get uid => (origin as GetUserStreamProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

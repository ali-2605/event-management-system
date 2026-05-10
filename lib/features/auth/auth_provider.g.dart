
part of 'auth_provider.dart';



@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $AsyncNotifierProvider<Auth, AuthResponse?> {
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'7f4029c34a286413826fbbf4ceb7e6d39214044c';

abstract class _$Auth extends $AsyncNotifier<AuthResponse?> {
  FutureOr<AuthResponse?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthResponse?>, AuthResponse?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthResponse?>, AuthResponse?>,
              AsyncValue<AuthResponse?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

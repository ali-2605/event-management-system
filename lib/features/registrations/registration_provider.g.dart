// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Registrations)
final registrationsProvider = RegistrationsProvider._();

final class RegistrationsProvider
    extends $AsyncNotifierProvider<Registrations, List<RegistrationResponse>> {
  RegistrationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registrationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registrationsHash();

  @$internal
  @override
  Registrations create() => Registrations();
}

String _$registrationsHash() => r'd728a33651ac7389c84d65fb1d3360a8037dd448';

abstract class _$Registrations
    extends $AsyncNotifier<List<RegistrationResponse>> {
  FutureOr<List<RegistrationResponse>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<RegistrationResponse>>,
              List<RegistrationResponse>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<RegistrationResponse>>,
                List<RegistrationResponse>
              >,
              AsyncValue<List<RegistrationResponse>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

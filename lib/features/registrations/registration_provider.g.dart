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

String _$registrationsHash() => r'f3c7b6e2d997b4f6594f4f226eb8bcebb10d1032';

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

@ProviderFor(eventRegistrations)
final eventRegistrationsProvider = EventRegistrationsFamily._();

final class EventRegistrationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RegistrationResponse>>,
          List<RegistrationResponse>,
          FutureOr<List<RegistrationResponse>>
        >
    with
        $FutureModifier<List<RegistrationResponse>>,
        $FutureProvider<List<RegistrationResponse>> {
  EventRegistrationsProvider._({
    required EventRegistrationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventRegistrationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventRegistrationsHash();

  @override
  String toString() {
    return r'eventRegistrationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RegistrationResponse>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RegistrationResponse>> create(Ref ref) {
    final argument = this.argument as String;
    return eventRegistrations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventRegistrationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventRegistrationsHash() =>
    r'08571fae1f1da238b59691c17a43dd5534954833';

final class EventRegistrationsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<RegistrationResponse>>,
          String
        > {
  EventRegistrationsFamily._()
    : super(
        retry: null,
        name: r'eventRegistrationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventRegistrationsProvider call(String eventId) =>
      EventRegistrationsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventRegistrationsProvider';
}

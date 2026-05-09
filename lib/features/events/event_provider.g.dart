// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Events)
final eventsProvider = EventsProvider._();

final class EventsProvider
    extends $AsyncNotifierProvider<Events, List<EventResponse>> {
  EventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsHash();

  @$internal
  @override
  Events create() => Events();
}

String _$eventsHash() => r'9565327227453cbbc65824a20d8f53f17c966756';

abstract class _$Events extends $AsyncNotifier<List<EventResponse>> {
  FutureOr<List<EventResponse>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<EventResponse>>, List<EventResponse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EventResponse>>, List<EventResponse>>,
              AsyncValue<List<EventResponse>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(eventDetails)
final eventDetailsProvider = EventDetailsFamily._();

final class EventDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventResponse>,
          EventResponse,
          FutureOr<EventResponse>
        >
    with $FutureModifier<EventResponse>, $FutureProvider<EventResponse> {
  EventDetailsProvider._({
    required EventDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailsHash();

  @override
  String toString() {
    return r'eventDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventResponse> create(Ref ref) {
    final argument = this.argument as String;
    return eventDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailsHash() => r'ae05702adb839be32f5250961866bf28343848ef';

final class EventDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventResponse>, String> {
  EventDetailsFamily._()
    : super(
        retry: null,
        name: r'eventDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventDetailsProvider call(String eventId) =>
      EventDetailsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailsProvider';
}

@ProviderFor(MyEvents)
final myEventsProvider = MyEventsProvider._();

final class MyEventsProvider
    extends $AsyncNotifierProvider<MyEvents, List<EventResponse>> {
  MyEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myEventsHash();

  @$internal
  @override
  MyEvents create() => MyEvents();
}

String _$myEventsHash() => r'9a19f453c6a5fa0b7ae0edd53a72232ac7828e6d';

abstract class _$MyEvents extends $AsyncNotifier<List<EventResponse>> {
  FutureOr<List<EventResponse>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<EventResponse>>, List<EventResponse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EventResponse>>, List<EventResponse>>,
              AsyncValue<List<EventResponse>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

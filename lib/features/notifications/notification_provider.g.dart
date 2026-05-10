
part of 'notification_provider.dart';



@ProviderFor(Notifications)
final notificationsProvider = NotificationsProvider._();

final class NotificationsProvider
    extends $AsyncNotifierProvider<Notifications, List<NotificationResponse>> {
  NotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @$internal
  @override
  Notifications create() => Notifications();
}

String _$notificationsHash() => r'4e6aa5045af915da79569375cfddc8051448ba31';

abstract class _$Notifications
    extends $AsyncNotifier<List<NotificationResponse>> {
  FutureOr<List<NotificationResponse>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<NotificationResponse>>,
              List<NotificationResponse>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NotificationResponse>>,
                List<NotificationResponse>
              >,
              AsyncValue<List<NotificationResponse>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(unreadNotificationsCount)
final unreadNotificationsCountProvider = UnreadNotificationsCountProvider._();

final class UnreadNotificationsCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  UnreadNotificationsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationsCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return unreadNotificationsCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadNotificationsCountHash() =>
    r'e4c826495dbe063af79853127d0db45622670b5d';

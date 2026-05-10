
part of 'registration_models.dart';


// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegistrationResponse {

 String get registrationId; String get eventId; String get attendeeId; RegistrationStatus get status; DateTime get registeredAt; DateTime? get canceledAt;
/// Create a copy of RegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationResponseCopyWith<RegistrationResponse> get copyWith => _$RegistrationResponseCopyWithImpl<RegistrationResponse>(this as RegistrationResponse, _$identity);

  /// Serializes this RegistrationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationResponse&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.attendeeId, attendeeId) || other.attendeeId == attendeeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,eventId,attendeeId,status,registeredAt,canceledAt);

@override
String toString() {
  return 'RegistrationResponse(registrationId: $registrationId, eventId: $eventId, attendeeId: $attendeeId, status: $status, registeredAt: $registeredAt, canceledAt: $canceledAt)';
}


}

/// @nodoc
abstract mixin class $RegistrationResponseCopyWith<$Res>  {
  factory $RegistrationResponseCopyWith(RegistrationResponse value, $Res Function(RegistrationResponse) _then) = _$RegistrationResponseCopyWithImpl;
@useResult
$Res call({
 String registrationId, String eventId, String attendeeId, RegistrationStatus status, DateTime registeredAt, DateTime? canceledAt
});




}
/// @nodoc
class _$RegistrationResponseCopyWithImpl<$Res>
    implements $RegistrationResponseCopyWith<$Res> {
  _$RegistrationResponseCopyWithImpl(this._self, this._then);

  final RegistrationResponse _self;
  final $Res Function(RegistrationResponse) _then;

/// Create a copy of RegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationId = null,Object? eventId = null,Object? attendeeId = null,Object? status = null,Object? registeredAt = null,Object? canceledAt = freezed,}) {
  return _then(_self.copyWith(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,attendeeId: null == attendeeId ? _self.attendeeId : attendeeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RegistrationStatus,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationResponse].
extension RegistrationResponsePatterns on RegistrationResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationResponse value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String registrationId,  String eventId,  String attendeeId,  RegistrationStatus status,  DateTime registeredAt,  DateTime? canceledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationResponse() when $default != null:
return $default(_that.registrationId,_that.eventId,_that.attendeeId,_that.status,_that.registeredAt,_that.canceledAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String registrationId,  String eventId,  String attendeeId,  RegistrationStatus status,  DateTime registeredAt,  DateTime? canceledAt)  $default,) {final _that = this;
switch (_that) {
case _RegistrationResponse():
return $default(_that.registrationId,_that.eventId,_that.attendeeId,_that.status,_that.registeredAt,_that.canceledAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String registrationId,  String eventId,  String attendeeId,  RegistrationStatus status,  DateTime registeredAt,  DateTime? canceledAt)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationResponse() when $default != null:
return $default(_that.registrationId,_that.eventId,_that.attendeeId,_that.status,_that.registeredAt,_that.canceledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegistrationResponse implements RegistrationResponse {
  const _RegistrationResponse({required this.registrationId, required this.eventId, required this.attendeeId, required this.status, required this.registeredAt, this.canceledAt});
  factory _RegistrationResponse.fromJson(Map<String, dynamic> json) => _$RegistrationResponseFromJson(json);

@override final  String registrationId;
@override final  String eventId;
@override final  String attendeeId;
@override final  RegistrationStatus status;
@override final  DateTime registeredAt;
@override final  DateTime? canceledAt;

/// Create a copy of RegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationResponseCopyWith<_RegistrationResponse> get copyWith => __$RegistrationResponseCopyWithImpl<_RegistrationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationResponse&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.attendeeId, attendeeId) || other.attendeeId == attendeeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,eventId,attendeeId,status,registeredAt,canceledAt);

@override
String toString() {
  return 'RegistrationResponse(registrationId: $registrationId, eventId: $eventId, attendeeId: $attendeeId, status: $status, registeredAt: $registeredAt, canceledAt: $canceledAt)';
}


}

/// @nodoc
abstract mixin class _$RegistrationResponseCopyWith<$Res> implements $RegistrationResponseCopyWith<$Res> {
  factory _$RegistrationResponseCopyWith(_RegistrationResponse value, $Res Function(_RegistrationResponse) _then) = __$RegistrationResponseCopyWithImpl;
@override @useResult
$Res call({
 String registrationId, String eventId, String attendeeId, RegistrationStatus status, DateTime registeredAt, DateTime? canceledAt
});




}
/// @nodoc
class __$RegistrationResponseCopyWithImpl<$Res>
    implements _$RegistrationResponseCopyWith<$Res> {
  __$RegistrationResponseCopyWithImpl(this._self, this._then);

  final _RegistrationResponse _self;
  final $Res Function(_RegistrationResponse) _then;

/// Create a copy of RegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationId = null,Object? eventId = null,Object? attendeeId = null,Object? status = null,Object? registeredAt = null,Object? canceledAt = freezed,}) {
  return _then(_RegistrationResponse(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,attendeeId: null == attendeeId ? _self.attendeeId : attendeeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RegistrationStatus,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateRegistrationRequest {

 String get eventId;
/// Create a copy of CreateRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateRegistrationRequestCopyWith<CreateRegistrationRequest> get copyWith => _$CreateRegistrationRequestCopyWithImpl<CreateRegistrationRequest>(this as CreateRegistrationRequest, _$identity);

  /// Serializes this CreateRegistrationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateRegistrationRequest&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'CreateRegistrationRequest(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $CreateRegistrationRequestCopyWith<$Res>  {
  factory $CreateRegistrationRequestCopyWith(CreateRegistrationRequest value, $Res Function(CreateRegistrationRequest) _then) = _$CreateRegistrationRequestCopyWithImpl;
@useResult
$Res call({
 String eventId
});




}
/// @nodoc
class _$CreateRegistrationRequestCopyWithImpl<$Res>
    implements $CreateRegistrationRequestCopyWith<$Res> {
  _$CreateRegistrationRequestCopyWithImpl(this._self, this._then);

  final CreateRegistrationRequest _self;
  final $Res Function(CreateRegistrationRequest) _then;

/// Create a copy of CreateRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateRegistrationRequest].
extension CreateRegistrationRequestPatterns on CreateRegistrationRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateRegistrationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateRegistrationRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateRegistrationRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateRegistrationRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateRegistrationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateRegistrationRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateRegistrationRequest() when $default != null:
return $default(_that.eventId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId)  $default,) {final _that = this;
switch (_that) {
case _CreateRegistrationRequest():
return $default(_that.eventId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId)?  $default,) {final _that = this;
switch (_that) {
case _CreateRegistrationRequest() when $default != null:
return $default(_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateRegistrationRequest implements CreateRegistrationRequest {
  const _CreateRegistrationRequest({required this.eventId});
  factory _CreateRegistrationRequest.fromJson(Map<String, dynamic> json) => _$CreateRegistrationRequestFromJson(json);

@override final  String eventId;

/// Create a copy of CreateRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateRegistrationRequestCopyWith<_CreateRegistrationRequest> get copyWith => __$CreateRegistrationRequestCopyWithImpl<_CreateRegistrationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateRegistrationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateRegistrationRequest&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'CreateRegistrationRequest(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$CreateRegistrationRequestCopyWith<$Res> implements $CreateRegistrationRequestCopyWith<$Res> {
  factory _$CreateRegistrationRequestCopyWith(_CreateRegistrationRequest value, $Res Function(_CreateRegistrationRequest) _then) = __$CreateRegistrationRequestCopyWithImpl;
@override @useResult
$Res call({
 String eventId
});




}
/// @nodoc
class __$CreateRegistrationRequestCopyWithImpl<$Res>
    implements _$CreateRegistrationRequestCopyWith<$Res> {
  __$CreateRegistrationRequestCopyWithImpl(this._self, this._then);

  final _CreateRegistrationRequest _self;
  final $Res Function(_CreateRegistrationRequest) _then;

/// Create a copy of CreateRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,}) {
  return _then(_CreateRegistrationRequest(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

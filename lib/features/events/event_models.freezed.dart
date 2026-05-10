
part of 'event_models.dart';


// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventResponse {

 String get eventId; String get title; String get description; String get location; DateTime get startsAt; DateTime get endsAt; int get capacity; String get organizerId; EventStatus get status; DateTime get createdAt;
/// Create a copy of EventResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventResponseCopyWith<EventResponse> get copyWith => _$EventResponseCopyWithImpl<EventResponse>(this as EventResponse, _$identity);

  /// Serializes this EventResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventResponse&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,title,description,location,startsAt,endsAt,capacity,organizerId,status,createdAt);

@override
String toString() {
  return 'EventResponse(eventId: $eventId, title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity, organizerId: $organizerId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EventResponseCopyWith<$Res>  {
  factory $EventResponseCopyWith(EventResponse value, $Res Function(EventResponse) _then) = _$EventResponseCopyWithImpl;
@useResult
$Res call({
 String eventId, String title, String description, String location, DateTime startsAt, DateTime endsAt, int capacity, String organizerId, EventStatus status, DateTime createdAt
});




}
/// @nodoc
class _$EventResponseCopyWithImpl<$Res>
    implements $EventResponseCopyWith<$Res> {
  _$EventResponseCopyWithImpl(this._self, this._then);

  final EventResponse _self;
  final $Res Function(EventResponse) _then;

/// Create a copy of EventResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? title = null,Object? description = null,Object? location = null,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,Object? organizerId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EventResponse].
extension EventResponsePatterns on EventResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventResponse value)  $default,){
final _that = this;
switch (_that) {
case _EventResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EventResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String title,  String description,  String location,  DateTime startsAt,  DateTime endsAt,  int capacity,  String organizerId,  EventStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventResponse() when $default != null:
return $default(_that.eventId,_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity,_that.organizerId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String title,  String description,  String location,  DateTime startsAt,  DateTime endsAt,  int capacity,  String organizerId,  EventStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _EventResponse():
return $default(_that.eventId,_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity,_that.organizerId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String title,  String description,  String location,  DateTime startsAt,  DateTime endsAt,  int capacity,  String organizerId,  EventStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EventResponse() when $default != null:
return $default(_that.eventId,_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity,_that.organizerId,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventResponse implements EventResponse {
  const _EventResponse({required this.eventId, required this.title, required this.description, required this.location, required this.startsAt, required this.endsAt, required this.capacity, required this.organizerId, required this.status, required this.createdAt});
  factory _EventResponse.fromJson(Map<String, dynamic> json) => _$EventResponseFromJson(json);

@override final  String eventId;
@override final  String title;
@override final  String description;
@override final  String location;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  int capacity;
@override final  String organizerId;
@override final  EventStatus status;
@override final  DateTime createdAt;

/// Create a copy of EventResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventResponseCopyWith<_EventResponse> get copyWith => __$EventResponseCopyWithImpl<_EventResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResponse&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,title,description,location,startsAt,endsAt,capacity,organizerId,status,createdAt);

@override
String toString() {
  return 'EventResponse(eventId: $eventId, title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity, organizerId: $organizerId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EventResponseCopyWith<$Res> implements $EventResponseCopyWith<$Res> {
  factory _$EventResponseCopyWith(_EventResponse value, $Res Function(_EventResponse) _then) = __$EventResponseCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String title, String description, String location, DateTime startsAt, DateTime endsAt, int capacity, String organizerId, EventStatus status, DateTime createdAt
});




}
/// @nodoc
class __$EventResponseCopyWithImpl<$Res>
    implements _$EventResponseCopyWith<$Res> {
  __$EventResponseCopyWithImpl(this._self, this._then);

  final _EventResponse _self;
  final $Res Function(_EventResponse) _then;

/// Create a copy of EventResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? title = null,Object? description = null,Object? location = null,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,Object? organizerId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_EventResponse(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CreateEventRequest {

 String get title; String get description; String get location; DateTime get startsAt; DateTime get endsAt; int get capacity;
/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateEventRequestCopyWith<CreateEventRequest> get copyWith => _$CreateEventRequestCopyWithImpl<CreateEventRequest>(this as CreateEventRequest, _$identity);

  /// Serializes this CreateEventRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,location,startsAt,endsAt,capacity);

@override
String toString() {
  return 'CreateEventRequest(title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity)';
}


}

/// @nodoc
abstract mixin class $CreateEventRequestCopyWith<$Res>  {
  factory $CreateEventRequestCopyWith(CreateEventRequest value, $Res Function(CreateEventRequest) _then) = _$CreateEventRequestCopyWithImpl;
@useResult
$Res call({
 String title, String description, String location, DateTime startsAt, DateTime endsAt, int capacity
});




}
/// @nodoc
class _$CreateEventRequestCopyWithImpl<$Res>
    implements $CreateEventRequestCopyWith<$Res> {
  _$CreateEventRequestCopyWithImpl(this._self, this._then);

  final CreateEventRequest _self;
  final $Res Function(CreateEventRequest) _then;

/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? location = null,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateEventRequest].
extension CreateEventRequestPatterns on CreateEventRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateEventRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateEventRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateEventRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateEventRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String location,  DateTime startsAt,  DateTime endsAt,  int capacity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String location,  DateTime startsAt,  DateTime endsAt,  int capacity)  $default,) {final _that = this;
switch (_that) {
case _CreateEventRequest():
return $default(_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String location,  DateTime startsAt,  DateTime endsAt,  int capacity)?  $default,) {final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateEventRequest implements CreateEventRequest {
  const _CreateEventRequest({required this.title, required this.description, required this.location, required this.startsAt, required this.endsAt, required this.capacity});
  factory _CreateEventRequest.fromJson(Map<String, dynamic> json) => _$CreateEventRequestFromJson(json);

@override final  String title;
@override final  String description;
@override final  String location;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  int capacity;

/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateEventRequestCopyWith<_CreateEventRequest> get copyWith => __$CreateEventRequestCopyWithImpl<_CreateEventRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateEventRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,location,startsAt,endsAt,capacity);

@override
String toString() {
  return 'CreateEventRequest(title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity)';
}


}

/// @nodoc
abstract mixin class _$CreateEventRequestCopyWith<$Res> implements $CreateEventRequestCopyWith<$Res> {
  factory _$CreateEventRequestCopyWith(_CreateEventRequest value, $Res Function(_CreateEventRequest) _then) = __$CreateEventRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String location, DateTime startsAt, DateTime endsAt, int capacity
});




}
/// @nodoc
class __$CreateEventRequestCopyWithImpl<$Res>
    implements _$CreateEventRequestCopyWith<$Res> {
  __$CreateEventRequestCopyWithImpl(this._self, this._then);

  final _CreateEventRequest _self;
  final $Res Function(_CreateEventRequest) _then;

/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? location = null,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,}) {
  return _then(_CreateEventRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UpdateEventRequest {

 String? get title; String? get description; String? get location; DateTime? get startsAt; DateTime? get endsAt; int? get capacity;
/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateEventRequestCopyWith<UpdateEventRequest> get copyWith => _$UpdateEventRequestCopyWithImpl<UpdateEventRequest>(this as UpdateEventRequest, _$identity);

  /// Serializes this UpdateEventRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,location,startsAt,endsAt,capacity);

@override
String toString() {
  return 'UpdateEventRequest(title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity)';
}


}

/// @nodoc
abstract mixin class $UpdateEventRequestCopyWith<$Res>  {
  factory $UpdateEventRequestCopyWith(UpdateEventRequest value, $Res Function(UpdateEventRequest) _then) = _$UpdateEventRequestCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, String? location, DateTime? startsAt, DateTime? endsAt, int? capacity
});




}
/// @nodoc
class _$UpdateEventRequestCopyWithImpl<$Res>
    implements $UpdateEventRequestCopyWith<$Res> {
  _$UpdateEventRequestCopyWithImpl(this._self, this._then);

  final UpdateEventRequest _self;
  final $Res Function(UpdateEventRequest) _then;

/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? location = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? capacity = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateEventRequest].
extension UpdateEventRequestPatterns on UpdateEventRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateEventRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateEventRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateEventRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateEventRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description,  String? location,  DateTime? startsAt,  DateTime? endsAt,  int? capacity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description,  String? location,  DateTime? startsAt,  DateTime? endsAt,  int? capacity)  $default,) {final _that = this;
switch (_that) {
case _UpdateEventRequest():
return $default(_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description,  String? location,  DateTime? startsAt,  DateTime? endsAt,  int? capacity)?  $default,) {final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.capacity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateEventRequest implements UpdateEventRequest {
  const _UpdateEventRequest({this.title, this.description, this.location, this.startsAt, this.endsAt, this.capacity});
  factory _UpdateEventRequest.fromJson(Map<String, dynamic> json) => _$UpdateEventRequestFromJson(json);

@override final  String? title;
@override final  String? description;
@override final  String? location;
@override final  DateTime? startsAt;
@override final  DateTime? endsAt;
@override final  int? capacity;

/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateEventRequestCopyWith<_UpdateEventRequest> get copyWith => __$UpdateEventRequestCopyWithImpl<_UpdateEventRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateEventRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,location,startsAt,endsAt,capacity);

@override
String toString() {
  return 'UpdateEventRequest(title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity)';
}


}

/// @nodoc
abstract mixin class _$UpdateEventRequestCopyWith<$Res> implements $UpdateEventRequestCopyWith<$Res> {
  factory _$UpdateEventRequestCopyWith(_UpdateEventRequest value, $Res Function(_UpdateEventRequest) _then) = __$UpdateEventRequestCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, String? location, DateTime? startsAt, DateTime? endsAt, int? capacity
});




}
/// @nodoc
class __$UpdateEventRequestCopyWithImpl<$Res>
    implements _$UpdateEventRequestCopyWith<$Res> {
  __$UpdateEventRequestCopyWithImpl(this._self, this._then);

  final _UpdateEventRequest _self;
  final $Res Function(_UpdateEventRequest) _then;

/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? location = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? capacity = freezed,}) {
  return _then(_UpdateEventRequest(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contents_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentsClass _$ContentsClassFromJson(Map<String, dynamic> json) {
  return _ContentsClass.fromJson(json);
}

/// @nodoc
mixin _$ContentsClass {
  String get id => throw _privateConstructorUsedError;
  int get weekday => throw _privateConstructorUsedError;
  String get band_name => throw _privateConstructorUsedError;
  String get user_name => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentsClassCopyWith<ContentsClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentsClassCopyWith<$Res> {
  factory $ContentsClassCopyWith(
          ContentsClass value, $Res Function(ContentsClass) then) =
      _$ContentsClassCopyWithImpl<$Res, ContentsClass>;
  @useResult
  $Res call(
      {String id, int weekday, String band_name, String user_name, int time});
}

/// @nodoc
class _$ContentsClassCopyWithImpl<$Res, $Val extends ContentsClass>
    implements $ContentsClassCopyWith<$Res> {
  _$ContentsClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? band_name = null,
    Object? user_name = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      band_name: null == band_name
          ? _value.band_name
          : band_name // ignore: cast_nullable_to_non_nullable
              as String,
      user_name: null == user_name
          ? _value.user_name
          : user_name // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentsClassImplCopyWith<$Res>
    implements $ContentsClassCopyWith<$Res> {
  factory _$$ContentsClassImplCopyWith(
          _$ContentsClassImpl value, $Res Function(_$ContentsClassImpl) then) =
      __$$ContentsClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, int weekday, String band_name, String user_name, int time});
}

/// @nodoc
class __$$ContentsClassImplCopyWithImpl<$Res>
    extends _$ContentsClassCopyWithImpl<$Res, _$ContentsClassImpl>
    implements _$$ContentsClassImplCopyWith<$Res> {
  __$$ContentsClassImplCopyWithImpl(
      _$ContentsClassImpl _value, $Res Function(_$ContentsClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? band_name = null,
    Object? user_name = null,
    Object? time = null,
  }) {
    return _then(_$ContentsClassImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      band_name: null == band_name
          ? _value.band_name
          : band_name // ignore: cast_nullable_to_non_nullable
              as String,
      user_name: null == user_name
          ? _value.user_name
          : user_name // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentsClassImpl
    with DiagnosticableTreeMixin
    implements _ContentsClass {
  const _$ContentsClassImpl(
      {required this.id,
      required this.weekday,
      required this.band_name,
      required this.user_name,
      required this.time});

  factory _$ContentsClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentsClassImplFromJson(json);

  @override
  final String id;
  @override
  final int weekday;
  @override
  final String band_name;
  @override
  final String user_name;
  @override
  final int time;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ContentsClass(id: $id, weekday: $weekday, band_name: $band_name, user_name: $user_name, time: $time)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ContentsClass'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('weekday', weekday))
      ..add(DiagnosticsProperty('band_name', band_name))
      ..add(DiagnosticsProperty('user_name', user_name))
      ..add(DiagnosticsProperty('time', time));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentsClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.band_name, band_name) ||
                other.band_name == band_name) &&
            (identical(other.user_name, user_name) ||
                other.user_name == user_name) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, weekday, band_name, user_name, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentsClassImplCopyWith<_$ContentsClassImpl> get copyWith =>
      __$$ContentsClassImplCopyWithImpl<_$ContentsClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentsClassImplToJson(
      this,
    );
  }
}

abstract class _ContentsClass implements ContentsClass {
  const factory _ContentsClass(
      {required final String id,
      required final int weekday,
      required final String band_name,
      required final String user_name,
      required final int time}) = _$ContentsClassImpl;

  factory _ContentsClass.fromJson(Map<String, dynamic> json) =
      _$ContentsClassImpl.fromJson;

  @override
  String get id;
  @override
  int get weekday;
  @override
  String get band_name;
  @override
  String get user_name;
  @override
  int get time;
  @override
  @JsonKey(ignore: true)
  _$$ContentsClassImplCopyWith<_$ContentsClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AllScheduleClass _$AllScheduleClassFromJson(Map<String, dynamic> json) {
  return _AllScheduleClass.fromJson(json);
}

/// @nodoc
mixin _$AllScheduleClass {
  String get id => throw _privateConstructorUsedError;
  int get weekday => throw _privateConstructorUsedError;
  String get band => throw _privateConstructorUsedError;
  int get week => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllScheduleClassCopyWith<AllScheduleClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllScheduleClassCopyWith<$Res> {
  factory $AllScheduleClassCopyWith(
          AllScheduleClass value, $Res Function(AllScheduleClass) then) =
      _$AllScheduleClassCopyWithImpl<$Res, AllScheduleClass>;
  @useResult
  $Res call({String id, int weekday, String band, int week, int time});
}

/// @nodoc
class _$AllScheduleClassCopyWithImpl<$Res, $Val extends AllScheduleClass>
    implements $AllScheduleClassCopyWith<$Res> {
  _$AllScheduleClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? band = null,
    Object? week = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      band: null == band
          ? _value.band
          : band // ignore: cast_nullable_to_non_nullable
              as String,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllScheduleClassImplCopyWith<$Res>
    implements $AllScheduleClassCopyWith<$Res> {
  factory _$$AllScheduleClassImplCopyWith(_$AllScheduleClassImpl value,
          $Res Function(_$AllScheduleClassImpl) then) =
      __$$AllScheduleClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int weekday, String band, int week, int time});
}

/// @nodoc
class __$$AllScheduleClassImplCopyWithImpl<$Res>
    extends _$AllScheduleClassCopyWithImpl<$Res, _$AllScheduleClassImpl>
    implements _$$AllScheduleClassImplCopyWith<$Res> {
  __$$AllScheduleClassImplCopyWithImpl(_$AllScheduleClassImpl _value,
      $Res Function(_$AllScheduleClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? band = null,
    Object? week = null,
    Object? time = null,
  }) {
    return _then(_$AllScheduleClassImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      band: null == band
          ? _value.band
          : band // ignore: cast_nullable_to_non_nullable
              as String,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllScheduleClassImpl
    with DiagnosticableTreeMixin
    implements _AllScheduleClass {
  const _$AllScheduleClassImpl(
      {required this.id,
      required this.weekday,
      required this.band,
      required this.week,
      required this.time});

  factory _$AllScheduleClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllScheduleClassImplFromJson(json);

  @override
  final String id;
  @override
  final int weekday;
  @override
  final String band;
  @override
  final int week;
  @override
  final int time;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AllScheduleClass(id: $id, weekday: $weekday, band: $band, week: $week, time: $time)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AllScheduleClass'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('weekday', weekday))
      ..add(DiagnosticsProperty('band', band))
      ..add(DiagnosticsProperty('week', week))
      ..add(DiagnosticsProperty('time', time));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllScheduleClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.band, band) || other.band == band) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, weekday, band, week, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllScheduleClassImplCopyWith<_$AllScheduleClassImpl> get copyWith =>
      __$$AllScheduleClassImplCopyWithImpl<_$AllScheduleClassImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllScheduleClassImplToJson(
      this,
    );
  }
}

abstract class _AllScheduleClass implements AllScheduleClass {
  const factory _AllScheduleClass(
      {required final String id,
      required final int weekday,
      required final String band,
      required final int week,
      required final int time}) = _$AllScheduleClassImpl;

  factory _AllScheduleClass.fromJson(Map<String, dynamic> json) =
      _$AllScheduleClassImpl.fromJson;

  @override
  String get id;
  @override
  int get weekday;
  @override
  String get band;
  @override
  int get week;
  @override
  int get time;
  @override
  @JsonKey(ignore: true)
  _$$AllScheduleClassImplCopyWith<_$AllScheduleClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

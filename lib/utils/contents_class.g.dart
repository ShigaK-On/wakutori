// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentsClassImpl _$$ContentsClassImplFromJson(Map<String, dynamic> json) =>
    _$ContentsClassImpl(
      id: json['id'] as String,
      weekday: (json['weekday'] as num).toInt(),
      band_name: json['band_name'] as String,
      user_name: json['user_name'] as String,
      time: (json['time'] as num).toInt(),
    );

Map<String, dynamic> _$$ContentsClassImplToJson(_$ContentsClassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekday': instance.weekday,
      'band_name': instance.band_name,
      'user_name': instance.user_name,
      'time': instance.time,
    };

_$AllScheduleClassImpl _$$AllScheduleClassImplFromJson(
        Map<String, dynamic> json) =>
    _$AllScheduleClassImpl(
      id: json['id'] as String,
      weekday: (json['weekday'] as num).toInt(),
      band: json['band'] as String,
      week: (json['week'] as num).toInt(),
      time: (json['time'] as num).toInt(),
    );

Map<String, dynamic> _$$AllScheduleClassImplToJson(
        _$AllScheduleClassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekday': instance.weekday,
      'band': instance.band,
      'week': instance.week,
      'time': instance.time,
    };

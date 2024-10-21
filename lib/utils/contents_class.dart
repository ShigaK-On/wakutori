import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'contents_class.freezed.dart';
part 'contents_class.g.dart';

@freezed
class ContentsClass with _$ContentsClass {
  const factory ContentsClass({
    required String id,
    required int weekday,
    required String band_name,
    required String user_name,
    required int time,
  }) = _ContentsClass;

  factory ContentsClass.fromJson(Map<String, dynamic> json) => _$ContentsClassFromJson(json);
}

@freezed
class AllScheduleClass with _$AllScheduleClass {
  const factory AllScheduleClass({
    required String id,
    required int weekday,
    required String band,
    required int week,
    required int time,
  }) = _AllScheduleClass;

  factory AllScheduleClass.fromJson(Map<String, dynamic> json) => _$AllScheduleClassFromJson(json);
}
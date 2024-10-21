import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/contents_class.dart';
import '../utils/logger.dart';


final getAllStream = StreamProvider<List<AllScheduleClass>>((ref) async* {
  final SupabaseClient supabase = Supabase.instance.client;
  final stream = supabase.from('all_schedule').stream(primaryKey: ['id']);
  await for(final data in stream) {
    yield data.map((element) => AllScheduleClass.fromJson(element)).toList();
  }
});

void updateAllSchedule(String id, bool isTrue, [String? bandName]) async {
  //if "isTrue" = true, update Data.
  //if false, delete Data.
  final SupabaseClient supabase = Supabase.instance.client;
  if(isTrue) {
    await supabase.from('all_schedule').update({
      'band': bandName!,
    }).eq(
      'id', id,
    );
  } else {
    try {
      await supabase.from('all_schedule').delete().match({
        'id': id,
      });
    } catch(e) {
      logger.e(e);
    }
  }
}

void insertAllSchedule(String bandName, int weekday, int time, int week) async {
  final SupabaseClient supabase = Supabase.instance.client;
  try {
    await supabase.from('all_schedule').insert({
      'band': bandName,
      'weekday': weekday,
      'time': time,
      'week': week,
    });
  } catch(e) {
    logger.e(e);
  }
}
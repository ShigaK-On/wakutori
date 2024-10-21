import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakutori/utils/contents_class.dart';
import '../utils/logger.dart';

String bandName = '';

Future<bool> existPassword(String password) async {
  final SupabaseClient supabase = Supabase.instance.client;
  final List<Map<String, dynamic>> data = await supabase.from('band').select().eq('band', password);
  if(data.isNotEmpty) {
    bandName = password;
    return true;
  } else {
    return false;
  }
}

Future<bool> createNewPassword(String password) async {
  final SupabaseClient supabase = Supabase.instance.client;
  try {
    await supabase.from('band').insert({'band' : password});
    bandName = password;
    return true;
  } catch(e) {
    logger.i(e);
    return false;
  }
}

final getStream = StreamProvider<List<ContentsClass>>((ref) async* {
  final SupabaseClient supabase = Supabase.instance.client;
  final stream = supabase.from('schedule').stream(primaryKey: ['id']).eq('band_name', bandName);
  await for(final data in stream) {
    yield data.map((element) => ContentsClass.fromJson(element)).toList();
  }
});

void updateMySchedule(String userName, int weekday, int time, bool isTrue) async {
  final SupabaseClient supabase = Supabase.instance.client;
  if(isTrue) {
    await supabase.from('schedule').insert({
      'user_name': userName,
      'band_name': bandName,
      'weekday': weekday,
      'time': time,
    });
  } else {
    try {
      await supabase.from('schedule').delete().eq(
        'user_name', userName,
      ).eq(
        'band_name', bandName,
      ).eq(
        'weekday', weekday,
      ).eq(
        'time', time,
      );
    } catch(e) {
      logger.e(e);
    }
  }
}
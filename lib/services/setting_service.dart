import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakutori/utils/half_mode.dart';
import 'package:wakutori/utils/logger.dart';
import 'dart:collection' as collection;

import '../utils/contents_class.dart';

void halfModeToggle(bool isTrue) {
  isHalfMode = isTrue;
}

void resetSchedule(bool isBandReset) async {
  final SupabaseClient supabase = Supabase.instance.client;
  try {
    await supabase.from('schedule').delete();
    if(isBandReset) {
      await supabase.from('band').delete();
    }
  } catch(e) {
    logger.e(e);
  }
}

void setAllSchedulePreviousWeek() async {
  final SupabaseClient supabase = Supabase.instance.client;
  try {
    await supabase.from('all_schedule').delete().eq('week', 2);
    await supabase.from('all_schedule').update({
      'week': 2,
    }).match({
      'week': 1,
    });
    await supabase.from('all_schedule').update({
      'week': 1,
    }).match({
      'week': 0,
    });
  } catch(e) {
    logger.e(e);
  }
}

void setAllSchedule(int bandCount, String primaryWord, int howToSet, bool isRewritable) async {
  final SupabaseClient supabase = Supabase.instance.client;
  final List<Map<String, dynamic>> bands = await supabase.from('band').select();

  const List<String> dates = ['火', '水', '木', '金', '土', '日', '月'];
  const List<String> times = ['1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];

  //入力のあるバンドとbandCountのチェック用
  final Map<String, int> bandNameCheck = {};

  //最終リストの定義
  final Map<String, Map<String, int>> completeList = {};
  for(String date in dates) {
    for(String time in times) {
      completeList.addAll({
        '$date曜日 $time': {
          '': 0,
        },
      });
    }
  }

  //バンドごとのランキング
  Map<String, Map<String, int>> rankedBands = {};
  for(Map<String, dynamic> band in bands) {
    final String name = band['band'];
    bandNameCheck.addAll({
      name: 0,
    });
    rankedBands.addAll({name: {}});
    
    final List<Map<String, dynamic>> rowData = await supabase.from('schedule').select().eq('band_name', name);
    final List<ContentsClass> classedData = rowData.map((element) => ContentsClass.fromJson(element)).toList();

    Map<String, int> bestTimeAsMap = {};
    for(ContentsClass data in classedData) {
      final String key = '${dates[data.weekday]}曜日 ${times[data.time]}';
      bestTimeAsMap.update(key, (i) => ++i, ifAbsent: () => 1);
    }

    //団体練、個人練、優先する単語の重み付け
    rankedBands[name] = bestTimeAsMap.map((dateTime, density) {
      if (name.contains('団体練')) {
        return MapEntry(dateTime, density + 100);
      } else if (name.contains('個人練')) {
        return MapEntry(dateTime, density - 50);
      } else if(primaryWord.isNotEmpty && name.contains(primaryWord)){
        return MapEntry(dateTime, density + 50);
      } else {
        return MapEntry(dateTime, density);
      }
    });

    if(rankedBands[name]!.isEmpty) {
      rankedBands.remove(name);
    }

    // rankedBands内の各バンドを重みで降順ソート
    rankedBands.forEach((bandName, bandData) {
      final List<MapEntry<String, int>> sortedData = bandData.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      rankedBands[bandName] = Map.fromEntries(sortedData);
    });
  }

  logger.i(rankedBands);
  logger.i(completeList);
}
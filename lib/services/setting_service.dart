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
  final Map<String, Map<String, int>> rankedBands = {};
  for(Map<String, dynamic> band in bands) {
    final String bandName = band['band'];
    rankedBands.addAll({bandName: {}});
    
    final List<Map<String, dynamic>> rowData = await supabase.from('schedule').select().eq('band_name', bandName);
    final List<ContentsClass> classedData = rowData.map((element) => ContentsClass.fromJson(element)).toList();

    Map<String, int> bestTimeAsMap = {};
    for(ContentsClass data in classedData) {
      final String key = '${dates[data.weekday]}曜日 ${times[data.time]}';
      bestTimeAsMap.update(key, (i) => ++i, ifAbsent: () => 1);
    }
    rankedBands[bandName] = collection.SplayTreeMap.of(bestTimeAsMap, (a, b) {
      int compare = bestTimeAsMap[a]!.compareTo(bestTimeAsMap[b] as num) * -1;
      return compare == 0 ? 1 : compare;
    });
  }

  //優先する単語を含むバンドの各日時に50の比重を追加
  final Map<String, Map<String, int>> primaryRankedBands = {};
  for(var entry in rankedBands.entries) {
    final String key = entry.key;
    final Map<String, int> value = entry.value;
    if(primaryWord.isNotEmpty && key.contains(primaryWord)) {
      final Map<String, int> innerMap = {};
      value.forEach((dateTime, density) {
        innerMap[dateTime] = density + 50;
      });
      primaryRankedBands[key] = innerMap;
    } else {
      primaryRankedBands[key] = value;
    }
  }

  //最終リストに代入
  for(int i = 0; i < primaryRankedBands.length; i++) {
    if(primaryRankedBands.values.elementAt(i).isNotEmpty) {
      //各バンド枠上限
      for(int n = 0; n < bandCount; n++) {
        final String dateTimeKey = primaryRankedBands.values.elementAt(i).keys.elementAt(n);
        final String newKey = primaryRankedBands.keys.elementAt(i);
        final int previousValue = completeList[dateTimeKey]![newKey]!;
        final int newValue = primaryRankedBands.values.elementAt(i).values.elementAt(n);
        logger.i(previousValue);
        if(previousValue < newValue){
          completeList[dateTimeKey] = {
            newKey: newValue,
          };
        }
      }
    }
  }
  logger.i(completeList);
}
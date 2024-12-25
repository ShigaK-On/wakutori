import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakutori/utils/logger.dart';
import '../utils/contents_class.dart';

void resetSchedule(bool isBandReset) async {
  final SupabaseClient supabase = Supabase.instance.client;
  try {
    await supabase.from('schedule').delete();
    if (isBandReset) {
      await supabase.from('band').delete();
    }
  } catch (e) {
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
  } catch (e) {
    logger.e(e);
  }
}

void setAllSchedule(
    int bandCount, String primaryWord, int howToSet, bool isRewritable) async {
  final SupabaseClient supabase = Supabase.instance.client;
  final List<Map<String, dynamic>> bands = await supabase.from('band').select();

  const List<String> dates = ['水', '木', '金', '土', '日', '月', '火'];
  const List<String> times = ['1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];

  // バンドごとの枠数
  Map<String, int> pendingTimeOfBands = {
    for (var band in bands) band['band']: bandCount
  };

  // 日毎の重み付けマップ
  final Map<String, Map<String, int>> dayBands = {
    for (String date in dates)
      for (String time in times) '$date曜日 $time': {}
  };

  // スケジュールが埋まった状態を記録
  Map<String, String> completedSchedule = {
    for (String date in dates)
      for (String time in times) '$date曜日 $time': ''
  };

  // バンドごとのランキング
  Map<String, Map<String, int>> rankedBands = {};

  for (Map<String, dynamic> band in bands) {
    final String name = band['band'];
    rankedBands[name] = {};

    final List<Map<String, dynamic>> rowData =
    await supabase.from('schedule').select().eq('band_name', name);
    final List<ContentsClass> classedData =
    rowData.map((element) => ContentsClass.fromJson(element)).toList();
    Map<String, int> bestTimeAsMap = {};

    for (ContentsClass data in classedData) {
      final String key = '${dates[data.weekday]}曜日 ${times[data.time]}';
      bestTimeAsMap.update(key, (i) => ++i, ifAbsent: () => 1);
      pendingTimeOfBands.update(name, (i) => min(++i, bandCount));
    }

    // 重み付けを計算
    rankedBands[name] = bestTimeAsMap.map((dateTime, density) {
      if (name.contains('団体練')) {
        return MapEntry(dateTime, density + 100);
      } else if (name.contains('個人練')) {
        return MapEntry(dateTime, density - 50);
      } else if (primaryWord.isNotEmpty && name.contains(primaryWord)) {
        return MapEntry(dateTime, density + 50);
      } else {
        return MapEntry(dateTime, density);
      }
    });

    // dayBands に重み付けを反映
    if (rankedBands[name]!.isNotEmpty) {
      rankedBands[name]!.forEach((dateTime, density) {
        if (!dayBands.containsKey(dateTime)) {
          dayBands[dateTime] = {};
        }
        dayBands[dateTime]![name] = density;
      });
    }
  }

  //rankedBands内の各バンドを重みで降順ソート
  rankedBands.forEach((bandName, bandData) {
    final List<MapEntry<String, int>> sortedData = bandData.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    rankedBands[bandName] = Map.fromEntries(sortedData);
  });

  //dayBands内の各dateTimeを重みで降順ソート
  dayBands.forEach((dateTime, bandData) {
    final List<MapEntry<String, int>> sortedData = bandData.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    dayBands[dateTime] = Map.fromEntries(sortedData);
  });

  logger.i(rankedBands);
  logger.i(dayBands);

  distributeSchedule(dayBands, pendingTimeOfBands, completedSchedule);
  logger.i(completedSchedule);
}

void distributeSchedule(Map<String, Map<String, int>> dayBands, Map<String, int> pendingTimeOfBands, Map<String, String> completedSchedule) {
  // バンドごとの枠数
  Map<String, int> assignedCount = {
    for (String bandName in pendingTimeOfBands.keys) bandName: 0
  };

  // 競合マップ
  Map<String, List<String>> conflictMap = {};

  // 確定枠 (dayBandsのindex[0]) の処理
  String firstDate = dayBands.keys.first;
  if (dayBands[firstDate]!.isNotEmpty) {
    var highestPriorityBand = dayBands[firstDate]!.entries.reduce(
            (a, b) => a.value >= b.value ? a : b);
    completedSchedule[firstDate] = highestPriorityBand.key;
    assignedCount.update(highestPriorityBand.key, (value) => value + 1);
  }

  // バンド割り当て処理
  var sortedBandsByRemaining = pendingTimeOfBands.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  // バンドごとの枠数が残っている場合
  for (var entry in sortedBandsByRemaining) {
    String bandName = entry.key;
    int remaining = entry.value;

    if (remaining > 0) {
      for (String date in dayBands.keys) {
        if (completedSchedule[date]!.isEmpty &&
            dayBands[date]!.containsKey(bandName)) {
          completedSchedule[date] = bandName;
          assignedCount.update(bandName, (value) => value + 1);
          break;
        }
      }
    }
  }

  // 競合解決
  for (String date in completedSchedule.keys) {
    if (completedSchedule[date]!.isNotEmpty) {
      String assignedBand = completedSchedule[date]!;
      if (assignedCount[assignedBand]! > pendingTimeOfBands[assignedBand]!) {
        conflictMap.update(
          date,
              (value) => [...value, assignedBand],
          ifAbsent: () => [assignedBand],
        );
      }
    }
  }

  // 競合解決処理
  for (String date in conflictMap.keys) {
    List<String> conflictingBands = conflictMap[date]!;
    conflictingBands.sort((a, b) =>
        assignedCount[a]!.compareTo(assignedCount[b]!));

    for (String bandName in conflictingBands) {
      if (assignedCount[bandName]! > pendingTimeOfBands[bandName]!) {
        completedSchedule[date] = '';
        assignedCount.update(bandName, (value) => value - 1);
        break;
      }
    }
  }

  // 上限調整
  for (String bandName in pendingTimeOfBands.keys) {
    while (assignedCount[bandName]! > pendingTimeOfBands[bandName]!) {
      var excessDates = completedSchedule.entries
          .where((entry) => entry.value == bandName)
          .map((entry) => entry.key)
          .toList();

      if (excessDates.isNotEmpty) {
        excessDates.sort((a, b) =>
            dayBands[a]![bandName]!.compareTo(dayBands[b]![bandName]!));
        completedSchedule[excessDates.first] = '';
        assignedCount.update(bandName, (value) => value - 1);
      }
    }
  }

  // 最低1枠確保
  for (String bandName in pendingTimeOfBands.keys) {
    if (assignedCount[bandName] == 0) {
      for (String date in dayBands.keys) {
        if (completedSchedule[date]!.isEmpty &&
            dayBands[date]!.containsKey(bandName)) {
          completedSchedule[date] = bandName;
          assignedCount.update(bandName, (value) => value + 1);
          break;
        }
      }
    }
  }
}

// import 'dart:math';

// import 'package:flutter/material.dart';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakutori/utils/half_mode.dart';
import 'package:wakutori/utils/logger.dart';
// import 'dart:collection' as collection;

import '../utils/contents_class.dart';

void halfModeToggle(bool isTrue) {
  isHalfMode = isTrue;
}

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
    final int bandCount,
    final String primaryWord,
    final int howToSet,
    final bool isRewritable) async {
  final SupabaseClient supabase = Supabase.instance.client;

  const List<String> dates = ['水', '木', '金', '土', '日', '月', '火'];
  const List<String> times = ['1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];

  final List<Map<String, dynamic>> bands = await supabase.from('band').select();
  final Map<String, int> pendingTimeOfBands = {
    for (final Map<String, dynamic> band in bands) band['band']: bandCount
  };
  final Map<String, String> completedSchedule = {
    for (final String date in dates)
      for (final String time in times) '$date曜日 $time': ''
  };
  final Map<String, Map<String, int>> dayBands = {
    for (final String date in dates)
      for (final String time in times) '$date曜日 $time': {}
  };

  final Map<String, Map<String, int>> rankedBands = <String, Map<String, int>>{};
  for (final Map<String, dynamic> band in bands) {
    final String name = band['band'];
    rankedBands[name] = {};
    final List<Map<String, dynamic>> rowData =
    await supabase.from('schedule').select().eq('band_name', name);
    final List<ContentsClass> classedData =
    rowData.map((final Map<String, dynamic> data) => ContentsClass.fromJson(data)).toList();

    final Map<String, int> bestTimeAsMap = <String, int>{};
    for (final ContentsClass data in classedData) {
      final String key = '${dates[data.weekday]}曜日 ${times[data.time]}';
      bestTimeAsMap[key] = (bestTimeAsMap[key] ?? 0) + 1;
      pendingTimeOfBands[name] = min((pendingTimeOfBands[name] ?? 0) + 1, bandCount);
    }

    rankedBands[name] = bestTimeAsMap.map((final String dateTime, final int density) {
      int weight = density;
      if (name.contains('団体練')) weight += 100;
      if (name.contains('個人練')) weight -= 50;
      if (primaryWord.isNotEmpty && name.contains(primaryWord)) weight += 50;
      return MapEntry(dateTime, weight);
    });

    rankedBands[name]!.forEach((final String dateTime, final int density) {
      dayBands[dateTime]![name] = density;
    });
  }

  _distributeSchedule(dayBands, pendingTimeOfBands, completedSchedule);
  logger.i(completedSchedule);
}

void _distributeSchedule(
    final Map<String, Map<String, int>> dayBands,
    final Map<String, int> pendingTimeOfBands,
    final Map<String, String> completedSchedule) {
  final Map<String, int> assignedCount = {
    for (final String band in pendingTimeOfBands.keys) band: 0
  };
  final Map<String, List<String>> conflictMap = <String, List<String>>{};

  final String firstDate = dayBands.keys.first;
  if (dayBands[firstDate]!.isNotEmpty) {
    final MapEntry<String, int> highestPriorityBand = dayBands[firstDate]!.entries
        .reduce((final MapEntry<String, int> a, final MapEntry<String, int> b) => a.value >= b.value ? a : b);
    completedSchedule[firstDate] = highestPriorityBand.key;
    assignedCount[highestPriorityBand.key] = 1;
  }

  final List<MapEntry<String, int>> sortedBandsByRemaining =
  pendingTimeOfBands.entries.toList()
    ..sort((final MapEntry<String, int> a, final MapEntry<String, int> b) => a.value.compareTo(b.value));
  for (final MapEntry<String, int> entry in sortedBandsByRemaining) {
    final String bandName = entry.key;
    if (entry.value > 0) {
      for (final String date in dayBands.keys) {
        if (completedSchedule[date]!.isEmpty && dayBands[date]!.containsKey(bandName)) {
          completedSchedule[date] = bandName;
          assignedCount[bandName] = (assignedCount[bandName] ?? 0) + 1;
          break;
        }
      }
    }
  }

  for (final String date in dayBands.keys.where((final String date) => completedSchedule[date]!.isNotEmpty)) {
    final String band = completedSchedule[date]!;
    if (assignedCount[band]! > pendingTimeOfBands[band]!) {
      conflictMap.update(date, (final List<String> list) => [...list, band], ifAbsent: () => [band]);
    }
  }

  for (final String date in conflictMap.keys) {
    final List<String> conflictingBands = conflictMap[date]!;
    conflictingBands.sort((final String a, final String b) => assignedCount[a]!.compareTo(assignedCount[b]!));
    for (final String band in conflictingBands) {
      if (assignedCount[band]! > pendingTimeOfBands[band]!) {
        completedSchedule[date] = '';
        assignedCount[band] = (assignedCount[band] ?? 1) - 1;
        break;
      }
    }
  }

  for (final String band in pendingTimeOfBands.keys) {
    if (assignedCount[band] == 0) {
      for (final String date in dayBands.keys) {
        if (completedSchedule[date]!.isEmpty && dayBands[date]!.containsKey(band)) {
          completedSchedule[date] = band;
          assignedCount[band] = (assignedCount[band] ?? 0) + 1;
          break;
        }
      }
    }
  }
}


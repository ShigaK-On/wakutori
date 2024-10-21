import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakutori/services/all_schedule_view_service.dart';
import 'package:wakutori/utils/contents_class.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/utils/screen_size.dart';
import 'package:wakutori/views/edit_all_schedule.dart';
import 'package:wakutori/widgets/all_schedule_widgets/app_bar.dart';


class AllScheduleBody extends ConsumerWidget {
  const AllScheduleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> dates = ['火', '水', '木', '金', '土', '日', '月'];
    final List<String> times = ['1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];
    return ref.watch(getAllStream).when(
      data: (List<AllScheduleClass> data) {
        Map<String, Map<String, dynamic>> dataList = addDataList(dates, times);
        Map<String, Map<String, dynamic>> idList = addDataList(dates, times);
        for(AllScheduleClass mapData in data) {
          if(ref.watch(menuItemIndex) == mapData.week) {
            dataList[dates[mapData.weekday]]![times[mapData.time]] = mapData.band;
            idList[dates[mapData.weekday]]![times[mapData.time]] = mapData.id;
          }
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => EditAllSchedule(
                    weekday: index,
                    week: ref.watch(menuItemIndex),
                    dayData: dataList[dates[index]]!,
                    idData: idList[dates[index]]!,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      dates[index],
                      style: TextStyle(
                        color: index == 4 ? Colors.blue : index == 5 ? Colors.red : null,
                      ),
                    ),
                    const Divider(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataList[dates[index]]!.length,
                      itemBuilder: (BuildContext context, int indexE) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${times[indexE]}:'),
                            Expanded(
                              child: Center(
                                child: Text(dataList[dates[index]]![times[indexE]]),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Text('なんかエラー。管理できる人に聞いてX(\n$error');
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Map<String, Map<String, dynamic>> addDataList(List<String> dates, List<String> times) {
    Map<String, Map<String, dynamic>> list = {};
    for(int i = 0; i < dates.length; i++) {
      list.addAll({
        dates[i]: {},
      });
      for(String time in times) {
        list[dates[i]]!.addAll({
          time: '',
        });
      }
    }
    return list;
  }
}
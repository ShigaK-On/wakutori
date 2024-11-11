import 'package:flutter/material.dart';
import 'package:wakutori/services/home_view_service.dart';
import 'package:wakutori/utils/contents_class.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/widgets/home_view_widgets/content_size.dart';
import 'dart:collection' as collection;

import '../../utils/screen_size.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.isHorizontal, required this.dataList}) : super(key: key);
  final bool isHorizontal;
  final List<ContentsClass> dataList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 5,
        right: 5,
        top: screenSize.height * 0.025,
      ),
      child: Column(
        children: <Widget>[
          const Text('入力済みのユーザ'),
          const Divider(),
          SizedBox(
            width: isHorizontal ? contentSize()[0] * 1.25 : double.infinity,
            height: isHorizontal ? screenSize.height * 0.4 : screenSize.height * 0.06,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: isHorizontal ? Axis.vertical : Axis.horizontal,
              itemCount: getEnteredUser(dataList).length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: isHorizontal ? EdgeInsets.zero : EdgeInsets.only(
                    right: screenSize.width * 0.1,
                  ),
                  child: Text(
                    getEnteredUser(dataList)[index],
                    style: TextStyle(
                      fontSize: isHorizontal ? screenSize.height * 0.02: screenSize.width * 0.05,
                    ),
                  ),
                );
              },
            ),
          ),
          const Text('ユーザの予定が合うランキング'),
          const Divider(),
          SizedBox(
            width: isHorizontal ? contentSize()[0] * 1.25 : double.infinity,
            height: isHorizontal ? screenSize.height * 0.4 : screenSize.height * 0.2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: getBestTime(dataList).length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    '${index + 1}位      ${getBestTime(dataList).keys.elementAt(index)}:   ${getBestTime(dataList).values.elementAt(index)}人',
                    style: TextStyle(
                      fontSize: isHorizontal ? screenSize.height * 0.02: screenSize.width * 0.05,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> getEnteredUser(List<ContentsClass> snapshotData) {
    final List<String> enteredUser = [];
    for(ContentsClass data in snapshotData) {
      if (!enteredUser.contains(data.user_name)) {
        enteredUser.add(data.user_name);
      }
    }
    return enteredUser;
  }

  Map<String, dynamic> getBestTime(List<ContentsClass> snapshotData) {
    Map<String, dynamic> bestTimeAsMap = {};
    const List<String> dates = ['火', '水', '木', '金', '土', '日', '月'];
    const List<String> times = ['1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];
    final List<List<int>> bestTime = [];
    for(int i = 0; i < 7; i++) {
      bestTime.add(List.filled(8, 0));
    }
    for(ContentsClass data in snapshotData) {
      bestTime[data.weekday][data.time]++;
    }
    for(int i = 0; i < bestTime.length; i++) {
      for(int n = 0; n < bestTime[i].length; n++) {
        if(bestTime[i][n] != 0) {
          bestTimeAsMap.addAll({
            '${dates[i]}曜日 ${times[n + 1]}': bestTime[i][n],
          });
        }
      }
    }
    bestTimeAsMap = collection.SplayTreeMap.of(bestTimeAsMap, (a, b) {
      int compare = bestTimeAsMap[a]!.compareTo(bestTimeAsMap[b]) * -1;
      return compare == 0 ? 1 : compare;
    });
    return bestTimeAsMap;
  }

}
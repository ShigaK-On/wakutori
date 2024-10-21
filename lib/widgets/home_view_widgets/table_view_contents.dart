import 'package:flutter/material.dart';
import 'package:js/js_util.dart';
import 'package:wakutori/services/home_view_service.dart';
import 'package:wakutori/utils/contents_class.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/widgets/home_view_widgets/content_size.dart';
import 'package:wakutori/widgets/home_view_widgets/no_line_alert.dart';

import '../../utils/flutter_liff.dart';

class TableViewContents extends StatelessWidget{
  const TableViewContents({Key? key, required this.dataList}) : super(key: key);
  final List<ContentsClass> dataList;

  @override
  Widget build(BuildContext context) {
    List<List<String>> contentsState = [];
    List<List<Widget>> contentsWidget = [];
    String userName = 'hogehoge';
    getUserName().then((e) => userName);
    for(int i = 0; i < 7; i++) {
      contentsState.add(List.filled(8, '×'));
    }
    for(ContentsClass data in dataList) {
      if(data.user_name == userName) {
        contentsState[data.weekday][data.time] = '○';
      }
    }
    for(int i = 0; i < 7; i++) {
      contentsWidget.add([]);
      for(int n = 0; n < 8; n++) {
        bool isCircle = false;
        if(contentsState[i][n] == '○') {
          isCircle = true;
        }
        contentsWidget[i].add(content(contentsState[i][n], i, n, isCircle, context, userName));
      }
    }
    return Row(
      children: <Widget>[
        Column(
          children: contentsWidget[0],
        ),
        Column(
          children: contentsWidget[1],
        ),
        Column(
          children: contentsWidget[2],
        ),
        Column(
          children: contentsWidget[3],
        ),
        Column(
          children: contentsWidget[4],
        ),
        Column(
          children: contentsWidget[5],
        ),
        Column(
          children: contentsWidget[6],
        ),
      ],
    );
  }

  Future<String> getUserName() async {
    try {
      return await promiseToFuture(getProfile());
    } catch(e) {
      logger.e(e);
      return '';
      /*
      if(!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NoLineAlert();
        },
      );
       */
    }
  }

  Widget content(String text, int weekday, int time, isCircle, BuildContext context, String userName) {
    final borderColor = MediaQuery.platformBrightnessOf(context) == Brightness.light ? Colors.grey[800]! : Colors.white;
    return Container(
      width: contentSize()[0],
      height: contentSize()[1],
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: 1,
          ),
          right: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () => contentOnTapped(weekday, time, isCircle, userName),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: contentSize()[0] / 3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void contentOnTapped(int weekday, int time, isCircle, String userName) {
    if(!isCircle) {
      updateMySchedule(userName, weekday, time, true);
    } else {
      updateMySchedule(userName, weekday, time, false);
    }
  }

}
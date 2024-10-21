import 'package:flutter/material.dart';
import 'content_size.dart';

class TableViewDateHeader extends StatelessWidget{
  const TableViewDateHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: addContent(true),
    );
  }
}

class TableViewTimeHeader extends StatelessWidget {
  const TableViewTimeHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: addContent(false),
    );
  }

}

List<Widget> addContent(bool isDate) {
  const List<String> dates = ['火', '水', '木', '金', '土', '日', '月'];
  const List<String> times = ['', '1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];
  if(isDate) {
    List<Widget> dateList = [];
    for(String date in dates) {
      dateList.add(
        Container(
          color: Colors.deepPurple[100],
          width: contentSize()[0],
          height: contentSize()[1] * 0.9,
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                color: date == '土' ? Colors.blue : date == '日' ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
      );
    }
    return dateList;
  } else {
    List<Widget> timeList = [];
    for(String time in times) {
      timeList.add(
        Container(
          color: time == '' ? null : Colors.deepPurple[100],
          width: contentSize()[0] * 0.95,
          height: contentSize()[1],
          child: Center(
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    }
    return timeList;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakutori/services/all_schedule_view_service.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/utils/screen_size.dart';

class EditAllSchedule extends StatelessWidget {
  const EditAllSchedule({Key? key, required this.weekday, required this.week, required this.dayData, required this.idData}) : super(key: key);

  final int weekday;
  final int week;
  final Map<String, dynamic> dayData;
  final Map<String, dynamic> idData;

  @override
  Widget build(BuildContext context) {
    final List<String> dates = ['火', '水', '木', '金', '土', '日', '月'];
    final List<String> times = ['1限', '2限', '昼休み', '3限', '4限', '5限', '6限', '7限'];
    final List<TextEditingController> controllers = [];
    for(int i = 0; i < dayData.length; i++) {
      controllers.add(TextEditingController());
      controllers[i].text = dayData[times[i]];
    }
    return AlertDialog(
      title: Text('${dates[weekday]}曜日'),
      content: SizedBox(
        width: screenSize.width,
        height: screenSize.height * 0.5,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dayData.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${times[index]}:'),
                SizedBox(
                  width: screenSize.width * 0.5,
                  child: TextField(
                    controller: controllers[index],
                    onSubmitted: (t) {
                      if(dayData[times[index]] != '' || dayData[times[index]].isNotEmpty) {
                        if(controllers[index].text != '') {
                          updateAllSchedule(idData[times[index]], true, controllers[index].text);
                        } else {
                          updateAllSchedule(idData[times[index]], false);
                        }
                      } else {
                        insertAllSchedule(controllers[index].text, weekday, index, week);
                      }
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    decoration: InputDecoration(
                      suffix: TextButton(
                        child: const Text('更新'),
                        onPressed: () {
                          if(dayData[times[index]] != '' || dayData[times[index]].isNotEmpty) {
                            if(controllers[index].text != '') {
                              updateAllSchedule(idData[times[index]], true, controllers[index].text);
                            } else {
                              updateAllSchedule(idData[times[index]], false);
                            }
                          } else {
                            insertAllSchedule(controllers[index].text, weekday, index, week);
                          }
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            '閉じる',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}
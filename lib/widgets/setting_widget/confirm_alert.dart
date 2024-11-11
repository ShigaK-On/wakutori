import 'package:flutter/material.dart';
import 'package:wakutori/services/setting_service.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/utils/screen_size.dart';

class SettingConfirmAlert extends StatelessWidget {
  const SettingConfirmAlert({Key? key, required this.settings}) : super(key: key);

  final Map<String, dynamic> settings;

  @override
  Widget build(BuildContext context) {
    logger.i(settings);
    return AlertDialog(
      title: const Text('確認'),
      content: SizedBox(
        height: screenSize.height * 0.4,
        width: screenSize.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: settings.length,
          itemBuilder: ((BuildContext context, int index) {
            String data = settings.values.elementAt(index).toString();
            data = data == 'true' ? 'ON' : data == 'false' ? 'OFF' : data == '' ? '（無し）' : data;
            return ListTile(
              title: Text(settings.keys.elementAt(index)),
              trailing: Text(data),
            );
          }),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            setAllSchedule(
              settings.values.elementAt(0),
              settings.values.elementAt(1),
              settings.values.elementAt(2),
              settings.values.elementAt(3),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.black,
          ),
          child: const Text('確定'),
        ),
      ],
    );
  }

}
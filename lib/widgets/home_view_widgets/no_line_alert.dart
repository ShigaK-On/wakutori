import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class NoLineAlert extends StatelessWidget {
  const NoLineAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('LINEで開いてないやろ'),
      content: const Text('共有されたURLやLINE以外のブラウザでは基本使えません'),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Routemaster.of(context).pop(),
            Routemaster.of(context).push('/noLine'),
          },
          child: const Text(
            'ごめんなさい',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }


}
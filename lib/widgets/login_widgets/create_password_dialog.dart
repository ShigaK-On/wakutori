import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../services/home_view_service.dart';

class CreatePasswordDialog extends StatelessWidget {
  final String password;
  const CreatePasswordDialog({Key? key, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新規作成'),
      content: const Text('入力された合言葉はまだ使われていません\n新しく合言葉を作成しますか？'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'キャンセル',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('決定'),
          onPressed: () async {
            if(await createNewPassword(password)) {
              if(!context.mounted) return;
              Routemaster.of(context).push('/mySchedule');
            } else {
              if(!context.mounted) return;
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('エラー'),
                      content: const Text('合言葉の新規作成に失敗しました\n広報担当者に問い合わせてください'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Routemaster.of(context).pop,
                          child: const Text('了解'),
                        ),
                      ],
                    );
                  }
              );
            }
          },
        )
      ],
    );
  }
}
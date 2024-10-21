import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../../services/home_view_service.dart';
import 'create_password_dialog.dart';

void isExisted(String password, BuildContext context) async {
  if(password == '') {
    AlertDialog(
      title: const Text('未入力'),
      content: const Text('何も入力されてないぞ'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'ごめんなさい',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  } else if(await existPassword(password)) {
    if (!context.mounted) return;
    Routemaster.of(context).push('/mySchedule');
  } else {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (_) => CreatePasswordDialog(password: password),
    );
  }
}
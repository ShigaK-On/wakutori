import 'package:flutter/material.dart';
import '../../utils/screen_size.dart';
import 'exist_password.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: screenSize.width > screenSize.height ? EdgeInsets.only(
        left: (screenSize.width / 2) / 2,
        right: (screenSize.width / 2) / 2,
      ) : EdgeInsets.only(
        left: (screenSize.width * 0.2) / 2,
        right: (screenSize.width * 0.2) / 2,
      ),
      child: Center(
        child: TextFormField(
          autofocus: true,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if(value!.isEmpty) {
              return '入力してください';
            } else if(value.length < 4) {
              return '4文字以上入力してください';
            } else {
              return null;
            }
          },
          onFieldSubmitted: (t) => {
            isExisted(t, context),
          },
          decoration: InputDecoration(
            hintText: '4文字以上の合言葉を入力',
            suffix: TextButton(
              onPressed: () => {
                isExisted(controller.text, context),
              },
              child: const Text('決定'),
            ),
          ),
        ),
      ),
    );
  }

}
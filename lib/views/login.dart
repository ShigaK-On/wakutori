import 'package:flutter/material.dart';
import '../utils/screen_size.dart';
import '../widgets/login_widgets/card.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginCard(),
    );
  }
}
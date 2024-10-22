import 'package:flutter/material.dart';
import 'package:wakutori/widgets/setting_widget/app_bar.dart';
import 'package:wakutori/widgets/setting_widget/body.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SettingAppBar(),
      body: SafeArea(child: SettingBody()),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/all_schedule_widgets/app_bar.dart';
import '../widgets/all_schedule_widgets/body.dart';

class AllSchedule extends StatelessWidget {
  const AllSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AllScheduleAppBar(),
      body: SafeArea(child: AllScheduleBody()),
    );
  }

}
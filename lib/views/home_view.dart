import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakutori/services/home_view_service.dart';
import 'package:wakutori/utils/contents_class.dart';
import 'package:wakutori/widgets/home_view_widgets/result.dart';

import '../utils/screen_size.dart';
import '../widgets/home_view_widgets/table_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getStream).when(
        data: (List<ContentsClass> dataList) {
          return screenSize.width > screenSize.height ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TableView(dataList: dataList),
              Result(isHorizontal: true, dataList: dataList),
            ],
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TableView(dataList: dataList),
              Result(isHorizontal: false, dataList: dataList),
            ],
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Text('なんかエラー。管理できる人に聞いてX(\n$error');
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
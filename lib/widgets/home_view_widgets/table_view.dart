import 'package:flutter/material.dart';
import 'package:wakutori/utils/contents_class.dart';
import 'package:wakutori/widgets/home_view_widgets/table_view_contents.dart';
import '../../utils/logger.dart';
import 'table_view_header.dart';

class TableView extends StatelessWidget {
  const TableView({Key? key, required this.dataList}) : super(key: key);
  final List<ContentsClass> dataList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('自分の予定'),
          const Divider(),
          Row(
            children: [
              const TableViewTimeHeader(),
              Column(
                children: [
                  const TableViewDateHeader(),
                  TableViewContents(dataList: dataList),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
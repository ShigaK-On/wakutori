import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakutori/utils/half_mode.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/utils/screen_size.dart';
import 'package:wakutori/widgets/setting_widget/confirm_alert.dart';

final StateProvider<bool> halfModeToggle = StateProvider<bool>((ref) => isHalfMode);
final StateProvider<int> radioGroupValue = StateProvider<int>((ref) => 0);
final StateProvider<int> bandCountValue = StateProvider<int>((ref) => 1);
final StateProvider<bool> editModeToggle = StateProvider<bool>((ref) => true);
final StateProvider<String> primaryWord = StateProvider<String>((ref) => '');

class SettingBody extends ConsumerWidget {
  const SettingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        right: 5,
        left: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: const Text('枠を確定する'),
                trailing: ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SettingConfirmAlert(settings: {
                        '各バンド枠数上限': ref.read(bandCountValue) + 1,
                        '優先する単語': ref.read(primaryWord),
                        '枠の優先方法': ref.read(radioGroupValue),
                        '枠の書き換え': ref.read(editModeToggle),
                        '前後半モード（次週）': ref.read(halfModeToggle),
                      });
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('確認'),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('1バンド何枠まで'),
                trailing: DropdownButton(
                  items: const <DropdownMenuItem>[
                    DropdownMenuItem(
                      value: 0,
                      child: Text('1'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('2'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('3'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('4'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('5'),
                    ),
                  ],
                  value: ref.watch(bandCountValue),
                  onChanged: (i) {
                    ref.read(bandCountValue.notifier).state = i!;
                  },
                ),
              ),
              ListTile(
                title: const Text('優先する単語'),
                trailing: SizedBox(
                  width: screenSize.width * 0.5,
                  child: TextField(
                    onChanged: (e) {
                      ref.read(primaryWord.notifier).state = e;
                    },
                    decoration: const InputDecoration(
                      hintText: '例: 学祭, 合宿',
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                title: Text('枠の優先方法（現在: ${ref.watch(radioGroupValue) + 1}）'),
                children: <Widget>[
                  RadioListTile(
                    title: const Text('① 各バンドの1位予定を比較して、被りがなければそこが枠、被りがあれば人数の多いバンドが優先'),
                    value: 0,
                    groupValue: ref.watch(radioGroupValue),
                    onChanged: (e) {
                      ref.read(radioGroupValue.notifier).state = e!;
                    },
                  ),
                  RadioListTile(
                    title: const Text('② （同上）被りがあればバンドメンバーの合う日が少ない（ランキングが少ない）バンドが優先'),
                    value: 1,
                    groupValue: ref.watch(radioGroupValue),
                    onChanged: (e) {
                      ref.read(radioGroupValue.notifier).state = e!;
                    },
                  ),
                ],
              ),
              ListTile(
                title: const Text('確定後の追加や変更、削除'),
                trailing: CupertinoSwitch(
                  value: ref.watch(editModeToggle),
                  onChanged: (v) {
                    ref.read(editModeToggle.notifier).state = v;
                  },
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('前後半モード（次週から）'),
                trailing: CupertinoSwitch(
                  value: ref.watch(halfModeToggle),
                  onChanged: (v) {
                    ref.read(halfModeToggle.notifier).state = v;
                  },
                ),
              ),
            ],
          ),
          const Text('わからないことや不具合、改良などは22年度生・藤岡優澄（fujiokayuto1210@gmail.com）まで')
        ],
      ),
    );
  }

}
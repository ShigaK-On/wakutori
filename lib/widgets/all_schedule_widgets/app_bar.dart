import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakutori/utils/logger.dart';
import 'package:wakutori/utils/screen_size.dart';
import 'body.dart';

final StateProvider<int> menuItemIndex = StateProvider<int>((ref) => 0);

class AllScheduleAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AllScheduleAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> menuItem = ['今週', '先週', '2週間前'];
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 5,
      title: SizedBox(
        width: screenSize.width * 0.4,
        child: DropdownButton(
          isExpanded: true,
          value: menuItem[ref.watch(menuItemIndex)],
          items: <DropdownMenuItem>[
            DropdownMenuItem(
              alignment: Alignment.center,
              value: menuItem[0],
              child: Text(menuItem[0]),
            ),
            DropdownMenuItem(
              alignment: Alignment.center,
              value: menuItem[1],
              child: Text(menuItem[1]),
            ),
            DropdownMenuItem(
              alignment: Alignment.center,
              value: menuItem[2],
              child: Text(menuItem[2]),
            ),
          ],
          onChanged: (value) {
            ref.read(menuItemIndex.notifier).state = menuItem.indexOf(value);
          },
        ),
      ),
    );
  }
}
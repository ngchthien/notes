import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/themes/app_colors.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(child: navigationShell),
          CupertinoTabBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
            backgroundColor: context.scaffoldBackgroundColor.withOpacity(0.8),
            activeColor: context.primaryColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Ghi chú',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.star_fill),
                label: 'Quan Trọng',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Cài đặt',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

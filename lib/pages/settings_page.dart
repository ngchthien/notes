import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/themes/app_colors.dart';
import 'package:notes_app/core/themes/theme_settings.dart';
import 'package:notes_app/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSetting = ref.watch(themeProvider);
    final isDarkMode = themeSetting == ThemeSettings.dark;

    return CupertinoPageScaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle:
                Text('Cài đặt', style: TextStyle(color: context.mainText)),
            backgroundColor: context.scaffoldBackgroundColor.withOpacity(0.8),
            border: null,
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: context.scaffoldBackgroundColor,
              header: const Text('GIAO DIỆN'),
              children: [
                CupertinoListTile(
                  title: const Text('Chế độ tối'),
                  leading: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemIndigo,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(CupertinoIcons.moon_fill,
                        color: CupertinoColors.white, size: 20),
                  ),
                  trailing: CupertinoSwitch(
                    value: isDarkMode,
                    onChanged: (bool value) {
                      ref.read(themeProvider.notifier).setTheme(
                          value ? ThemeSettings.dark : ThemeSettings.light);
                    },
                  ),
                ),
                CupertinoListTile(
                  title: const Text('Theo hệ thống'),
                  leading: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(CupertinoIcons.device_phone_portrait,
                        color: CupertinoColors.white, size: 20),
                  ),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      themeSetting == ThemeSettings.system ? 'Đang bật' : 'Bật',
                      style: TextStyle(
                          color: themeSetting == ThemeSettings.system
                              ? CupertinoColors.systemGrey
                              : context.primaryColor),
                    ),
                    onPressed: () => ref
                        .read(themeProvider.notifier)
                        .setTheme(ThemeSettings.system),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

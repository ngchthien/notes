import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/app_router.dart';
import 'package:notes_app/core/themes/app_colors.dart';
import 'package:notes_app/core/themes/theme_settings.dart';
import 'package:notes_app/providers/theme_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeSetting = ref.watch(themeProvider);

    Brightness? brightness;
    if (themeSetting == ThemeSettings.light) brightness = Brightness.light;
    if (themeSetting == ThemeSettings.dark) brightness = Brightness.dark;

    return CupertinoApp.router(
      title: 'Notes',
      theme: AppThemes.getTheme(brightness),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/themes/theme_settings.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeSettings>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeSettings> {
  @override
  ThemeSettings build() {
    _loadTheme();
    return ThemeSettings.system;
  }

  Future<void> _loadTheme() async {
    state = await ThemeService().loadTheme();
  }

  Future<void> setTheme(ThemeSettings theme) async {
    state = theme;
    await ThemeService().saveTheme(theme);
  }
}

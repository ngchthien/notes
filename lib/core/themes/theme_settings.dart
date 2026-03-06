import 'package:shared_preferences/shared_preferences.dart';

enum ThemeSettings { system, light, dark }

class ThemeService {
  static const _key = 'theme_mode';

  Future<void> saveTheme(ThemeSettings theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, theme.name);
  }

  Future<ThemeSettings> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_key);
    return ThemeSettings.values
        .firstWhere((e) => e.name == name, orElse: () => ThemeSettings.system);
  }
}

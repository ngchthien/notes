import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  // Màu chủ đạo (Vàng iOS)
  static const CupertinoDynamicColor accentYellow =
      CupertinoColors.systemYellow;

  // Màu nền của trang (Xám nhạt chuẩn iOS ở Light mode, Đen ở Dark mode)
  static const CupertinoDynamicColor backgroundSafe =
      CupertinoColors.systemGroupedBackground;

  // Màu nền của thẻ/item (Trắng ở Light mode, Xám tối ở Dark mode)
  static const CupertinoDynamicColor cardBackground =
      CupertinoColors.secondarySystemGroupedBackground;

  // Màu chữ chính (Đen / Trắng)
  static const CupertinoDynamicColor textPrimary = CupertinoColors.label;

  // Màu chữ phụ (Mờ hơn)
  static const CupertinoDynamicColor textSecondary =
      CupertinoColors.secondaryLabel;
}

class AppThemes {
  static CupertinoThemeData getTheme(Brightness? brightness) {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: AppColors.accentYellow,
      scaffoldBackgroundColor: AppColors.backgroundSafe,
      barBackgroundColor: AppColors.backgroundSafe,
      textTheme: const CupertinoTextThemeData(
        primaryColor: AppColors.textPrimary,
      ),
    );
  }
}

extension ThemeContext on BuildContext {
  CupertinoThemeData get theme => CupertinoTheme.of(this);
  Color get primaryColor => theme.primaryColor;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  Color get cardColor => AppColors.cardBackground.resolveFrom(this);
  Color get mainText => AppColors.textPrimary.resolveFrom(this);
  Color get hintText => AppColors.textSecondary.resolveFrom(this);
}

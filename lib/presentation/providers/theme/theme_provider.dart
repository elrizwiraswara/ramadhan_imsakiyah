import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/themes/app_theme.dart';

final themeProvider = ChangeNotifierProvider((ref) {
  return _ThemeProvider();
});

class _ThemeProvider extends ChangeNotifier {
  ThemeData theme = AppTheme().init();

  void changeBrightness(bool isLight) {
    var brightness = isLight ? Brightness.light : Brightness.dark;
    theme = AppTheme().init(brightness: brightness);
    notifyListeners();
  }

  bool isLight() => theme.brightness == Brightness.light;
}

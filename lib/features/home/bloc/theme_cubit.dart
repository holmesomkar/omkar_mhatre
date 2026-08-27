import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themePrefsKey = 'portfolio_theme_mode';

/// Dark-first theme toggle, persisted across sessions via SharedPreferences
/// (localStorage on web).
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark) {
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = prefs.getBool(_themePrefsKey);
    if (isLight == true) {
      emit(ThemeMode.light);
    }
  }

  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefsKey, next == ThemeMode.light);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/services/secure_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    initialize();
  }

  final _storage = sl.get<SecureStorageHelper>();

  void initialize() async {
    final theme = await _storage.read('theme');
    if (theme != null) {
      emit(ThemeMode.values[int.parse(theme)]);
    }
  }

  void setTheme(ThemeMode theme) {
    emit(theme);
    _storage.write('theme', theme.index.toString());
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      setTheme(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
      setTheme(ThemeMode.light);
    }
  }
}

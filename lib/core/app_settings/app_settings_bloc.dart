import 'package:eqra_el_khabar/core/app_settings/app_settings_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc()
    : super(const AppSettingsState(themeMode: ThemeMode.system)) {
    on<ToggleTheme>((event, emit) {
      final newTheme =
          state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      emit(state.copyWith(themeMode: newTheme));
    });
  }
}

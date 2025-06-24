import 'package:eqra_el_khabar/core/app_settings/app_settings_event.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app_settings_state.dart';

class AppSettingsBloc extends HydratedBloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc()
    : super(const AppSettingsState(themeMode: ThemeMode.system)) {
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<AppSettingsState> emit) {
    final newTheme =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newTheme));
  }

  @override
  AppSettingsState? fromJson(Map<String, dynamic> json) {
    final mode = json['themeMode'] as String?;
    if (mode == null) return null;
    return AppSettingsState(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == mode,
        orElse: () => ThemeMode.system,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(AppSettingsState state) {
    return {'themeMode': state.themeMode.name};
  }
}

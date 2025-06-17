import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppSettingsState extends Equatable {
  final ThemeMode themeMode;

  const AppSettingsState({required this.themeMode});

  AppSettingsState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return AppSettingsState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}

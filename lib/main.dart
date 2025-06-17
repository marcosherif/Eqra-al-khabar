import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_bloc.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_state.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/localization/locale_asset_loader.dart';
import 'config/themes/themes_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize easy localization package
  await EasyLocalization.ensureInitialized();

  //initialize arabic messages for timeago package
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      assetLoader: LocaleAssetLoader(path: 'assets/langs', file: 'locale.json'),
      child: BlocProvider(
        create: (_) => AppSettingsBloc(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: state.themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: HomeScreen(),
        );
      },
    );
  }
}

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_bloc.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_state.dart';
import 'package:eqra_el_khabar/features/authentication/data/repo_impl/auth_repo_impl.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:eqra_el_khabar/features/splash_screen/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/localization/locale_asset_loader.dart';
import 'config/themes/themes_data.dart';
import 'features/authentication/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize easy localization package
  await EasyLocalization.ensureInitialized();

  //initialize arabic messages for timeago package
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  //initialize hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );


  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      assetLoader: LocaleAssetLoader(path: 'assets/langs', file: 'locale.json'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppSettingsBloc()),
          BlocProvider(
            create:
                (_) =>
                    AuthBloc(authRepo: AuthRepositoryImpl(Dio()))
                      ..add(CheckAuthStatus()),
          ),
        ],
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
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: SplashScreen(),
        );
      },
    );
  }
}

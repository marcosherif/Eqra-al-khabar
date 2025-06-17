import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/repo/news_repo.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_event.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/screen/home_screen_body.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_bloc.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_settings/app_settings_bloc.dart';
import '../../../../core/app_settings/app_settings_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String getFormattedDate() {
      final now = DateTime.now();
      final local = Localizations.localeOf(context).languageCode;
      final formatter = DateFormat('EEEE dd-MM-yy', local);
      return formatter.format(now);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Lottie.asset(
                      'assets/animations/megaphone_animation.json',
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'app_name_large'.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        Locale locale;
                        if (context.locale == Locale('en')) {
                          locale = Locale('ar');
                        } else {
                          locale = Locale('en');
                        }
                        context.setLocale(locale);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        context.read<AppSettingsBloc>().add(ToggleTheme());
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text(
              getFormattedDate(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      body: BlocProvider(
        create:
            (newContext) => HomeScreenBloc(newsRepo: NewsRepo.initiate())..add(
              GetLatestNews(
                language: context.locale.languageCode,
                typeOfNews: 'tech',
              ),
            ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest_News'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider(
                                create:
                                    (context) => SearchScreenBloc(
                                      newsRepo: NewsRepo.initiate(),
                                    ),
                                child: SearchScreen(),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            HomeScreenBody(),
          ],
        ),
      ),
    );
  }
}

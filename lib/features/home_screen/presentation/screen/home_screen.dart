import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/features/authentication/domain/entities/user.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_event.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_state.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/screen/auth_screen.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/repo/news_repo.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_event.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/screen/home_screen_body.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/widget/settings_dialog.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_bloc.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_settings/app_settings_bloc.dart';
import '../../../../core/app_settings/app_settings_event.dart';
import '../../../../core/widgets/day_night_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    String getFormattedDate() {
      final now = DateTime.now();
      final local = Localizations.localeOf(context).languageCode;
      final formatter = DateFormat('EEEE dd-MM-yy', local);
      return formatter.format(now);
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      child: Scaffold(
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
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutRequested());
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
              (newContext) =>
                  HomeScreenBloc(newsRepo: NewsRepo.initiate())..add(
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
                      icon: Image.asset(
                        'assets/images/search.png',
                        width: 24,
                        height: 24,
                      ),
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
      ),
    );
  }
}

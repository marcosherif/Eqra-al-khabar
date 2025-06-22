import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/core/common_widgets/search_loader.dart';
import 'package:eqra_el_khabar/features/authentication/domain/entities/user.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_event.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/bloc/auth_state.dart';
import 'package:eqra_el_khabar/features/authentication/presentation/screen/auth_screen.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/latest_news_bloc.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/latest_news_state.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/widget/categories_grid.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/widget/news_card.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/widget/settings_dialog.dart';
import 'package:eqra_el_khabar/features/news_by_category/data/models/mock_articles.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_bloc.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/screen/search_screen.dart';
import 'package:flip_card_swiper/flip_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../news_by_category/domain/repo/news_repo.dart';

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
                            builder:
                                (_) => SettingsDialog(screenContext: context),
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
        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest_News'.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontSize: 18),
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: BlocBuilder<LatestNewsBloc, LatestNewsState>(
                    builder: (context, state) {
                      if (state.status == LatestNewsStatus.loaded &&
                          state.latestNewsList != null) {
                        return FlipCardSwiper(
                          cardData: state.latestNewsList!,
                          cardBuilder: (context, index, visibleIndex) {
                            return NewsCard(
                              article: state.latestNewsList![index],
                            );
                          },
                          onCardCollectionAnimationComplete: (val) {},
                        );
                      } else if (state.status == LatestNewsStatus.error) {
                        return SizedBox(
                          width: double.infinity,
                          height: 350,
                          child: Text('Something_went_wrong'.tr()),
                        );
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          height: 350,
                          child: Center(
                            child: Lottie.asset(
                              'assets/animations/search_animation.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                CategoriesGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

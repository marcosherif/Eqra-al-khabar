import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/core/common_widgets/search_loader.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_bloc.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_event.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_state.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/widget/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/bottom_loader.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state.status == HomeScreenStatus.error) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text('Error'.tr()),
                  content: Text(state.error ?? 'Something_went_wrong'.tr()),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'.tr()),
                    ),
                  ],
                ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == HomeScreenStatus.loaded) {
          return Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  (state.hasReachedMax ?? false)
                      ? state.latestNewsList?.length
                      : (state.latestNewsList?.length ?? 0) + 1,
              itemBuilder: (context, index) {
                final articlesListLength = state.latestNewsList?.length ?? 0;

                if (index >= articlesListLength) {
                  if (articlesListLength < 10) {
                    return const SizedBox(height: 20);
                  } else {
                    return const BottomOfScreenLoader();
                  }
                } else {
                  final article = state.latestNewsList![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: NewsTile(article: article),
                  );
                }
              },
            ),
          );
        } else if (state.status == HomeScreenStatus.error) {
          return Center(child: Text('Something_went_wrong'.tr()));
        } else {
          return SearchLoader();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_didScrollAfterEndOfScreen) {
      context.read<HomeScreenBloc>().add(
        GetMoreNews(language: context.locale.languageCode),
      );
    }
  }

  bool get _didScrollAfterEndOfScreen {
    //check if the listener is attached to scrollable widget
    if (!_scrollController.hasClients) return false;
    //Get the maximum scroll extent
    final maxScroll = _scrollController.position.maxScrollExtent;
    //Get the current scroll position
    final currentScroll = _scrollController.offset;
    //Check if we're near the bottom
    return currentScroll >= (maxScroll * 0.9);
  }
}

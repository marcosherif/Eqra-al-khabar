import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/core/common_widgets/search_loader.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_event.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news_by_category/presentation/widget/bottom_loader.dart';
import '../../../news_by_category/presentation/widget/news_tile.dart';
import '../bloc/search_screen_bloc.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchScreenBloc, SearchScreenState>(
      listener: (context, state) {
        if (state.status == SearchScreenStatus.error) {
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
        if (state.status == SearchScreenStatus.loaded) {
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
                    child: NewsTile(
                      article: article,
                    ),
                  );
                }
              },
            ),
          );
        } else if (state.status == SearchScreenStatus.initial) {
          return Center(child: Text('Start_Search'.tr()));
        } else if (state.status == SearchScreenStatus.error) {
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
      context.read<SearchScreenBloc>().add(
        GetMoreNewsBySearchString(language: context.locale.languageCode),
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

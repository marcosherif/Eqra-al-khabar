import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/features/news_by_category/presentation/screen/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repo/news_repo.dart';
import '../bloc/news_by_category_screen_bloc.dart';
import '../bloc/news_by_category_screen_event.dart';

class NewsByCategoryScreen extends StatelessWidget {
  const NewsByCategoryScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          context.locale == Locale('en')
              ? category.toUpperCase()
              : category.tr(),
        ),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider(
        create:
            (newContext) => NewsByCategoryScreenBloc(newsRepo: NewsRepo.initiate())..add(
              GetLatestNews(
                language: context.locale.languageCode,
                typeOfNews: category,
              ),
            ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Latest_News'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
              ),
            ),
            HomeScreenBody(),
          ],
        ),
      ),
    );
  }
}

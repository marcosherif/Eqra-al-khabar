import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_bloc.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_event.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/screen/search_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(), // back arrow
        title: Text('Search'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                context.read<SearchScreenBloc>().add(
                  SearchLatestNewsBySearchString(
                    language: context.locale.languageCode,
                    searchString: text,
                  ),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search'.tr(),
                prefixIcon: Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
            const SizedBox(height: 16),
            SearchScreenBody(),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleAssetLoader extends AssetLoader {
  final String path;
  final String file;

  const LocaleAssetLoader({required this.path, required this.file});

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    final String jsonString = await rootBundle.loadString('$path/$file');
    final Map<String, dynamic> fullMap = json.decode(jsonString);

    final Map<String, dynamic> singleLanguageMap = {};
    fullMap.forEach((key, value) {
      if (value is Map && value.containsKey(locale.languageCode)) {
        singleLanguageMap[key] = value[locale.languageCode];
      }
    });

    return singleLanguageMap;
  }


}

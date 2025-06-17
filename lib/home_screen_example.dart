import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_bloc.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenExample extends StatelessWidget {
  const HomeScreenExample({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("hello".tr()))),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isDark ? 'Dark Theme' : 'Light Theme',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => context.read<AppSettingsBloc>().add(ToggleTheme()),
              child: Text('Toggle Theme'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Locale locale;
                if (context.locale == Locale('en')) {
                  locale = Locale('ar');
                } else {
                  locale = Locale('en');
                }
                context.setLocale(locale);
              },
              child: Text('Toggle Language'),
            ),
          ],
        ),
      ),
    );
  }
}

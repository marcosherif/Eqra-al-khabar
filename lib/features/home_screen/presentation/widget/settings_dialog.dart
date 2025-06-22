import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_settings/app_settings_bloc.dart';
import '../../../../core/app_settings/app_settings_event.dart';
import '../../../../core/common_widgets/day_night_toggle.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Settings'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'application_theme'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    DayNightSwitchLocal(
                      value:
                          context.read<AppSettingsBloc>().state.themeMode ==
                          ThemeMode.dark,
                      scale: 0.4,
                      onChanged: (val) {
                        setState(() {
                          context.read<AppSettingsBloc>().add(ToggleTheme());
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'application_language'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        Locale locale;
                        if (context.locale == Locale('en')) {
                          locale = Locale('ar');
                        } else {
                          locale = Locale('en');
                        }
                        context.setLocale(locale);
                      },
                      child: Text(
                        context.locale == Locale('en') ? 'ع' : 'Eng',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

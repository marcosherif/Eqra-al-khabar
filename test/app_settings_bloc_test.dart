import 'package:eqra_el_khabar/core/app_settings/app_settings_event.dart';
import 'package:eqra_el_khabar/core/app_settings/app_settings_state.dart';
import 'package:test/test.dart';

import 'package:eqra_el_khabar/core/app_settings/app_settings_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import 'helpers/mock_storage.dart';

void main() {
  //initiate hydrated bloc with mock storage
  initHydratedBloc();

  group(AppSettingsBloc, () {
    late AppSettingsBloc appSettingsBloc;

    setUp(() {
      appSettingsBloc = AppSettingsBloc();
    });

    tearDown(() {
      appSettingsBloc.close();
    });

    test('toJson -> from Json', () {
      expect(
        appSettingsBloc.fromJson(appSettingsBloc.toJson(appSettingsBloc.state)),
        appSettingsBloc.state,
      );
    });

    blocTest(
      'toggle theme',
      build: () => appSettingsBloc,
      act: (bloc) => bloc.add(ToggleTheme()),
      expect: () => [isA<AppSettingsState>()],
    );
  });
}

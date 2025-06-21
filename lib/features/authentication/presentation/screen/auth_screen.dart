import 'package:easy_localization/easy_localization.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_settings/app_settings_bloc.dart';
import '../../../../core/app_settings/app_settings_event.dart';
import '../../../../core/widgets/day_night_toggle.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Text('login').tr(),
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
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated && state.user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(user: state.user!)),
            );
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'login failed'.tr())),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Lottie.asset(
                    'assets/animations/login_animation.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 40),
                  TextField(
                    onChanged: (text) {
                      context.read<AuthBloc>().add(ClearError());
                    },
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'username'.tr(),
                      prefixIcon: Icon(Icons.account_circle_rounded),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    onChanged: (text) {
                      context.read<AuthBloc>().add(ClearError());
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'password'.tr(),
                      prefixIcon: Icon(Icons.password),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                    ),
                  ),
                  if (state.status == AuthStatus.error &&
                      state.error == 'Invalid credentials') ...[
                    const SizedBox(height: 4),
                    Text(
                      'Invalid_Credentials'.tr(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 4),
                  ],
                  const SizedBox(height: 20),
                  if (state.status == AuthStatus.loading)
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )
                  else
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            LoginRequested(
                              _usernameController.text.trim(),
                              _passwordController.text.trim(),
                            ),
                          );
                        },
                        child: Text('login'.tr()),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repo/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc({required this.authRepo})
    : super(AuthState(status: AuthStatus.initial)) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ClearError>(_onClearError);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final loginResponse = await authRepo.login(event.username, event.password);
    if (loginResponse.statusCode == '200' || loginResponse.payload != null) {
      final User user = loginResponse.payload!;
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: loginResponse.statusMessage,
        ),
      );
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final String? accessToken = preferences.getString('access_token');
    final String? refreshToken = preferences.getString('refresh_token');

    if (accessToken != null &&
        !await authRepo.isAccessTokenExpired(accessToken)) {
      final user = await authRepo.getCachedUser();
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      return;
    } else if (refreshToken != null &&
        !await authRepo.isAccessTokenExpired(refreshToken)) {
      final String? newAccessToken = await authRepo.refreshAccessToken(
        refreshToken,
      );
      if (newAccessToken != null) {
        preferences.setString('access_token', newAccessToken);
        final User? user = await authRepo.getCachedUser();
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        return;
      }
    } else {
      await authRepo.logout();
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onClearError(ClearError event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.authenticated, error: null));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepo.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }
}

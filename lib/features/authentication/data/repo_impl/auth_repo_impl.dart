import 'package:dio/dio.dart';
import 'package:eqra_el_khabar/core/network/logger_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;

  AuthRepositoryImpl(this.dio) {
    dio.interceptors.add(LoggerInterceptor());
  }

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _usernameKey = 'username';
  static const _imageKey = 'image';

  @override
  Future<User> login(String username, String password) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {'username': username, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final user = UserModel.fromJson(response.data);

      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(_accessTokenKey, user.accessToken);
      await preferences.setString(_refreshTokenKey, user.refreshToken);
      await preferences.setString(_usernameKey, user.username);
      await preferences.setString(_imageKey, user.image ?? '');

      return user;
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception('Login failed: $msg');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(_accessTokenKey);
  }

  @override
  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_accessTokenKey);
    await preferences.remove(_refreshTokenKey);
    await preferences.remove(_usernameKey);
    await preferences.remove(_imageKey);
  }

  @override
  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_accessTokenKey);
  }
}

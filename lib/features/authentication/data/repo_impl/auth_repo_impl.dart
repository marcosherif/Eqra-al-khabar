import 'package:dio/dio.dart';
import 'package:eqra_el_khabar/core/network/logger_interceptor.dart';
import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
  static const _emailKey = 'email';
  static const _firstNameKey = 'firstName';
  static const _lastNameKey = 'lastName';
  static const _genderKey = 'gender';
  static const _idKey = 'id';

  @override
  Future<NetworkResponse<User>> login(String username, String password) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {'username': username, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final User user = UserModel.fromJson(response.data);

      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(_accessTokenKey, user.accessToken);
      await preferences.setString(_refreshTokenKey, user.refreshToken);
      await preferences.setString(_usernameKey, user.username);
      await preferences.setString(_emailKey, user.email ?? '');
      await preferences.setString(_imageKey, user.image ?? '');
      await preferences.setString(_firstNameKey, user.firstName ?? '');
      await preferences.setString(_lastNameKey, user.lastName ?? '');
      await preferences.setString(_genderKey, user.gender ?? '');
      await preferences.setInt(_idKey, user.id);

      return NetworkResponse(payload: user, statusCode: '200', success: true);
    } on DioException catch (e) {
      final String msg = e.response?.data['message'] ?? e.message;
      final String statusCode = (e.response?.statusCode ?? 400).toString();

      return NetworkResponse.fromError(msg, statusCode);
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
    await preferences.clear();
  }

  @override
  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_accessTokenKey);
  }

  @override
  Future<User?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(_accessTokenKey);
    final username = prefs.getString(_usernameKey);
    final email = prefs.getString(_emailKey);
    final firstName = prefs.getString(_firstNameKey);
    final lastName = prefs.getString(_lastNameKey);
    final gender = prefs.getString(_genderKey);
    final image = prefs.getString(_imageKey);
    final refreshToken = prefs.getString(_refreshTokenKey);
    final id = prefs.getInt(_idKey);

    if (token != null && username != null) {
      return User(
        accessToken: token,
        refreshToken: refreshToken ?? '',
        id: id ?? 0,
        username: username,
        email: email ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        gender: gender ?? '',
        image: image ?? '',
      );
    } else {
      return null;
    }
  }

  @override
  Future<bool> isAccessTokenExpired(String token) async {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return true;
    }
  }

  @override
  Future<String?> refreshAccessToken(String refreshToken) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/auth/refresh',
        data: {'refreshToken': refreshToken, 'expiresInMins': 10},
      );

      final newAccessToken = response.data['accessToken'];
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('access_token', newAccessToken);

      return newAccessToken;
    } catch (e) {
      return null;
    }
  }
}

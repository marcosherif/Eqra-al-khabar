import 'package:eqra_el_khabar/core/network/network_response.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<NetworkResponse<User>> login(String username, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<String?> getToken();
  Future<User?> getCachedUser();
  Future<bool> isAccessTokenExpired(String token);
  Future<String?> refreshAccessToken(String refreshToken);
}

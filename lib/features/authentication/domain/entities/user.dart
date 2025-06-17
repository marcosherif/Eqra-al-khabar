class User {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;

  User({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });
}

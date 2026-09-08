class Auth {
  final String token;
  final int expiresIn;
  final String tokenType;
  final DateTime expiresAt;

  Auth({
    required this.token,
    required this.expiresIn,
    required this.tokenType,
    required this.expiresAt,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    final expiresIn = json['expires_in'] as int;
    return Auth(
      token: json['access_token'],
      expiresIn: expiresIn,
      tokenType: json['token_type'],
      expiresAt: DateTime.now().add(Duration(seconds: expiresIn - 60)),
    );
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

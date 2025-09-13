class UserModel {
  final String token;
  final String? error;

  UserModel({
    required this.token,
    this.error,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      if (error != null) 'error': error,
    };
  }

  /// helper method
  bool get isValid => token.isNotEmpty;
}

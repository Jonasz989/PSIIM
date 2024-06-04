class PostLogin {
  final String accessToken;
  final String tokenType;

  PostLogin({
    required this.accessToken,
    required this.tokenType,
  });

  factory PostLogin.fromJson(Map<String, dynamic> json) => PostLogin(
        accessToken: json['accessToken'],
        tokenType: json['tokenType'],
      );
}

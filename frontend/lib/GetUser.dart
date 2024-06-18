class GetUser {
  final int id;
  final List<dynamic> roles;
  final String name;
  final String email;

  GetUser({
    required this.id,
    required this.roles,
    required this.name,
    required this.email,
  });

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
        id: json['id'],
        roles: json['roles'],
        name: json['name'],
        email: json['email'],
      );
}

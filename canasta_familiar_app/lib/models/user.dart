import 'role.dart';

class User {
  final int id;
  final String name;
  final String email;
  final List<Role> roles;
  final String? emailVerifiedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.roles = const [],
    this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      emailVerifiedAt: json['email_verified_at'] as String?,
      roles: (json['roles'] as List<dynamic>? ?? [])
          .map((r) => Role.fromJson(r as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'roles': roles.map((r) => r.toJson()).toList(),
      };

  bool get isAdmin => roles.any((r) => r.slug == 'admin');

  bool hasRole(String slug) => roles.any((r) => r.slug == slug);
}
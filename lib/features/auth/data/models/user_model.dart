class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final UserRole role; // user OR delivery

  const UserModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role.name,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: _roleFromString(json['role']),
    );
  }
  static UserRole _roleFromString(String? role) {
    switch (role) {
      case 'delivery':
        return UserRole.delivery;
      case 'user':
      default:
        return UserRole.user;
    }
  }
}

enum UserRole { user, delivery }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final firstName = (json['firstName'] ?? json['first_name'] ?? '').toString();
    final lastName = (json['lastName'] ?? json['last_name'] ?? '').toString();
    final fullName = '$firstName $lastName'.trim();

    return UserModel(
      id: (json['id'] ?? json['userId'] ?? '').toString(),
      name: (json['name'] ?? fullName).toString(),
      email: (json['email'] ?? '').toString(),
      token: (json['token'] ?? json['accessToken'] ?? json['access_token'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}

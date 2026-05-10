/// Matches [CurrentUserInfoResponse] from `/api/auth/me`.
class CurrentUserModel {
  final String userId;
  final String email;
  final String fullName;
  final String? profilePicture;

  const CurrentUserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    this.profilePicture,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      userId: (json['userId'] ?? json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['name'] ?? '').toString(),
      profilePicture: json['profilePicture'] as String?,
    );
  }
}

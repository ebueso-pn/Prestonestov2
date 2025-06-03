class UserInfo {
  final String id;
  final String email;
  final bool applicationSent;
  final String applicationStatus;

  UserInfo({
    required this.id,
    required this.email,
    required this.applicationSent,
    required this.applicationStatus,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      email: json['email'] as String,
      applicationSent: json['applicationSent'] as bool,
      applicationStatus: json['applicationStatus'] as String,
    );
  }
}
class UserInfo {
  final String id_number;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final bool hasFinancials;
  final bool hasApplication;
  final bool hasActiveLoans;
  final bool hasKYC;

  UserInfo({
    required this.id_number,
    required this.email,
    required this.hasFinancials,
    required this.hasApplication,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.hasActiveLoans = false,
    this.hasKYC = false,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id_number: json['user']['id_number'] as String,
      email: json['user']['email'] as String,
      hasFinancials: json['financials'] != null,
      hasApplication: json['application'] != null,
      hasKYC: false, // Assuming KYC is not part of the JSON response
    );
  }
}

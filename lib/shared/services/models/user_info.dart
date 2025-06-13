class UserInfo {
  final String idNumber;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final bool hasFinancials;
  final bool hasApplication;
  final bool hasActiveLoans;
  final bool hasKYC;
  final bool isKYCValid;
  final bool isAppParamsMissing;
  final bool hasLocation;
  final bool hasLocationPoint;
  final bool hasIncomeFileUploaded;
  final bool hasBankFileUploaded;
  final Map<String, dynamic>? location;
  final Map<String, dynamic>? application;

  const UserInfo({
    required this.idNumber,
    required this.email,
    required this.hasFinancials,
    required this.hasApplication,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.hasActiveLoans = false,
    this.hasKYC = false,
    this.isKYCValid = false,
    this.isAppParamsMissing = true,
    this.hasLocation = false,
    this.hasLocationPoint = false,
    this.hasIncomeFileUploaded = false,
    this.hasBankFileUploaded = false,
    this.location,
    this.application,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final application = json['application'] as Map<String, dynamic>?;
    final kyc = json['kyc'] as Map<String, dynamic>?;
    final location = json['location'] as Map<String, dynamic>?;
    final files = json['files'] as Map<String, dynamic>?;

    return UserInfo(
      idNumber: user['id_number'] as String? ?? '',
      email: user['email'] as String? ?? '',
      firstName: user['first_name'] as String?,
      lastName: user['last_name'] as String?,
      phoneNumber: user['phone_number'] as String?,
      hasFinancials: json['financials'] != null,
      hasApplication: application != null,
      hasActiveLoans: (json['active_loans'] as bool?) ?? false,
      hasKYC: kyc?['is_shufti_valid'] != null,
      isKYCValid: (kyc?['is_shufti_valid'] == true) &&
          (kyc?['is_equifax_valid'] == true),
      isAppParamsMissing: application == null ||
          application['amount'] == null ||
          application['months'] == null ||
          application['installment'] == null,
      hasLocation: location != null,
      hasLocationPoint:
          location?['latitude'] != null && location?['longitude'] != null,
      hasIncomeFileUploaded: (files != null &&
          files['income_file_uploaded'] == true),
      hasBankFileUploaded: (files != null &&
          files['bank_file_uploaded'] == true),
      location: location,
      application: application,
    );
  }
}

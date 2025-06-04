class IncomeInfoSchemaRequest {
  final String firstName;
  final String lastName;
  final double monthlyAverageIncome;
  final List<MainIncomeSourceEnum> mainIncomeSource;
  final bool ownBankAccount;
  final bool hasGrantedCreditHistory;

  IncomeInfoSchemaRequest({
    required this.firstName,
    required this.lastName,
    required this.monthlyAverageIncome,
    required this.mainIncomeSource,
    required this.ownBankAccount,
    required this.hasGrantedCreditHistory,
  });

  factory IncomeInfoSchemaRequest.fromJson(Map<String, dynamic> json) {
    return IncomeInfoSchemaRequest(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      monthlyAverageIncome: (json['monthly_average_income'] as num).toDouble(),
      mainIncomeSource: (json['main_income_source'] as List<dynamic>)
          .map((e) => MainIncomeSourceEnumExtension.fromString(e as String))
          .toList(),
      ownBankAccount: json['own_bank_account'] as bool,
      hasGrantedCreditHistory: json['has_granted_credit_history'] as bool,
    );
  }

  toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'monthly_average_income': monthlyAverageIncome,
      'main_income_source': mainIncomeSource.map((e) => e.toJson()).toList(),
      'own_bank_account': ownBankAccount,
      'has_granted_credit_history': hasGrantedCreditHistory,
    };
  }
}

enum MainIncomeSourceEnum { salary, ownBusiness, remittances }

extension MainIncomeSourceEnumExtension on MainIncomeSourceEnum {
  static MainIncomeSourceEnum fromString(String value) {
    switch (value) {
      case 'salary':
        return MainIncomeSourceEnum.salary;
      case 'own_business':
        return MainIncomeSourceEnum.ownBusiness;
      case 'remittances':
        return MainIncomeSourceEnum.remittances;
      default:
        throw ArgumentError('Unknown MainIncomeSourceEnum value: $value');
    }
  }

  String toJson() {
    switch (this) {
      case MainIncomeSourceEnum.salary:
        return 'salary';
      case MainIncomeSourceEnum.ownBusiness:
        return 'own_business';
      case MainIncomeSourceEnum.remittances:
        return 'remittances';
    }
  }
}

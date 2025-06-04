import 'package:flutter/material.dart';

import '/shared/services/user_api.dart';
import '/shared/services/models/user_financials_info.dart';

class BasicInformationService {
  static Future<bool> processApplication({
    required TextEditingController ingresosController,
    required GlobalKey<FormState> formKey,
    required Map<String, bool> earningTypes,
    required void Function(bool) setIngresosError,
    required void Function(String?) setEarningTypeError,
    required void Function(String?) setBankAccountError,
    required void Function(String?) setCreditHistoryError,
    required bool? hasBankAccount,
    required bool hasGrantedCreditHistory,
  }) async {
    // Validate ingresosController
    final ingresosText = ingresosController.text;
    bool ingresosValid = ingresosText.isNotEmpty && ingresosText.length > 3;
    bool ingresosParseError = false;

    if (ingresosValid) {
      try {
        double.parse(ingresosText);
        setIngresosError(false);
      } catch (e) {
        setIngresosError(true);
        ingresosParseError = true;
      }
      if (!ingresosParseError) {
        setIngresosError(false);
      }
    } else {
      setIngresosError(true);
    }

    // Validate form
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return false;
    }
    // Validate earning types
    // Map Spanish earning types to accepted English values
    final Map<String, String> earningTypesMap = {
      'Salario': 'salary',
      'Negocio propio': 'own_business',
      'Otros': 'others',
      'Remesas': 'remittances',
    };

    // Filter selected earning types and map to English
    final selectedEarningTypes = earningTypes.entries
        .where((e) => e.value)
        .map((e) => earningTypesMap[e.key])
        .where((e) => e != null)
        .cast<String>()
        .toList();

    if (selectedEarningTypes.isEmpty) {
      setEarningTypeError('Debes seleccionar al menos una fuente de ingresos');
      return false;
    } else {
      setEarningTypeError(null);
    }

    // Validate bank account selection
    if (hasBankAccount == null) {
      setBankAccountError('Debes seleccionar una opcion para continuar');
      return false;
    } else {
      setBankAccountError(null);
    }

    // Validate credit history authorization
    if (!hasGrantedCreditHistory) {
      setCreditHistoryError(
        'Debes autorizar a Prestonesto a revisar tu historial crediticio para continuar',
      );
      return false;
    } else {
      setCreditHistoryError(null);
    }

    try {
      final userApi = await UserApi.create();
      // TODO: Replace with actual user first and last name from your context or model
      final incomeInfo = IncomeInfoSchemaRequest(
        firstName: '', // Provide actual value
        lastName: '', // Provide actual value
        monthlyAverageIncome: double.parse(ingresosController.text),
        mainIncomeSource: selectedEarningTypes
            .map((e) => MainIncomeSourceEnumExtension.fromString(e))
            .toList(),
        ownBankAccount: hasBankAccount,
        hasGrantedCreditHistory: hasGrantedCreditHistory,
      );
      final user = await userApi.updateFinancials(incomeInfo);
      return true;
    } catch (e) {
      print('Error fetching user info after login: $e');
      return false;
    }
    return true;
  }
}

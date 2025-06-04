import 'package:flutter/material.dart';

import '/shared/services/user_api.dart';
import '/shared/services/models/user_financials_info.dart';
import 'model.dart';

class BasicInformationService {
  static Future<bool> processApplication({
    required BasicInformationModel model,
    required TextEditingController? ingresosController,
    required Map<String, bool> earningTypes,
    required bool? hasBankAccount,
    required void Function(bool) setIngresosError,
    required void Function(String?) setEarningTypeError,
    required void Function(String?) setBankAccountError,
    required void Function(String?) setCreditHistoryError,
    required bool hasGrantedCreditHistory,
  }) async {
    // Validate ingresosController (use the one passed from view.dart)
    final ingresosText = ingresosController?.text ?? '';
    bool ingresosValid = ingresosText.isNotEmpty && ingresosText.length > 3;
    bool ingresosParseError = false;

    if (ingresosValid) {
      try {
        double.parse(ingresosText.replaceAll(',', ''));
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
    if (model.formKey.currentState == null ||
        !model.formKey.currentState!.validate()) {
      return false;
    }

    final Map<String, String> earningTypeTranslations = {
      "salario": "salary",
      "negocio propio": "own_business",
      "otros": "others",
      "remesas": "remittances",
    };
    final selectedEarningTypes = earningTypes.entries
        .where((entry) => entry.value)
        .map((entry) =>
            earningTypeTranslations[entry.key.toLowerCase()] ??
            entry.key.toLowerCase())
        .toList();
    if (selectedEarningTypes.isEmpty) {
      setEarningTypeError('Debes seleccionar al menos una fuente de ingresos');
      return false;
    } else {
      setEarningTypeError(null);
    }

    // Validate bank account selection
    if (model.ownBankAccount == null || hasBankAccount == null) {
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
      final incomeInfo = IncomeInfoSchemaRequest(
        firstName: model.nombresController?.text ?? '',
        lastName: model.apellidosController?.text ?? '',
        monthlyAverageIncome: double.tryParse(
                ingresosController?.text.replaceAll(',', '') ?? '') ??
            0,
        mainIncomeSource: selectedEarningTypes
            .map((e) => MainIncomeSourceEnumExtension.fromString(e))
            .toList(),
        ownBankAccount: hasBankAccount,
        hasGrantedCreditHistory: hasGrantedCreditHistory,
      );
      return await userApi.updateFinancials(incomeInfo);
    } catch (e) {
      print('Error fetching user info after login: $e');
      return false;
    }
  }
}

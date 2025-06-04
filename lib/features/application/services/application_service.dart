import 'package:flutter/material.dart';

class ApplicationService {
  /// Handles the application process logic previously in the onPressed callback.
  /// Returns true if navigation should proceed, false otherwise.
  /// Sets error messages and state as needed via the provided callbacks.
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
    bool allFalse = earningTypes.values.every((v) => !v);
    if (allFalse) {
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

    // All validations passed
    return true;
  }
}

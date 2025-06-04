import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_model.dart';

enum MainIncomeSourceEnum {
  salary,
  own_business,
  remittances,
  other,
}

class BasicInformationModel extends FlutterFlowModel {
  // Focus node to unfocus text fields
  final unfocusNode = FocusNode();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Controllers & validators for form fields
  TextEditingController? nombresController;
  String? Function(BuildContext, String?)? nombresControllerValidator;
  String? _nombresControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿Cuál es tu nombre(s)?';
    }
    return null;
  }

  TextEditingController? apellidosController;
  String? Function(BuildContext, String?)? apellidosControllerValidator;
  String? _apellidosControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿Cuáles son tus apellidos?';
    }
    return null;
  }

  TextEditingController? dniController;
  final dniMask = MaskTextInputFormatter(mask: '####-####-#####');
  String? Function(BuildContext, String?)? dniControllerValidator;
  String? _dniControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Necesitamos el número de tu DNI';
    }
    if (val.length < 15) {
      return '¡Te hacen falta un par de números!';
    }
    if (val.length > 15) {
      return '¡Muchos números!';
    }
    return null;
  }

  TextEditingController? ingresosController;
  String? Function(BuildContext, String?)? ingresosControllerValidator;
  String? _ingresosControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor estima tus ingresos mensuales';
    }
    final parsed = double.tryParse(val.replaceAll(',', ''));
    if (parsed == null) {
      return 'Ingresa un número válido';
    }
    if (parsed < 0) {
      return 'No puede ser negativo';
    }
    if (val.length < 4) {
      return 'Mínimo de cuatro dígitos';
    }
    if (val.length > 6) {
      return 'Máximo de seis dígitos';
    }
    return null;
  }

  // New fields for main_income_source and own_bank_account
  List<MainIncomeSourceEnum> mainIncomeSource = [];
  void toggleMainIncomeSource(MainIncomeSourceEnum source) {
    if (mainIncomeSource.contains(source)) {
      mainIncomeSource.remove(source);
    } else {
      mainIncomeSource.add(source);
    }
  }

  bool ownBankAccount = false;
  void setOwnBankAccount(bool value) {
    ownBankAccount = value;
  }

  // Initialization and disposal
  void initState(BuildContext context) {
    nombresControllerValidator = _nombresControllerValidator;
    apellidosControllerValidator = _apellidosControllerValidator;
    dniControllerValidator = _dniControllerValidator;
    ingresosControllerValidator = _ingresosControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    nombresController?.dispose();
    apellidosController?.dispose();
    dniController?.dispose();
    ingresosController?.dispose();
  }

  // Helper to get the float value for monthly_average_income
  double? get monthlyAverageIncome {
    if (ingresosController?.text == null) return null;
    return double.tryParse(ingresosController!.text.replaceAll(',', ''));
  }
}

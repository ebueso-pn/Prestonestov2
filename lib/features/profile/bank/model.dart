import 'package:flutter/material.dart';
import '/flutter_flow/form_field_controller.dart';

class ProfileBankAccountModel {
  // Local state fields for this page.
  bool? bankaccount = false;

  // State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController = FormFieldController<String>(null);
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  // State field(s) for Cuenta widget.
  TextEditingController? cuentaController = TextEditingController();
  String? Function(BuildContext, String?)? cuentaControllerValidator;
  // State field(s) for Cuenta_Confirmar widget.
  TextEditingController? cuentaConfirmarController = TextEditingController();
  String? Function(BuildContext, String?)? cuentaConfirmarControllerValidator;

  ProfileBankAccountModel() {
    cuentaControllerValidator = _cuentaControllerValidator;
    cuentaConfirmarControllerValidator = _cuentaConfirmarControllerValidator;
  }

  String? _cuentaControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Necesitamos tu numero de cuenta';
    }
    if (val.length < 8) {
      return 'Requires at least 8 characters.';
    }
    if (val.length > 12) {
      return 'Maximum 12 characters allowed, currently ${val.length}.';
    }
    return null;
  }

  String? _cuentaConfirmarControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Necesitamos tu numero de cuenta';
    }
    if (val.length < 8) {
      return 'Requires at least 8 characters.';
    }
    if (val.length > 12) {
      return 'Maximum 12 characters allowed, currently ${val.length}.';
    }
    return null;
  }

  void dispose() {
    unfocusNode.dispose();
    cuentaController?.dispose();
    cuentaConfirmarController?.dispose();
    dropDownValueController?.dispose();
  }
}

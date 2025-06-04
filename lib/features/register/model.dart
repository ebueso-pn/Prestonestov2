import '/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmailCreateAccountModel extends FlutterFlowModel {
  /// State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  // Email address
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;

  // Phone number
  TextEditingController? phoneNumberController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '+504 ####-####');
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;

  // Password
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;

  // Confirm password
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;

  // DNI
  TextEditingController? dniController;
  final dniMask = MaskTextInputFormatter(mask: '####-####-#####');
  String? Function(BuildContext, String?)? dniControllerValidator = (context, val) {
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
  };

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
    confirmPasswordVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressController?.dispose();
    phoneNumberController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    dniController?.dispose();
  }
}

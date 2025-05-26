import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EmailCreateAccountModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for phoneNumber widget.
  TextEditingController? phoneNumberController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '+504 ####-####');
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  // State field(s) for password widget.
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for confirmPassword widget.
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;
  // State field(s) for emailAddress widget.
  TextEditingController? dniController;
  final dniMask = MaskTextInputFormatter(mask: '####-####-#####');
  String? Function(BuildContext, String?)? dniControllerValidator;
  String? _dniControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Necesitamos el numero de tu DNI';
    }

    if (val.length < 15) {
      return '¡Te hacen falta un par de numeros!';
    }
    if (val.length > 15) {
      return '¡Muchos numeros!';
    }

    return null;
  }

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

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

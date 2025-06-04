import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class EmailLoginModel extends FlutterFlowModel {
  final unfocusNode = FocusNode();
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  TextEditingController? passwordLoginController;
  late bool passwordLoginVisibility;
  String? Function(BuildContext, String?)? passwordLoginControllerValidator;

  void initState(BuildContext context) {
    passwordLoginVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressController?.dispose();
    passwordLoginController?.dispose();
  }
}

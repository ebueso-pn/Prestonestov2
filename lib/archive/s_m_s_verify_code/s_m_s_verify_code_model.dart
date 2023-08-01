import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SMSVerifyCodeModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for SMSCode widget.
  TextEditingController? sMSCode;
  String? Function(BuildContext, String?)? sMSCodeValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    sMSCode = TextEditingController();
  }

  void dispose() {
    unfocusNode.dispose();
    sMSCode?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

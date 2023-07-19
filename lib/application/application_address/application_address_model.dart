import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ApplicationAddressModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for AddressField_Casa_Calle widget.
  TextEditingController? addressFieldCasaCalleController;
  String? Function(BuildContext, String?)?
      addressFieldCasaCalleControllerValidator;
  String? _addressFieldCasaCalleControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿En que calle queda tu casa? ';
    }

    return null;
  }

  // State field(s) for AddressField_Descripcion widget.
  TextEditingController? addressFieldDescripcionController;
  String? Function(BuildContext, String?)?
      addressFieldDescripcionControllerValidator;
  // State field(s) for AddressField_Colonia widget.
  TextEditingController? addressFieldColoniaController;
  String? Function(BuildContext, String?)?
      addressFieldColoniaControllerValidator;
  String? _addressFieldColoniaControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿En que colonia vivis?';
    }

    return null;
  }

  // State field(s) for AddressField_Ciudad widget.
  TextEditingController? addressFieldCiudadController;
  String? Function(BuildContext, String?)?
      addressFieldCiudadControllerValidator;
  String? _addressFieldCiudadControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿En que ciudad vivis?';
    }

    return null;
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    addressFieldCasaCalleControllerValidator =
        _addressFieldCasaCalleControllerValidator;
    addressFieldColoniaControllerValidator =
        _addressFieldColoniaControllerValidator;
    addressFieldCiudadControllerValidator =
        _addressFieldCiudadControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    addressFieldCasaCalleController?.dispose();
    addressFieldDescripcionController?.dispose();
    addressFieldColoniaController?.dispose();
    addressFieldCiudadController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

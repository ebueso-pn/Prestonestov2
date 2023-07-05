import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ApplicationNameModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for Nombres widget.
  TextEditingController? nombresController;
  String? Function(BuildContext, String?)? nombresControllerValidator;
  String? _nombresControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿Cual es tu nombre(s)?';
    }

    return null;
  }

  // State field(s) for Apellidos widget.
  TextEditingController? apellidosController;
  String? Function(BuildContext, String?)? apellidosControllerValidator;
  String? _apellidosControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '¿Cuales son tus apellidos?';
    }

    return null;
  }

  // State field(s) for DNI widget.
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

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    nombresControllerValidator = _nombresControllerValidator;
    apellidosControllerValidator = _apellidosControllerValidator;
    dniControllerValidator = _dniControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    nombresController?.dispose();
    apellidosController?.dispose();
    dniController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String? get radioButtonValue => radioButtonValueController?.value;
}

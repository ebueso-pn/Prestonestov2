
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';


class ApplicationAddressModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
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

  // State field(s) for Dpto_DropDown widget.
  String? dptoDropDownValue;
  FormFieldController<String>? dptoDropDownValueController;

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

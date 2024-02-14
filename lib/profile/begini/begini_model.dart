import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'begini_widget.dart' show BeginiWidget;
import 'package:flutter/material.dart';

class BeginiModel extends FlutterFlowModel<BeginiWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Begini Token)] action in Button widget.
  ApiCallResponse? apiResultwum;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

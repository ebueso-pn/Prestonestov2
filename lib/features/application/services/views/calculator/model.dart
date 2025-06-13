
import '/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';


class ApplicationLoanCalculatorModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Loan_Amt widget.
  double? loanAmtValue;
  // State field(s) for Loan_Term widget.
  double? loanTermValue;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  // ApplicationRecord? createdAppVar;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

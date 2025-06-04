import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class KYCModel extends FlutterFlowModel {
  String verificationPass = '1';
  String verificationFail = '0';
  bool buttonDisplay = true;
  int maxattempts = 5;
  int attemptcount = 0;
  final unfocusNode = FocusNode();
  ApplicationRecord? createdAppVar;

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }
}

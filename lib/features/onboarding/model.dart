import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class OnboardingModel extends FlutterFlowModel {

  final FocusNode unfocusNode = FocusNode();
  PageController? pageViewController;

  int get pageViewCurrentIndex {
    if (pageViewController?.hasClients == true &&
        pageViewController?.page != null) {
      return pageViewController!.page!.round();
    }
    return 0;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

}

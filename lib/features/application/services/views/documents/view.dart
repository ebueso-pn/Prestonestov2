import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'utils.dart';

class DocumentsPage extends StatefulWidget {
  DocumentsPage({super.key});

  @override
  ApplicationDocumentsState createState() => ApplicationDocumentsState();
}

class ApplicationDocumentsState extends State<DocumentsPage> {
  final FocusNode _focusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  void _onVerifyIncomeTapped(BuildContext context) {
    context.pushNamed('ProfileIncomePage');
  }

  void _onBankAccountTapped(BuildContext context) {
    if (!FFAppState().userHasIncomeVerification) {
      return;
    }

    context.pushNamed('ProfileBankAccount');
  }

  void _onContinuePressed(BuildContext context) async {
    if (_loading) return;
    setState(() => _loading = true);

    context.pushNamed(
      'ReviewApplication',
    );

    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();

    final user = FFAppState().currentUser;
    if (user != null) {
      FFAppState().update(() {
        FFAppState().userHasIncomeVerification = user.hasIncomeFileUploaded;
        FFAppState().userHasBankAccount = user.hasBankFileUploaded;
        FFAppState().IngresosEnviados = user.hasIncomeFileUploaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_focusNode),
            child: Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).secondary,
              key: scaffoldKey,
              body: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0, bottom: 0),
                      child: Text(
                        'Verifica tus Documentos',
                        style: FlutterFlowTheme.of(context).headlineMedium,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _onVerifyIncomeTapped(context),
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0x3416202A),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: (FFAppState().ApplicationEnviada ==
                                          true) &&
                                      (FFAppState().IngresosEnviados == false)
                                  ? FlutterFlowTheme.of(context).accent1
                                  : Color(0x00000000),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Verificar tus Ingresos',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge,
                                    ),
                                  ),
                                ),
                                if (!FFAppState().userHasIncomeVerification)
                                  Align(
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                      size: 25.0,
                                    ),
                                  ),
                                if (FFAppState().userHasIncomeVerification)
                                  Align(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 25.0,
                                    ),
                                  ),
                                SizedBox(
                                  width: 15,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.9, 0.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation2']!),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _onBankAccountTapped(context),
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: (FFAppState().userHasIncomeVerification)
                                ? FlutterFlowTheme.of(context)
                                    .secondaryBackground
                                : FlutterFlowTheme.of(context)
                                    .secondaryBackground
                                    .withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0x3416202A),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.account_balance_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Cuenta Bancaria',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge,
                                    ),
                                  ),
                                ),
                                //Check if current user has bank account
                                if (!FFAppState().userHasBankAccount)
                                  Align(
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                      size: 25.0,
                                    ),
                                  ),
                                if (FFAppState().userHasBankAccount)
                                  Align(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 25.0,
                                    ),
                                  ),
                                SizedBox(
                                  width: 15,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.9, 0.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation3']!),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 24.0,
                  top: 0.0,
                ),
                child: Visibility(
                  visible: FFAppState().userHasIncomeVerification,
                  child: FFButtonWidget(
                    onPressed: FFAppState().userHasIncomeVerification
                        ? () => _onContinuePressed(context)
                        : null,
                    text: 'Continuar',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FFAppState().userHasIncomeVerification
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context)
                              .primary
                              .withOpacity(0.5),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Urbanist',
                                color: FlutterFlowTheme.of(context).secondary,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                  ),
                ),
              ),
            )));
  }
}

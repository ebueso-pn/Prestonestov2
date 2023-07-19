import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 's_m_s_signup_model.dart';
export 's_m_s_signup_model.dart';

class SMSSignupWidget extends StatefulWidget {
  const SMSSignupWidget({Key? key}) : super(key: key);

  @override
  _SMSSignupWidgetState createState() => _SMSSignupWidgetState();
}

class _SMSSignupWidgetState extends State<SMSSignupWidget> {
  late SMSSignupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SMSSignupModel());

    _model.phoneNumberController ??= TextEditingController();
    authManager.handlePhoneAuthStateChanges(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  automaticallyImplyLeading: false,
                  actions: [],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 1.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  context.pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Inscribete en PrestoNesto',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.0,
                  ),
                  elevation: 2.0,
                ),
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                      child: Text(
                        '¡Porfavor apunta tu número para registrarte!\n',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
                child: TextFormField(
                  controller: _model.phoneNumberController,
                  autofocus: true,
                  autofillHints: [AutofillHints.telephoneNumberCountryCode],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Numero de celular',
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintText: '+504 9999-9999',
                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF7A8087),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  keyboardType: TextInputType.phone,
                  validator: _model.phoneNumberControllerValidator
                      .asValidator(context),
                  inputFormatters: [_model.phoneNumberMask],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final phoneNumberVal = _model.phoneNumberController.text;
                    if (phoneNumberVal == null ||
                        phoneNumberVal.isEmpty ||
                        !phoneNumberVal.startsWith('+')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Phone Number is required and has to start with +.'),
                        ),
                      );
                      return;
                    }
                    await authManager.beginPhoneAuth(
                      context: context,
                      phoneNumber: phoneNumberVal,
                      onCodeSent: (context) async {
                        context.goNamedAuth(
                          'SMS_verify_code',
                          context.mounted,
                          ignoreRedirect: true,
                        );
                      },
                    );
                  },
                  text: 'Enviar Codigo',
                  options: FFButtonOptions(
                    width: 230.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}

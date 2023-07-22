import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'application_d_n_i_validation_model.dart';
export 'application_d_n_i_validation_model.dart';

class ApplicationDNIValidationWidget extends StatefulWidget {
  const ApplicationDNIValidationWidget({
    Key? key,
    required this.applicationRecieve,
  }) : super(key: key);

  final DocumentReference? applicationRecieve;

  @override
  _ApplicationDNIValidationWidgetState createState() =>
      _ApplicationDNIValidationWidgetState();
}

class _ApplicationDNIValidationWidgetState
    extends State<ApplicationDNIValidationWidget> {
  late ApplicationDNIValidationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplicationDNIValidationModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.buttonDisplay = false;
      });
    });

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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  await widget.applicationRecieve!.update({
                                    'index': FieldValue.increment(-(1)),
                                  });
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
                            'Protejamos tu identidad',
                            style: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w500,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0x3416202A),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: StreamBuilder<ApplicationRecord>(
                            stream: ApplicationRecord.getDocument(
                                widget.applicationRecieve!),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF2AAF7A),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final progressBarApplicationRecord =
                                  snapshot.data!;
                              return LinearPercentIndicator(
                                percent: progressBarApplicationRecord.index / 5,
                                lineHeight: 7.0,
                                animation: true,
                                progressColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                padding: EdgeInsets.zero,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                child: Text(
                  'Hora de tomarnos fotos  ',
                  style: FlutterFlowTheme.of(context).headlineMedium,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Lottie.asset(
                    'assets/lottie_animations/tmpo2dz_7be.json',
                    width: 350.0,
                    height: 350.0,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  if (_model.buttonDisplay == false) {
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          var _shouldSetState = false;
                          _model.shuftiAPI = await ShuftiOnsiteWithOCRCall.call(
                            shuftiReference: widget.applicationRecieve?.id,
                          );
                          _shouldSetState = true;
                          await launchURL(
                              ShuftiOnsiteWithOCRCall.verificiationURL(
                            (_model.shuftiAPI?.jsonBody ?? ''),
                          ).toString());
                          if (ShuftiOnsiteWithOCRCall.status(
                                (_model.shuftiAPI?.jsonBody ?? ''),
                              ).toString() ==
                              'verification.accepted') {
                            await widget.applicationRecieve!.update({
                              'shufti_data':
                                  (ShuftiOnsiteWithOCRCall.verificationdata(
                                (_model.shuftiAPI?.jsonBody ?? ''),
                              ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()
                                      ?.map((e) => e.toString())
                                      .toList(),
                              'shufti_additional':
                                  (ShuftiOnsiteWithOCRCall.additionaldata(
                                (_model.shuftiAPI?.jsonBody ?? ''),
                              ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()
                                      ?.map((e) => e.toString())
                                      .toList(),
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            setState(() {
                              _model.buttonDisplay = true;
                            });
                          } else {
                            if (_shouldSetState) setState(() {});
                            return;
                          }

                          await widget.applicationRecieve!.update({
                            'index': FieldValue.increment(1),
                          });
                          if (_shouldSetState) setState(() {});
                        },
                        text: 'Verificar mi identidad',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'Application_Address',
                            queryParameters: {
                              'applicationRecieve': serializeParam(
                                widget.applicationRecieve,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'Continuar',
                        options: FFButtonOptions(
                          width: 194.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  }
                },
              ),
              FFButtonWidget(
                onPressed: () async {
                  context.pushNamed(
                    'Application_Address',
                    queryParameters: {
                      'applicationRecieve': serializeParam(
                        widget.applicationRecieve,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                },
                text: 'Button',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
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
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

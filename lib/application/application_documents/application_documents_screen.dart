/*
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prestonesto/auth/firebase_auth/auth_util.dart';
import 'package:prestonesto/backend/backend.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_animations.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_icon_button.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_theme.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_util.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_widgets.dart';

class ApplicationDocuments extends StatefulWidget {
  ApplicationDocuments(
      {super.key,
      required this.applicationRecieve,
      required this.equifaxStatus});

  final DocumentReference? applicationRecieve;
  final String equifaxStatus;

  @override
  ApplicationDocumentsState createState() => ApplicationDocumentsState();
}

class ApplicationDocumentsState extends State<ApplicationDocuments> {
  final FocusNode _focusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, -50.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 25.ms,
          duration: 600.ms,
          begin: Offset(-100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 50.ms,
          duration: 600.ms,
          begin: Offset(-100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 75.ms,
          duration: 600.ms,
          begin: Offset(-100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation6': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 50.ms,
          duration: 600.ms,
          begin: Offset(100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation7': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation8': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 25.ms,
          duration: 600.ms,
          begin: Offset(100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation9': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 75.ms,
          duration: 600.ms,
          begin: Offset(100.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    FFAppState().currentApplication = widget.applicationRecieve;
    FFAppState().currentEquifaxStatus = widget.equifaxStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          appBar: responsiveVisibility(
            context: context,
            desktop: false,
          )
              ? PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    automaticallyImplyLeading: false,
                    actions: [],
                    flexibleSpace: FlexibleSpaceBar(
                      title: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: 50,
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      if (_loading) return;
                                      setState(() => _loading = true);

                                      await widget.applicationRecieve!.update({
                                        'index': FieldValue.increment(-(1)),
                                      });
                                      if (context.canPop()) {
                                        context.pop();
                                      } else {
                                        context.goNamed(
                                          'Application_Carrousel',
                                          queryParameters: {
                                            'applicationRecieve':
                                                serializeParam(
                                              widget.applicationRecieve,
                                              ParamType.DocumentReference,
                                            ),
                                            'equifaxStatus':
                                                widget.equifaxStatus,
                                          }.withoutNulls,
                                        );
                                      }
                                      setState(() => _loading = false);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 0, 0),
                                    child: Text(
                                      'Requisitos para Completar tu Aplicación',
                                      overflow: TextOverflow.ellipsis,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                      expandedTitleScale: 1.0,
                    ),
                    elevation: 2,
                  ),
                )
              : null,
          key: scaffoldKey,
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: StreamBuilder<ApplicationRecord>(
                      stream: ApplicationRecord.getDocument(
                          widget.applicationRecieve!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF2AAF7A),
                                ),
                              ),
                            ),
                          );
                        }
                        final progressBarApplicationRecord = snapshot.data!;
                        return LinearPercentIndicator(
                          percent: progressBarApplicationRecord.index / 6,
                          lineHeight: 7,
                          animation: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          padding: EdgeInsets.zero,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      FirebaseAnalytics.instance
                          .logEvent(name: 'app_2_verificar_campos_adicionales');
                      FacebookAppEvents().logEvent(
                        name: 'app_2_verificar_campos_adicionales',
                      );

                      context.pushNamed('Profile_IncomeValidation');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                          color: (FFAppState().ApplicationEnviada == true) &&
                                  (FFAppState().IngresosEnviados == false)
                              ? FlutterFlowTheme.of(context).accent1
                              : Color(0x00000000),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Verificar tus Ingresos',
                                  style: FlutterFlowTheme.of(context).bodyLarge,
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (!FFAppState().userHasIncomeVerification) {
                        return;
                      }
                      FirebaseAnalytics.instance
                          .logEvent(name: 'app_2_verificar_campos_adicionales');
                      FacebookAppEvents()
                          .logEvent(name: 'app_2_verificar_campos_adicionales');

                      context.pushNamed('Profile_BankAccount');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: (FFAppState().userHasIncomeVerification)
                            ? FlutterFlowTheme.of(context).secondaryBackground
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
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.account_balance_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Cuenta Bancaria',
                                  style: FlutterFlowTheme.of(context).bodyLarge,
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                FFButtonWidget(
                  isEnable: !_loading,
                  onPressed: () async {
                    if (!FFAppState().userHasIncomeVerification ||
                        !FFAppState().userHasBankAccount) {
                      return;
                    }

                    if (_loading) return;
                    setState(() => _loading = true);

                    await widget.applicationRecieve!.update({
                      'index': FieldValue.increment(1),
                    });

                    context.pushNamed(
                      'Application_Review',
                      queryParameters: {
                        'applicationRecieve': serializeParam(
                          widget.applicationRecieve,
                          ParamType.DocumentReference,
                        ),
                        'equifaxStatus': widget.equifaxStatus,
                      }.withoutNulls,
                    );
                    setState(() => _loading = false);
                  },
                  text: 'Continuar',
                  options: FFButtonOptions(
                    width: 230.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: (FFAppState().userHasIncomeVerification &&
                            FFAppState().userHasBankAccount)
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).primary.withOpacity(0.5),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
                )
              ],
            ),
          ),
        ));
  }
}
*/
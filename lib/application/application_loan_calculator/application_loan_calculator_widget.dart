import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'application_loan_calculator_model.dart';
export 'application_loan_calculator_model.dart';

class ApplicationLoanCalculatorWidget extends StatefulWidget {
  const ApplicationLoanCalculatorWidget({Key? key}) : super(key: key);

  @override
  _ApplicationLoanCalculatorWidgetState createState() =>
      _ApplicationLoanCalculatorWidgetState();
}

class _ApplicationLoanCalculatorWidgetState
    extends State<ApplicationLoanCalculatorWidget>
    with TickerProviderStateMixin {
  late ApplicationLoanCalculatorModel _model;
  int counter = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, -60.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 60.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplicationLoanCalculatorModel());

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

    return StreamBuilder<List<ApplicationRecord>>(
      stream: queryApplicationRecord(
        parent: currentUserReference,
        queryBuilder: (applicationRecord) =>
            applicationRecord.orderBy('date_applied', descending: true),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF2AAF7A),
                  ),
                ),
              ),
            ),
          );
        }
        List<ApplicationRecord> applicationLoanCalculatorApplicationRecordList =
            snapshot.data!;
        final hasApplied = applicationLoanCalculatorApplicationRecordList
                .isNotEmpty
            ? applicationLoanCalculatorApplicationRecordList.any((element) =>
                (element.status == 'Enviada' || element.status == 'Denegada') &&
                (functions.appIneligible(element.dateApplied!) == true))
            : false;
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
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 0.0, 24.0),
                                child: Text(
                                  'Calculadora Prestonesto',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                      ),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 24.0, 12.0, 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 75.0,
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
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 24.0, 12.0, 24.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Cuota quincenal estimada: ',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Urbanist',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              Text(
                                formatNumber(
                                  functions.loanCalculator(
                                      valueOrDefault<double>(
                                        _model.loanAmtValue,
                                        1000.0,
                                      ),
                                      .033,
                                      valueOrDefault<double>(
                                        _model.loanTermValue,
                                        3.0,
                                      )),
                                  formatType: FormatType.custom,
                                  currency: 'L ',
                                  format: '#,###.#',
                                  locale: '',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      fontSize: 18.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation1']!),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      'Monto de tu Prestamo: ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        formatNumber(
                                          _model.loanAmtValue,
                                          formatType: FormatType.decimal,
                                          decimalType: DecimalType.automatic,
                                          currency: 'L ',
                                        ),
                                        '1000',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    1.0, 1.0, 1.0, 1.0),
                                child: Slider.adaptive(
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  min: 0.0,
                                  max: 25000.0,
                                  value: _model.loanAmtValue ??= 0.0,
                                  label: _model.loanAmtValue.toString(),
                                  divisions: 25,
                                  onChanged: (newValue) {
                                    newValue = double.parse(
                                        newValue.toStringAsFixed(0));
                                    setState(() {
                                      _model.loanAmtValue = newValue;
                                      counter++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation2']!),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      'Tiempo de Repago: ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        formatNumber(
                                          _model.loanTermValue,
                                          formatType: FormatType.custom,
                                          format: '## meses ',
                                          locale: '',
                                        ),
                                        '3',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Slider.adaptive(
                                activeColor:
                                    FlutterFlowTheme.of(context).primary,
                                inactiveColor:
                                    FlutterFlowTheme.of(context).alternate,
                                min: 3.0,
                                max: 12.0,
                                value: _model.loanTermValue ??= 3.0,
                                label: _model.loanTermValue.toString(),
                                divisions: 3,
                                onChanged: (newValue) {
                                  newValue =
                                      double.parse(newValue.toStringAsFixed(0));
                                  setState(
                                      () => _model.loanTermValue = newValue);
                                },
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation3']!),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  'Tasa de Interes: 3.3% mensual',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '*Las cuotas son quincenales',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '*La tasa final será determinada despues de analizar tu solicitud',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation4']!),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 32.0, 32.0, 32.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            if (hasApplied) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(
                                        '¡Has aplicado en los últimos 3 meses!'),
                                    content: Text(
                                        'Recuerda que debes esperar 3 meses antes de volver a aplicar a un crédito con nosotros.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) setState(() {});
                              return;
                            }
                            if (_model.loanAmtValue! <= 0.0) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Fijese que...'),
                                    content:
                                        Text('Monto debe ser mayor a L. 0'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) setState(() {});
                              return;
                            }

                            var applicationRecordReference =
                                ApplicationRecord.createDoc(
                                    currentUserReference!);
                            await applicationRecordReference.set({
                              ...createApplicationRecordData(
                                monto: _model.loanAmtValue,
                                plazoMeses: _model.loanTermValue,
                                cuota: functions.loanCalculator(
                                    _model.loanAmtValue!,
                                    .033,
                                    _model.loanTermValue!),
                                index: 1,
                              ),
                              'date_applied': FieldValue.serverTimestamp(),
                            });
                            _model.createdAppVar =
                                ApplicationRecord.getDocumentFromData({
                              ...createApplicationRecordData(
                                monto: _model.loanAmtValue,
                                plazoMeses: _model.loanTermValue,
                                cuota: functions.loanCalculator(
                                    _model.loanAmtValue!,
                                    .033,
                                    _model.loanTermValue!),
                                index: 1,
                              ),
                              'date_applied': DateTime.now(),
                            }, applicationRecordReference);
                            _shouldSetState = true;

                            await FirebaseAnalytics.instance.logEvent(
                                name: 'app_calcular_monto_y_plazo',
                                parameters: {
                                  'clicks_en_monto': counter,
                                });
                            FacebookAppEvents().logEvent(
                              name: 'app_calcular_monto_y_plazo',
                              parameters: {
                                'clicks_en_monto': counter,
                              },
                            );
                            counter = 0;

                            context.pushNamed(
                              'Applicaiton_Summary',
                              queryParameters: {
                                'applicationRecieve': serializeParam(
                                  _model.createdAppVar?.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );

                            if (_shouldSetState) setState(() {});
                          },
                          text: 'Aplicar',
                          options: FFButtonOptions(
                            width: 230.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(42.0),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['buttonOnPageLoadAnimation']!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

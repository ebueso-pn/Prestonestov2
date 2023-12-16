import 'package:flutter/gestures.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;
  var payments = [];
  int nextIndexPayment = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
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
          begin: Offset(-50.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
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
          begin: Offset(80.0, 0.0),
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
          begin: Offset(0.0, 90.0),
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
          begin: Offset(0.0, 120.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation5': AnimationInfo(
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
          begin: Offset(0.0, 110.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation6': AnimationInfo(
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
          begin: Offset(0.0, 120.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation7': AnimationInfo(
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
          begin: Offset(0.0, 120.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
    userPaymentsShedule().then((value) {
      setState(() {
        payments = value;
        nextIndexPayment =
            payments.indexWhere((element) => element['status'] == 'F');
        isLoading = false;
      });
    });
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
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData || isLoading) {
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
        List<ApplicationRecord> homeApplicationRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie_animations/tmpzrejxg10.json',
                width: 350.0,
                height: 350.0,
                fit: BoxFit.fill,
                animate: true,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'No tienes ningún préstamo activo. ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Continua con tu solicitud ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'aquí',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              context.pushNamed('Application_LoanCalculator'),
                      ),
                      TextSpan(
                        text: '!',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        final homeApplicationRecord = homeApplicationRecordList.isNotEmpty
            ? homeApplicationRecordList.first
            : null;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: responsiveVisibility(
              context: context,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    automaticallyImplyLeading: false,
                    title: Align(
                      alignment: AlignmentDirectional(-0.9, 0.0),
                      child: Text(
                        'Buen Día',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    actions: [],
                    centerTitle: false,
                    elevation: 2.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: StreamBuilder<List<LoansRecord>>(
                stream: queryLoansRecord(
                  queryBuilder: (loansRecord) => loansRecord.where(
                      'UserDocReference',
                      isEqualTo: currentUserReference),
                  singleRecord: true,
                ),
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
                  List<LoansRecord> columnLoansRecordList = snapshot.data!;
                  final columnLoansRecord = columnLoansRecordList.isNotEmpty
                      ? columnLoansRecordList.first
                      : null;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    valueOrDefault(
                                        currentUserDocument?.nombres, ''),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineLarge,
                                  ).animateOnPageLoad(animationsMap[
                                      'textOnPageLoadAnimation']!),
                                ),
                              ),
                              Container(
                                width: 70.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 36.0,
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation1']!),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (columnLoansRecord?.status == 'Firmado') {
                              return Wrap(
                                spacing: 0.0,
                                runSpacing: 0.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.start,
                                verticalDirection: VerticalDirection.down,
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 8.0, 16.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(
                                        maxWidth: 500.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 2.0),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 16.0, 12.0, 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Balance ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 0.0, 4.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  formatNumber(
                                                    columnLoansRecord?.balance,
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: 'L ',
                                                  ),
                                                  'L. 0.00',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontSize: 44.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context
                                                    .pushNamed('LoanDocument');
                                              },
                                              text: 'Ver Contrato de Prestamo',
                                              options: FFButtonOptions(
                                                width: 230.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Proximo Pago: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            if (payments.length != 0)
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Fecha',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(DateTime.parse(
                                                                  payments[nextIndexPayment]
                                                                          [
                                                                          'fecha']
                                                                      .toDate()
                                                                      .toString()
                                                                      .split(
                                                                          ' ')[0])),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Monto',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                        Text(
                                                          !(payments[nextIndexPayment]
                                                                      ['Cuota']
                                                                  is double)
                                                              ? (payments[nextIndexPayment]
                                                                      ['Cuota'])
                                                                  .toString()
                                                              : formatNumber(
                                                                  double.parse((payments[nextIndexPayment]
                                                                              [
                                                                              'Cuota']
                                                                          as double)
                                                                      .toStringAsFixed(
                                                                          2)),
                                                                  formatType:
                                                                      FormatType
                                                                          .decimal,
                                                                  decimalType:
                                                                      DecimalType
                                                                          .automatic,
                                                                  currency:
                                                                      'L ',
                                                                ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                      'Payment_Details');
                                                },
                                                text: 'Realizar un Pago',
                                                options: FFButtonOptions(
                                                  width: 230.0,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color: Colors.white,
                                                      ),
                                                  elevation: 2.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation2']!),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(
                                        maxWidth: 500.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 2.0),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 16.0, 12.0, 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Mi Prestonesto',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge,
                                            ),
                                            if (columnLoansRecord
                                                    ?.fechaUltimoPago !=
                                                null)
                                              Text(
                                                'Ultimo pago: ${dateTimeFormat(
                                                  'd/M/y',
                                                  columnLoansRecord
                                                      ?.fechaUltimoPago,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                )}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                              ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 0.0, 12.0),
                                              child: LinearPercentIndicator(
                                                percent: 0.1,
                                                width: 300.0,
                                                lineHeight: 16.0,
                                                animation: true,
                                                progressColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                barRadius:
                                                    Radius.circular(16.0),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      columnLoansRecord
                                                          ?.balance,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'L ',
                                                    ),
                                                    '0.00 ',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge,
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      columnLoansRecord?.monto,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: 'de L ',
                                                    ),
                                                    ' de L 0.00',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ].divide(SizedBox(width: 2.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation3']!),
                                  ),
                                  if (payments.length != 0)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 16.0),
                                      child: Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxWidth: 500.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 2.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 16.0, 12.0, 12.0),
                                            child: Column(
                                              //Alinear al comienzo
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Historial de Pagos',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                _buildRowPayment(
                                                    payments[0], false),
                                                Center(
                                                  child: FFButtonWidget(
                                                    onPressed: () =>
                                                        _buildPopUpPaymentHistory(),
                                                    text: 'Mostrar todo',
                                                    options: FFButtonOptions(
                                                      width: 120.0,
                                                      height: 20.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBtnText,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation3']!),
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       16.0, 0.0, 16.0, 16.0),
                                  //   child: InkWell(
                                  //     splashColor: Colors.transparent,
                                  //     focusColor: Colors.transparent,
                                  //     hoverColor: Colors.transparent,
                                  //     highlightColor: Colors.transparent,
                                  //     onTap: () async {
                                  //       context.pushNamed('Help');
                                  //     },
                                  //     child: Container(
                                  //       width: double.infinity,
                                  //       constraints: BoxConstraints(
                                  //         maxWidth: 500.0,
                                  //       ),
                                  //       decoration: BoxDecoration(
                                  //         color: FlutterFlowTheme.of(context)
                                  //             .secondaryBackground,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             blurRadius: 4.0,
                                  //             color: Color(0x33000000),
                                  //             offset: Offset(0.0, 2.0),
                                  //           )
                                  //         ],
                                  //         borderRadius:
                                  //             BorderRadius.circular(12.0),
                                  //         border: Border.all(
                                  //           color: FlutterFlowTheme.of(context)
                                  //               .primaryBackground,
                                  //           width: 2.0,
                                  //         ),
                                  //       ),
                                  //       child: Padding(
                                  //         padding:
                                  //             EdgeInsetsDirectional.fromSTEB(
                                  //                 12.0, 8.0, 12.0, 8.0),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           children: [
                                  //             Icon(
                                  //               Icons.help_outline,
                                  //               color:
                                  //                   FlutterFlowTheme.of(context)
                                  //                       .primary,
                                  //               size: 36.0,
                                  //             ),
                                  //             Expanded(
                                  //               child: Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(
                                  //                         12.0, 0.0, 0.0, 0.0),
                                  //                 child: Column(
                                  //                   mainAxisSize:
                                  //                       MainAxisSize.max,
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .start,
                                  //                   children: [
                                  //                     Text(
                                  //                       'Contáctanos',
                                  //                       style:
                                  //                           FlutterFlowTheme.of(
                                  //                                   context)
                                  //                               .bodyLarge,
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ).animateOnPageLoad(animationsMap[
                                  //       'containerOnPageLoadAnimation5']!),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       16.0, 0.0, 16.0, 16.0),
                                  //   child: Container(
                                  //     width: double.infinity,
                                  //     constraints: BoxConstraints(
                                  //       maxWidth: 500.0,
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //       color: FlutterFlowTheme.of(context)
                                  //           .secondaryBackground,
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           blurRadius: 4.0,
                                  //           color: Color(0x33000000),
                                  //           offset: Offset(0.0, 2.0),
                                  //         )
                                  //       ],
                                  //       borderRadius:
                                  //           BorderRadius.circular(12.0),
                                  //       border: Border.all(
                                  //         color: FlutterFlowTheme.of(context)
                                  //             .primaryBackground,
                                  //         width: 2.0,
                                  //       ),
                                  //     ),
                                  //     child: Padding(
                                  //       padding: EdgeInsetsDirectional.fromSTEB(
                                  //           12.0, 8.0, 12.0, 8.0),
                                  //       child: Row(
                                  //         mainAxisSize: MainAxisSize.max,
                                  //         children: [
                                  //           Icon(
                                  //             Icons.person_search_rounded,
                                  //             color:
                                  //                 FlutterFlowTheme.of(context)
                                  //                     .primary,
                                  //             size: 36.0,
                                  //           ),
                                  //           Expanded(
                                  //             child: Padding(
                                  //               padding: EdgeInsetsDirectional
                                  //                   .fromSTEB(
                                  //                       12.0, 0.0, 0.0, 0.0),
                                  //               child: Column(
                                  //                 mainAxisSize:
                                  //                     MainAxisSize.max,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Text(
                                  //                     'Encuentra un Agente o Cajero',
                                  //                     style:
                                  //                         FlutterFlowTheme.of(
                                  //                                 context)
                                  //                             .bodyLarge,
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ).animateOnPageLoad(animationsMap[
                                  //       'containerOnPageLoadAnimation6']!),
                                  // ),
                                ],
                              );
                            } else if (homeApplicationRecord?.status ==
                                    'Aprobada' ||
                                homeApplicationRecord?.status == 'Aceptada') {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Tu préstamo está listo!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Lottie.asset(
                                    'assets/lottie_animations/approved-4246793.json',
                                    width: 200.0,
                                    height: 200.0,
                                    animate: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Si aceptas tu oferta, y firmas el contrato, tu dinero estará en camino a tu cuenta!',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 16.0),
                                    child:
                                        StreamBuilder<List<ApplicationRecord>>(
                                      stream: queryApplicationRecord(
                                        parent: currentUserReference,
                                        queryBuilder: (applicationRecord) =>
                                            applicationRecord.whereIn('status',
                                                ['Aprobada', 'Aceptada']),
                                        singleRecord: true,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFF2AAF7A),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<ApplicationRecord>
                                            containerApplicationRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final containerApplicationRecord =
                                            containerApplicationRecordList
                                                    .isNotEmpty
                                                ? containerApplicationRecordList
                                                    .first
                                                : null;
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'Loan_Signature',
                                              queryParameters: {
                                                'signURL': serializeParam(
                                                  0,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              context.pushNamed(
                                                'Loan_Signature',
                                                queryParameters: {
                                                  'signURL': serializeParam(
                                                    0,
                                                    ParamType.int,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Color(0xFF2AAF7A),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0), // Radio del borde
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons
                                                    .create), // Icono de firma (puedes cambiar el icono según tus necesidades)
                                                SizedBox(
                                                    width:
                                                        8), // Espacio entre el icono y el texto
                                                Text('Firmar ahora'),
                                              ],
                                            ),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation7']!);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else if (homeApplicationRecord?.status ==
                                'Enviada') {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Lottie.asset(
                                      'assets/lottie_animations/tmpo2dz_7be.json',
                                      width: 350.0,
                                      height: 350.0,
                                      fit: BoxFit.cover,
                                      animate: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        'Tu solicitud está completada y pasará a evaluación! \nTendrás una respuesta sobre tu crédito en las próximas 24 horas hábiles.',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Pasos para aplicar',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineLarge
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 12.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 16.0,
                                                  height: 16.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      homeApplicationRecord
                                                                  ?.status ==
                                                              'Enviada'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Container(
                                                  width: 2.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      homeApplicationRecord
                                                                  ?.status ==
                                                              'Enviada'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.85,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Elegir un monto y plazo',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 12.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 16.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    homeApplicationRecord
                                                                ?.status ==
                                                            'Enviada'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                width: 2.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    homeApplicationRecord
                                                                ?.status ==
                                                            'Enviada'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Tomarle foto a tu DNI y una selfie',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 12.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 16.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    homeApplicationRecord
                                                                ?.status ==
                                                            'Enviada'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                width: 2.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    homeApplicationRecord
                                                                ?.status ==
                                                            'Enviada'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Fijar tu ubicación',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 12.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 16.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    homeApplicationRecord
                                                                ?.status ==
                                                            'Enviada'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                width: 2.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    homeApplicationRecord
                                                                ?.status ==
                                                            'Enviada'
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Enviar solicitud',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 12.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 16.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    FFAppState().userHasIncomeVerification &&
                                                            FFAppState()
                                                                .userHasBankAccount &&
                                                            FFAppState()
                                                                    .userHasPersonalEvaluationCompleted ==
                                                                true
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Completar tu perfil',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 50.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        isEnable: FFAppState()
                                                .userHasIncomeVerification &&
                                            FFAppState().userHasBankAccount &&
                                            FFAppState()
                                                .userHasPersonalEvaluationCompleted,
                                        onPressed: () async {
                                          context.pushNamed(
                                              'Application_LoanCalculator');
                                        },
                                        text: '¡Aplicar!',
                                        options: FFButtonOptions(
                                          width: 230.0,
                                          height: 50.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
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
                                          borderRadius:
                                              BorderRadius.circular(48.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRowPayment(Map<String, dynamic> payment, bool isNextPayment) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 500.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBtnText,
          boxShadow: [
            BoxShadow(
              blurRadius: !isNextPayment ? 4.0 : 6.0,
              color: !isNextPayment ? Color(0x33000000) : Colors.black,
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Fecha',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.parse(
                            payments[nextIndexPayment]['fecha']
                                .toDate()
                                .toString()
                                .split(' ')[0])),
                        style: FlutterFlowTheme.of(context).labelSmall,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Monto',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        !(payments[nextIndexPayment]['Cuota'] is double)
                            ? (payments[nextIndexPayment]['Cuota']).toString()
                            : formatNumber(
                                double.parse((payments[nextIndexPayment]
                                        ['Cuota'] as double)
                                    .toStringAsFixed(2)),
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.automatic,
                                currency: 'L ',
                              ),
                        style: FlutterFlowTheme.of(context).labelSmall,
                      ),
                    ],
                  ),
                ),
                if (payment['Mora'] > 0)
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Mora',
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          !(payment['Mora'] is double)
                              ? (payment['Mora']).toString()
                              : formatNumber(
                                  double.parse((payment['Mora'] as double)
                                      .toStringAsFixed(2)),
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.automatic,
                                  currency: 'L ',
                                ),
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Status',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        payment['status'] == 'F' ? 'Pendiente' : 'Pago',
                        style: FlutterFlowTheme.of(context).labelSmall,
                      ),
                    ],
                  ),
                ),
                if (payment['Mora'] > 0)
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.yellow,
                    size: 25.0,
                  ),
              ],
            )),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
    );
  }

  Future<List<Widget>> _buildPaymentHistory() async {
    List<Widget> widgets = [];
    for (int i = 0; i < payments.length; i++) {
      widgets.add(_buildRowPayment(payments[i], false));
    }
    return widgets;
  }

  void _buildPopUpPaymentHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Historial de Pagos',
            style: FlutterFlowTheme.of(context).headlineMedium,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          content: FutureBuilder<List<Widget>>(
            future: _buildPaymentHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!,
                  ),
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cerrar',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

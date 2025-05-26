import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:prestonesto/utils/config_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loan_signature_model.dart';
export 'loan_signature_model.dart';

class LoanSignatureWidget extends StatefulWidget {
  const LoanSignatureWidget({
    Key? key,
    required this.signURL,
  }) : super(key: key);

  final int? signURL;

  @override
  _LoanSignatureWidgetState createState() => _LoanSignatureWidgetState();
}

class _LoanSignatureWidgetState extends State<LoanSignatureWidget> {
  late LoanSignatureModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoanSignatureModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
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
                            'Terminos de tu PrestoNesto',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                  fontSize: 22.0,
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
                padding: EdgeInsetsDirectional.fromSTEB(36.0, 24.0, 36.0, 24.0),
                child: StreamBuilder<List<ApplicationRecord>>(
                  stream: queryApplicationRecord(
                    parent: currentUserReference,
                    queryBuilder: (applicationRecord) => applicationRecord
                        .whereIn('status', ['Aprobada', 'Aceptada']).orderBy(
                            'date_applied',
                            descending: true),
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
                    List<ApplicationRecord> columnApplicationRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final columnApplicationRecord =
                        columnApplicationRecordList.isNotEmpty
                            ? columnApplicationRecordList.first
                            : null;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Text(
                            '¡Aprobado! ',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Text(
                            'Te estaremos enviando un enlace para la firma cuando aceptes estos terminos .',
                            style: FlutterFlowTheme.of(context).labelMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Monto',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                formatNumber(
                                  columnApplicationRecord!.montoAprobado,
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.automatic,
                                  currency: 'L. ',
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cuota quincenal',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                formatNumber(
                                  columnApplicationRecord.cuotaAprobada,
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.automatic,
                                  currency: 'L. ',
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tasa',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                formatNumber(
                                  columnApplicationRecord.tasaMensualAprobada,
                                  formatType: FormatType.percent,
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Plazo',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                formatNumber(
                                  columnApplicationRecord.plazoAprobado,
                                  formatType: FormatType.custom,
                                  format: '# meses',
                                  locale: '',
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Numero de Cuotas',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                functions
                                    .numeroCuotas(
                                        columnApplicationRecord.plazoAprobado)
                                    .toString(),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Primer Pago',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                dateTimeFormat(
                                  'd/M/y',
                                  functions.fechaFirmaMas15(
                                      dateTimeFromSecondsSinceEpoch(
                                          getCurrentTimestamp
                                              .secondsSinceEpoch)),
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ultimo Pago',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                dateTimeFormat(
                                  'd/M/y',
                                  functions.fechaUltimoPago(
                                      dateTimeFromSecondsSinceEpoch(
                                          getCurrentTimestamp
                                              .secondsSinceEpoch),
                                      columnApplicationRecord.plazoAprobado),
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total a repagar',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                formatNumber(
                                  columnApplicationRecord.cuotaAprobada *
                                      columnApplicationRecord.plazoAprobado *
                                      2,
                                  formatType: FormatType.custom,
                                  currency: 'L ',
                                  format: '#,###.#',
                                  locale: '',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: StreamBuilder<List<ApplicationRecord>>(
                  stream: queryApplicationRecord(
                    parent: currentUserReference,
                    queryBuilder: (applicationRecord) => applicationRecord
                        .whereIn('status', ['Aprobada', 'Aceptada']).orderBy(
                            'date_applied',
                            descending: true),
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
                    List<ApplicationRecord> buttonApplicationRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final buttonApplicationRecord =
                        buttonApplicationRecordList.isNotEmpty
                            ? buttonApplicationRecordList.first
                            : null;
                    return FFButtonWidget(
                      onPressed: () async {
                        var _shouldSetState = false;

                        final fechaPrimerPago =
                            functions.fechaFirmaMas15(getCurrentTimestamp);
                        final fechaUltimoPago = functions.fechaUltimoPago(
                            getCurrentTimestamp,
                            buttonApplicationRecord!.plazoMeses);

                        await buttonApplicationRecord.reference
                            .update(createApplicationRecordData(
                          fechaPrimerPago: fechaPrimerPago,
                          fechaUltimoPago: fechaUltimoPago,
                          status: 'Aceptada',
                        ));
                        _model.zapSignAPIresponse =
                            await ZapSIgnCreateDocumentFromTemplateCall.call(
                          phone: (currentPhoneNumber.startsWith("+504 ")
                              ? currentPhoneNumber.substring(5)
                              : currentPhoneNumber),
                          externalId: currentUserReference?.id,
                          name:
                              '${valueOrDefault(currentUserDocument?.nombres, '')} ${valueOrDefault(currentUserDocument?.apellidos, '')}',
                          email: currentUserEmail,
                          dni: valueOrDefault(currentUserDocument?.dni, ''),
                          monto: functions.formatNumber(
                              buttonApplicationRecord.montoAprobado),
                          montoEnLetras: functions.montoEnLetras(
                              buttonApplicationRecord.montoAprobado),
                          numCuotas: functions.numeroCuotas(
                              buttonApplicationRecord.plazoAprobado),
                          fechaFirmaDia: dateTimeFormat(
                            'd',
                            getCurrentTimestamp,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaFrimaMes: dateTimeFormat(
                            'M',
                            getCurrentTimestamp,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaFirmaAno: dateTimeFormat(
                            'y',
                            getCurrentTimestamp,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaPrimerPagoDia: dateTimeFormat(
                            'd',
                            functions.fechaFirmaMas15(
                                dateTimeFromSecondsSinceEpoch(
                                    getCurrentTimestamp.secondsSinceEpoch)),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaPrimerPagoMes: dateTimeFormat(
                            'M',
                            functions.fechaFirmaMas15(getCurrentTimestamp),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaPrimerPagoAno: dateTimeFormat(
                            'y',
                            fechaPrimerPago,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaUltimoPagoDia: dateTimeFormat(
                            'd',
                            fechaUltimoPago,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaUltimoPagoMes: dateTimeFormat(
                            'M',
                            functions.fechaUltimoPago(getCurrentTimestamp,
                                buttonApplicationRecord.plazoAprobado),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaUltimoPagoAno: dateTimeFormat(
                            'y',
                            functions.fechaUltimoPago(getCurrentTimestamp,
                                buttonApplicationRecord.plazoAprobado),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          cuota: buttonApplicationRecord?.cuotaAprobada,
                          tasaEfectivaMensual: functions.decimaltoPercent(
                              buttonApplicationRecord.tasaMensualAprobada),
                          tasaEfectivaMensualL: functions.tasaEnLetras(
                              buttonApplicationRecord.tasaMensualAprobada),
                          fechaFirmaDiaL:
                              functions.diaEnLetras(getCurrentTimestamp),
                          fechaFrimaMesL:
                              functions.mesEnLetras(getCurrentTimestamp),
                          fechaFirmaAnoL:
                              functions.anoEnLetras(getCurrentTimestamp),
                          fechaPrimerPagoDiaL:
                              functions.diaEnLetras(fechaPrimerPago),
                          fechaPrimerPagoMesL:
                              functions.mesEnLetras(fechaPrimerPago),
                          fechaPrimerPagoAnoL:
                              functions.anoEnLetras(fechaPrimerPago),
                          fechaUltimoPagoDiaL:
                              functions.diaEnLetras(fechaUltimoPago),
                          fechaUltimoPagoMesL:
                              functions.mesEnLetras(fechaUltimoPago),
                          fechaUltimoPagoAnoL:
                              functions.anoEnLetras(fechaUltimoPago),
                          direccion:
                              '${valueOrDefault(currentUserDocument?.calle, '')} ${valueOrDefault(currentUserDocument?.colonia, '')} ${valueOrDefault(currentUserDocument?.ciudad, '')}',
                        );
                        _shouldSetState = true;
                        if ((_model.zapSignAPIresponse?.succeeded ?? true)) {
                          //Update signer to add rediret_link
                          await ZapSignUpdateSignerCall.call(
                            signerToken: serializeParam(
                              getJsonField(
                                (_model.zapSignAPIresponse?.jsonBody ?? ''),
                                r'''$.signers[:].token''',
                              ).toString(),
                              ParamType.String,
                            ),
                            redirectLink:
                                //Depend on enviroment
                                // 'https://prestonesto.web.app/loanSignatureSuccess',
                                ConfigReader.isDevMode()
                                    ? 'https://d8ypx.test-app.link/success_zapsign'
                                    : 'https://d8ypx.app.link/success_zapsign',
                          );

                          context.pushNamed(
                            'LoanAcceptance_SuccessCopy',
                            queryParameters: {
                              'signURL': serializeParam(
                                getJsonField(
                                  (_model.zapSignAPIresponse?.jsonBody ?? ''),
                                  r'''$.signers[:].sign_url''',
                                ).toString(),
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        } else {
                          print(_model.zapSignAPIresponse?.bodyText);
                          //show error in bottom sheet
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _model.zapSignAPIresponse?.bodyText ?? '',
                              ),
                            ),
                          );
                          return;
                        }

                        await LoansRecord.collection
                            .doc()
                            .set(createLoansRecordData(
                              applicationDocReference:
                                  buttonApplicationRecord?.reference,
                              userDocReference: currentUserReference,
                              tasa:
                                  buttonApplicationRecord?.tasaMensualAprobada,
                              cuota: buttonApplicationRecord?.cuotaAprobada,
                              monto: buttonApplicationRecord?.montoAprobado,
                              plazo: buttonApplicationRecord?.plazoAprobado,
                              fechaUltimoPago: fechaUltimoPago,
                              fechaCreado: getCurrentTimestamp,
                              fechaPrimerPago: fechaPrimerPago,
                              balance: buttonApplicationRecord?.montoAprobado,
                            ));
                        if (_shouldSetState) setState(() {});

                        final counter = await _prefs.then(
                            (value) => value.getInt('userLoanCounter') ?? 0);
                        FirebaseAnalytics.instance.logEvent(
                            name: 'app_3_aceptar_oferta',
                            parameters: {
                              'ingresos_a_pantalla': counter,
                            });
                        FacebookAppEvents().logEvent(
                          name: 'app_3_aceptar_oferta',
                          parameters: {
                            'ingresos_a_pantalla': counter,
                          },
                        );
                      },
                      text: 'Aceptar',
                      options: FFButtonOptions(
                        width: 230.0,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

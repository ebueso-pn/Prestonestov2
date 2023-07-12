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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Back',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
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
                        .where('status', isEqualTo: 'Aprobada')
                        .orderBy('date_applied', descending: true),
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
                            color: Color(0xFF2AAF7A),
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
                            '¡Felicidades! ',
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
                                'Cuota',
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                              Text(
                                formatNumber(
                                  columnApplicationRecord!.cuotaAprobada,
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
                                  columnApplicationRecord!.tasaMensualAprobada,
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
                                  columnApplicationRecord!.plazoAprobado,
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
                                        columnApplicationRecord!.plazoAprobado)
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
                                      columnApplicationRecord!.plazoAprobado),
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context).bodyLarge,
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
                        .where('status', isEqualTo: 'Aprobada')
                        .orderBy('date_applied', descending: true),
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
                            color: Color(0xFF2AAF7A),
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

                        await buttonApplicationRecord!.reference
                            .update(createApplicationRecordData(
                          fechaPrimerPago:
                              functions.fechaFirmaMas15(getCurrentTimestamp),
                          fechaUltimoPago: functions.fechaUltimoPago(
                              getCurrentTimestamp,
                              buttonApplicationRecord!.plazoMeses),
                        ));
                        _model.zapSignAPIresponse =
                            await ZapSIgnCreateDocumentFromTemplateCall.call(
                          phone: currentPhoneNumber,
                          externalId: currentUserReference?.id,
                          name:
                              '${valueOrDefault(currentUserDocument?.nombres, '')} ${valueOrDefault(currentUserDocument?.apellidos, '')}',
                          email: currentUserEmail,
                          dni: valueOrDefault(currentUserDocument?.dni, ''),
                          monto: buttonApplicationRecord!.montoAprobado,
                          montoEnLetras: functions.montoEnLetras(
                              buttonApplicationRecord!.montoAprobado),
                          numCuotas: functions.numeroCuotas(
                              buttonApplicationRecord!.plazoAprobado),
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
                            'Y',
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
                            'yyyy',
                            functions.fechaFirmaMas15(getCurrentTimestamp),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaUltimoPagoDia: dateTimeFormat(
                            'd',
                            functions.fechaUltimoPago(getCurrentTimestamp,
                                buttonApplicationRecord!.plazoAprobado),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaUltimoPagoMes: dateTimeFormat(
                            'M',
                            functions.fechaUltimoPago(getCurrentTimestamp,
                                buttonApplicationRecord!.plazoAprobado),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaUltimoPagoAno: dateTimeFormat(
                            'Y',
                            functions.fechaUltimoPago(getCurrentTimestamp,
                                buttonApplicationRecord!.plazoAprobado),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          cuota: buttonApplicationRecord!.cuotaAprobada,
                          tasaEfectivaMensual:
                              buttonApplicationRecord!.tasaMensualAprobada,
                          tasaEfectivaMensualL: buttonApplicationRecord!
                              .tasaMensualAprobada
                              .toString(),
                          fechaFirmaDiaL:
                              functions.diaEnLetras(getCurrentTimestamp),
                          fechaFrimaMesL: dateTimeFormat(
                            'M',
                            getCurrentTimestamp,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          fechaFirmaAnoL: getCurrentTimestamp.toString(),
                          fechaPrimerPagoDiaL: functions.diaEnLetras(
                              buttonApplicationRecord!.fechaPrimerPago!),
                          fechaPrimerPagoMesL: functions.mesEnLetras(
                              buttonApplicationRecord!.fechaPrimerPago!),
                          fechaPrimerPagoAnoL: functions.anoEnLetras(
                              buttonApplicationRecord!.fechaPrimerPago!),
                          fechaUltimoPagoDiaL: functions.diaEnLetras(
                              buttonApplicationRecord!.fechaUltimoPago!),
                          fechaUltimoPagoMesL: functions.mesEnLetras(
                              buttonApplicationRecord!.fechaUltimoPago!),
                          fechaUltimoPagoAnoL: functions.anoEnLetras(
                              buttonApplicationRecord!.fechaUltimoPago!),
                        );
                        _shouldSetState = true;
                        if ((_model.zapSignAPIresponse?.succeeded ?? true)) {
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
                          if (_shouldSetState) setState(() {});
                          return;
                        }

                        if (_shouldSetState) setState(() {});
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

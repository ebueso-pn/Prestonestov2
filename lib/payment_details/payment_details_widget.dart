import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'payment_details_model.dart';
export 'payment_details_model.dart';

class PaymentDetailsWidget extends StatefulWidget {
  const PaymentDetailsWidget({Key? key}) : super(key: key);

  @override
  _PaymentDetailsWidgetState createState() => _PaymentDetailsWidgetState();
}

class _PaymentDetailsWidgetState extends State<PaymentDetailsWidget> {
  late PaymentDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentDetailsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: responsiveVisibility(
        context: context,
        desktop: false,
      )
          ? AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pop();
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 32,
                ),
              ),
              title: Text(
                'Realizar un Pago a tu Prestonesto',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/mortgage-loan.svg',
                      width: MediaQuery.sizeOf(context).width,
                      height: 230,
                      fit: BoxFit.contain,
                      alignment: Alignment(0, 0),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 8, 0, 0),
                          child: Text(
                            'Transferencia Banca en Línea',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Lexend Deca',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Icon(
                            Icons.wifi,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 4),
                      child: Text(
                        '1. Realiza una transferencia ACH a la siguiente cuenta: ',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(35, 12, 20, 0),
                          child: Text(
                            '• Banco: Banco Atlantida\n• Beneficiario: Prestonesto S.A. \n• Tipo de Cuenta: Cheques Lps. ',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(35, 0, 0, 4),
                          child: Text(
                            '• Numero de Cuenta: ',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        ),
                        AlignedTooltip(
                          content: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Haz clic aqui para copiar',
                                style: FlutterFlowTheme.of(context).bodyLarge,
                              )),
                          offset: 4,
                          preferredDirection: AxisDirection.down,
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 4,
                          tailBaseWidth: 24,
                          tailLength: 12,
                          waitDuration: Duration(milliseconds: 100),
                          showDuration: Duration(milliseconds: 1500),
                          triggerMode: TooltipTriggerMode.tap,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 0, 20, 4),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: '2010043157'));
                              },
                              child: Text(
                                '2010043157',
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 4),
                      child: Text(
                        '2. Añade tu DNI en la descripción para identificarte.',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 4),
                      child: Text(
                        '3. Tu pago será reflejado en un plazo de 3-5 días.',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchURL(
                            'https://bancatlan.hn/cobertura/agentes-atlantida/');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 8, 0, 0),
                            child: Text(
                              'Banco Atlantida o Agentes Atlantida',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Icon(
                              Icons.location_pin,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 4),
                      child: Text(
                        '1. Solicita al cajero o agente pagar tu Prestonesto',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 4),
                      child: Text(
                        '2. Muestra tu documento de identificacion (DNI) para identificarte',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 4),
                      child: Text(
                        '3. Realiza el pago en efectivo ',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_static_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:mapbox_search/mapbox_search.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'model.dart';
export 'model.dart';

import '/shared/services/auth_api.dart';
import '/shared/services/api_client.dart';
import '/shared/services/models/user_info.dart';

class DummyApplicationRecord {
  final int index;
  final String id;
  final DateTime dateApplied;
  final double monto;
  final int plazoMeses;
  final double cuota;

  DummyApplicationRecord({
    required this.index,
    required this.id,
    required this.dateApplied,
    required this.monto,
    required this.plazoMeses,
    required this.cuota,
  });
}

class ApplicationReviewPage extends StatefulWidget {
  const ApplicationReviewPage({
    Key? key,
  });

  @override
  _ApplicationReviewWidgetState createState() =>
      _ApplicationReviewWidgetState();
}

// Helper function to get user location as LatLng
LatLng getUserLocation(dynamic userInfo) {
  if (userInfo != null &&
      userInfo.location != null &&
      userInfo.location['latitude'] != null &&
      userInfo.location['longitude'] != null) {
        print('Latitude: ${userInfo.location['latitude']}');
        print('Longitude: ${userInfo.location['longitude']}');
    return LatLng(
      userInfo.location['latitude'] as double,
      userInfo.location['longitude'] as double,
    );
  } else {
    // Default to Tegucigalpa, Honduras
    return LatLng(14.0723, -87.1921);
  }
}

class _ApplicationReviewWidgetState extends State<ApplicationReviewPage> {
  late ApplicationReviewModel _model;
  late DateTime start;
  late DateTime end;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  UserInfo? _userInfo;
  bool _isLoadingUser = true;
  String? _userError;

  @override
  void initState() {
    super.initState();

    start = DateTime.now();

    _model = createModel(context, () => ApplicationReviewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    setState(() {
      _isLoadingUser = true;
      _userError = null;
    });

    try {
      final apiClient = await ApiClient.create();
      final authApi = AuthApi(apiClient);
      final userInfo = await authApi.fetchMe();
      setState(() {
        _userInfo = userInfo;
        _isLoadingUser = false;
      });
    } catch (e) {
      setState(() {
        _userError = 'Failed to load user info';
        _isLoadingUser = false;
      });
    }
  }

  Future<void> _onEnviarSolicitudPressed() async {

  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    if (_isLoadingUser) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_userError != null) {
      return Scaffold(
        body: Center(child: Text('$_userError')),
      );
    }

    if (_userInfo == null) {
      return const Scaffold(
        body: Center(child: Text('No user info found')),
      );
    }

    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                        child: Text(
                          'Revisemos tus datos',
                          style: FlutterFlowTheme.of(context).headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                        child: Builder(
                          builder: (context) {
                            // Dummy application record data
                            final contentApplicationRecord = DummyApplicationRecord(
                              index: 3,
                              id: "DUMMY123",
                              dateApplied: DateTime.now(),
                              monto: 10000,
                              plazoMeses: 12,
                              cuota: 900,
                            );
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                    child: Text(
                                      'Solicitante',
                                      style: FlutterFlowTheme.of(context).labelLarge.override(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primaryBtnText,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                2, 2, 2, 2),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: SvgPicture.asset(
                                                'assets/images/astronaut.svg',
                                                width: 44,
                                                height: 44,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      '${_userInfo!.firstName} ${_userInfo!.lastName}',
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  _userInfo!.email ?? '',
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color: FlutterFlowTheme.of(
                                                                context)
                                                            .accent1,
                                                      ),
                                                ),
                                                Text(
                                                  _userInfo!.phoneNumber ?? '',
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Solicitud',
                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Codigo de Aplicación',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        contentApplicationRecord.id,
                                        style:
                                            FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fecha',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        dateTimeFormat(
                                          'd/M/y',
                                          contentApplicationRecord.dateApplied,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        style:
                                            FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Monto',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        formatNumber(
                                          contentApplicationRecord.monto,
                                          formatType: FormatType.decimal,
                                          decimalType: DecimalType.automatic,
                                          currency: 'L ',
                                        ),
                                        style:
                                            FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Plazo',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        formatNumber(
                                          contentApplicationRecord.plazoMeses,
                                          formatType: FormatType.custom,
                                          format: '# meses',
                                          locale: '',
                                        ),
                                        style:
                                            FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Cuota Estimada',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        formatNumber(
                                          contentApplicationRecord.cuota,
                                          formatType: FormatType.decimal,
                                          decimalType: DecimalType.automatic,
                                          currency: 'L. ',
                                        ),
                                        style:
                                            FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Frecuencia de pagos',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        'Quincenales',
                                        style:
                                            FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total estimado',
                                        style:
                                            FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                      Text(
                                        formatNumber(
                                          contentApplicationRecord.cuota *
                                              contentApplicationRecord.plazoMeses *
                                              2,
                                          formatType: FormatType.custom,
                                          currency: 'L ',
                                          format: '#,###.#',
                                          locale: '',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                                    child: Text(
                                      'Dirección',
                                      style: FlutterFlowTheme.of(context).labelLarge.override(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  child: FlutterFlowStaticMap(
                                    location: getUserLocation(_userInfo),
                                    apiKey:
                                        'pk.eyJ1IjoiZWJ1ZXNvIiwiYSI6ImNsam5reTVkODE2eTYzaXFjdnNpOXJpcTUifQ.NeMkGQoCua8892U-YJbMPA',
                                    style: MapBoxStyle.Light,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    markerColor: FlutterFlowTheme.of(context).primary,
                                    zoom: 12,
                                    tilt: 0,
                                    rotation: 0,
                                  ),
                                ),

                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                child: FFButtonWidget(
                  onPressed: _onEnviarSolicitudPressed,
                  text: 'Enviar Solicitud',
                  options: FFButtonOptions(
                    width: 230,
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                            ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

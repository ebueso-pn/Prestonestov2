import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
export 'model.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);

  @override
  _ApplicationMapWidgetState createState() => _ApplicationMapWidgetState();
}

class _ApplicationMapWidgetState extends State<MapPage> {
  late ApplicationMapModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplicationMapModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
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

    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
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

    return SafeArea(child:GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: Stack(
                        children: [
                          Builder(builder: (context) {
                            // Use device location or default to Tegucigalpa, Honduras
                            final LatLng defaultLatLng = LatLng(14.0722758, -87.192136);
                            final LatLng markerLatLng = currentUserLocationValue ?? defaultLatLng;
                            return FlutterFlowGoogleMap(
                              controller: _model.googleMapsController,
                              onCameraIdle: (latLng) =>
                                  _model.googleMapsCenter = latLng,
                              initialLocation: _model.googleMapsCenter ??= markerLatLng,
                              markers: [
                                FlutterFlowMarker(
                                  markerLatLng.serialize(),
                                  markerLatLng,
                                ),
                              ],
                              markerColor: GoogleMarkerColor.red,
                              mapType: MapType.normal,
                              style: GoogleMapStyle.standard,
                              initialZoom: 15.0,
                              allowInteraction: true,
                              allowZoom: true,
                              showZoomControls: true,
                              showLocation: true,
                              showCompass: false,
                              showMapToolbar: true,
                              showTraffic: false,
                              centerMapOnMarkerTap: true,
                            );
                          }),
                          Align(
                            alignment: AlignmentDirectional(0.0, -0.06),
                            child: Icon(
                              Icons.location_pin,
                              color: Color(0xFFFF0412),
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Coloca el pin en la dirección exacta',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    FFButtonWidget(
                      isEnable: !_loading,
                      onPressed: () async {
                        print('Button pressed!');
                      },
                      text: 'Fijar Dirección',
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
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  /*
  Future<void> _handleFixAddressPressed() async {
    if (_loading) return;
    setState(() => _loading = true);

    await currentUserReference!.update(createUsersRecordData(
      latLong: _model.googleMapsCenter,
    ));

    if (currentUserDocument?.latLong != currentUserLocationValue) {
      FirebaseAnalytics.instance.logEvent(
        name: 'app_direccion_en_mapa',
      );
      FacebookAppEvents().logEvent(
        name: 'app_direccion_en_mapa',
      );
    }

    await widget.applicationRecieve!.update({
      'index': FieldValue.increment(1),
    });
    if (hasApplicationEnviada) {
      await widget.applicationRecieve!.update({
        'index': FieldValue.increment(2),
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
      return;
    }
    context.pushNamed(
      'Application_Carrousel',
      queryParameters: {
        'applicationRecieve': serializeParam(
          widget.applicationRecieve,
          ParamType.DocumentReference,
        ),
        'equifaxStatus': widget.equifaxStatus,
      }.withoutNulls,
    );
    setState(() => _loading = false);
  }
   */
}

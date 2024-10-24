import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'application_map_model.dart';
export 'application_map_model.dart';

class ApplicationMapWidget extends StatefulWidget {
  const ApplicationMapWidget({
    Key? key,
    required this.applicationRecieve,
  }) : super(key: key);

  final DocumentReference? applicationRecieve;

  @override
  _ApplicationMapWidgetState createState() => _ApplicationMapWidgetState();
}

class _ApplicationMapWidgetState extends State<ApplicationMapWidget> {
  late ApplicationMapModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

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

    List<ApplicationRecord> applicationRecord = [];
    queryApplicationRecord(
      parent: currentUserReference,
      queryBuilder: (applicationRecord) {
        return applicationRecord;
      },
    ).listen((event) {
      applicationRecord.addAll(event);
    });

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
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
                            'Identifica tu Dirección',
                            style: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
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
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: Stack(
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) => Builder(builder: (context) {
                              final _googleMapMarker =
                                  currentUserDocument?.latLong;
                              return FlutterFlowGoogleMap(
                                controller: _model.googleMapsController,
                                onCameraIdle: (latLng) =>
                                    _model.googleMapsCenter = latLng,
                                initialLocation: _model.googleMapsCenter ??=
                                    currentUserLocationValue!,
                                markers: [
                                  if (_googleMapMarker != null)
                                    FlutterFlowMarker(
                                      _googleMapMarker.serialize(),
                                      _googleMapMarker,
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
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, -0.06),
                            child: Icon(
                              Icons.location_pin,
                              color: Color(0xFFFF0412),
                              size: 40.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
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
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFF2AAF7A),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final progressBarApplicationRecord =
                                            snapshot.data!;
                                        return LinearPercentIndicator(
                                          percent: progressBarApplicationRecord
                                                  .index /
                                              5,
                                          lineHeight: 7.0,
                                          animation: true,
                                          progressColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBtnText,
                                          padding: EdgeInsets.zero,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
                    StreamBuilder(
                        initialData: applicationRecord,
                        stream: queryApplicationRecord(
                          parent: currentUserReference,
                          queryBuilder: (applicationRecord) {
                            return applicationRecord;
                            //return applicationRecord.where('status', isEqualTo: 'Enviada');
                          },
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ApplicationRecord>> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          bool hasApplicationEnviada =
                              snapshot.data!.any((e) => e.status == 'Enviada');
                          return FFButtonWidget(
                            onPressed: () async {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                latLong: _model.googleMapsCenter,
                              ));

                              if (currentUserDocument?.latLong !=
                                  currentUserLocationValue) {
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
                                  'index': FieldValue.increment(1),
                                });
                                context.pushNamed(
                                  'Application_Review',
                                  queryParameters: {
                                    'applicationRecieve': serializeParam(
                                      widget.applicationRecieve,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                                return;
                              }
                              context.pushNamed(
                                'Application_Carrousel',
                                queryParameters: {
                                  'applicationRecieve': serializeParam(
                                    widget.applicationRecieve,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
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
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

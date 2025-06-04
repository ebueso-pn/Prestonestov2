import '/flutter_flow/flutter_flow_static_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/lat_lng.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Static data for the profile
    final String profileName = 'Jane Doe';
    final String profileEmail = 'jane.doe@email.com';
    final String profilePhone = '+34 600 123 456';
    final String profileDni = '12345678X';
    final String profileBankAccount = 'ES9121000418450200051332';
    final LatLng? profileLatLng = LatLng(40.4168, -3.7038); // Madrid, Spain

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
          child: Text(
            'Perfil',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
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
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 16.0, 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (profileLatLng != null)
                          Flexible(
                            child: Container(
                              width: 90.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent2,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  width: 2.0,
                                ),
                              ),
                              child: FlutterFlowStaticMap(
                                location: profileLatLng,
                                apiKey:
                                    'pk.eyJ1IjoiZWJ1ZXNvIiwiYSI6ImNsam5reTVkODE2eTYzaXFjdnNpOXJpcTUifQ.NeMkGQoCua8892U-YJbMPA',
                                style: MapBoxStyle.Streets,
                                width: 300.0,
                                height: 500.0,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(0.0),
                                markerColor: Color(0xFFFF0412),
                                zoom: 14,
                                tilt: 0,
                                rotation: 0,
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                profileName,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Urbanist',
                                      fontSize: 16.0,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 2.0, 0.0, 0.0),
                                child: Text(
                                  profileEmail,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium,
                                ),
                              ),
                              Text(
                                profilePhone,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                              Text(
                                profileDni,
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium,
                              ),
                              Text(
                                profileBankAccount.maybeHandleOverflow(
                                  maxChars: 4,
                                  replacement: '…',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

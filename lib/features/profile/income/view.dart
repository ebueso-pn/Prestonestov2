import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';

import '/shared/widgets/top_bar.dart';
import '/services/application_service.dart';

import 'utils.dart';
import 'model.dart';
export 'model.dart';

class ProfileIncomePage extends StatefulWidget {
  @override
  _ProfileIncomeValidationWidgetState createState() =>
      _ProfileIncomeValidationWidgetState();
}

class _ProfileIncomeValidationWidgetState extends State<ProfileIncomePage>
    with TickerProviderStateMixin {
  late ProfileIncomeValidationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileIncomeValidationModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _handlePhotoUpload(BuildContext context) async {
    final selectedMedia = await selectMedia(
      mediaSource: MediaSource.photoGallery,
      multiImage: true,
    );
    if (selectedMedia != null &&
        selectedMedia
            .every((m) => validateFileFormat(m.storagePath, context))) {
      setState(() {
        _model.uploadedLocalFiles.addAll(
          selectedMedia.map((m) => FFUploadedFile(
                name: (m.filePath != null && m.filePath!.isNotEmpty)
                    ? p.basename(m.filePath!)
                    : m.storagePath.split('/').last,
                bytes: m.bytes,
                height: m.dimensions?.height,
                width: m.dimensions?.width,
                blurHash: m.blurHash,
              )),
        );
      });
      showUploadMessage(context, 'Fotos seleccionadas. Se subirán al guardar.');
    }
  }

  Future<void> _handlePdfUpload(BuildContext context) async {
    final selectedFiles = await selectFiles(
      allowedExtensions: ['pdf'],
      multiFile: true,
    );
    if (selectedFiles != null) {
      setState(() {
        _model.uploadedLocalFiles.addAll(
          selectedFiles.map((m) => FFUploadedFile(
                name: (m.filePath != null && m.filePath!.isNotEmpty)
                    ? p.basename(m.filePath!)
                    : m.storagePath.split('/').last,
                bytes: m.bytes,
              )),
        );
      });
      showUploadMessage(context, 'PDFs seleccionados. Se subirán al guardar.');
    }
  }

  Future<void> showUploadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.upload_file_rounded,
                color: Color(0xFF2fa77a),
                size: 48,
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2fa77a)),
                strokeWidth: 4,
              ),
              SizedBox(height: 32),
              Text(
                'Subiendo archivos...',
                style: FlutterFlowTheme.of(context).headlineSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    final filesToUpload = <Map<String, dynamic>>[];
    final filenames = <String>[];

    for (final file in _model.uploadedLocalFiles) {
      if (file.bytes != null) {
        filesToUpload.add({
          'bytes': file.bytes,
          'filename': file.name ?? 'file',
        });

        if (!filenames.contains(file.name ?? 'file')) {
          filenames.add(file.name ?? 'file');
        }
      }
    }

    if (filesToUpload.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡No hay archivos para guardar!',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Urbanist',
                  color: FlutterFlowTheme.of(context).error,
                ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    showUploadingDialog(context);

    try {
      final result = await ApplicationService.uploadFiles(
        files: filesToUpload,
        fileType: 'income',
      );

      if (result['success'] == true) {
        setState(() {
          _model.uploadedFileUrls = filenames;
          FFAppState().IngresosEnviados = true;
          FFAppState().userHasIncomeVerification = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Archivos guardados',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Urbanist',
                    color: FlutterFlowTheme.of(context).customColor1,
                  ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );

        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error al guardar archivos',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Urbanist',
                    color: FlutterFlowTheme.of(context).error,
                  ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } finally {
      Navigator.of(context, rootNavigator: true).pop(); // Always dismiss the modal
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? TopBar(
                title: 'Valida tus Ingresos',
                onBack: () => context.pop(),
                height: 50.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    child: Text(
                      'Sube tu captura de pantalla o documento escaneado',
                      style: FlutterFlowTheme.of(context).labelLarge,
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation2']!),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _handlePhotoUpload(context),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 500.0,
                        ),
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
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 32.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Sube tu captura de pantalla',
                                  textAlign: TextAlign.center,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation1']!),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _handlePdfUpload(context),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 500.0,
                        ),
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
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.add_chart,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 32.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Sube tu archivo (PDF)',
                                  textAlign: TextAlign.center,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation2']!),
                  ),
                  Divider(
                    height: 40.0,
                    thickness: 3.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ).animateOnPageLoad(
                      animationsMap['dividerOnPageLoadAnimation']!),
                  Builder(builder: (context) {
                    // List all selected files (images and PDFs together)
                    if (_model.uploadedLocalFiles.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Archivos seleccionados:',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          ..._model.uploadedLocalFiles.map((file) {
                            final isPdf = (file.name?.toLowerCase().endsWith('.pdf') ?? false);
                            return ListTile(
                              leading: isPdf ? Icon(Icons.picture_as_pdf) : Icon(Icons.image),
                              title: Text(file.name ?? 'archivo'),
                              trailing: file.bytes != null
                                  ? IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () async {
                                        if (isPdf) {
                                          // Write bytes to a temp file and preview as PDF
                                          final tempDir = await getTemporaryDirectory();
                                          final tempFile = File('${tempDir.path}/${file.name ?? 'temp.pdf'}');
                                          await tempFile.writeAsBytes(file.bytes!);
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              child: SizedBox(
                                                height: 400,
                                                child: FlutterFlowPdfViewer(
                                                  filePath: tempFile.path,
                                                  height: 400,
                                                  horizontalScroll: false,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          // Preview image
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              child: SizedBox(
                                                height: 400,
                                                child: Image.memory(
                                                  file.bytes!,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )
                                  : null,
                            );
                          }),
                        ],
                      );
                    }
                    // If no files, show placeholder
                    return ClipRRect(
                      child: Image.asset(
                            'assets/images/income_validation.jpeg',
                            width: double.infinity,
                            height: 350.0,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
          child: FFButtonWidget(
            onPressed: () => _handleSave(context),
            text: 'Guardar y regresar',
            options: FFButtonOptions(
              width: double.infinity,
              height: 50.0,
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
          ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}

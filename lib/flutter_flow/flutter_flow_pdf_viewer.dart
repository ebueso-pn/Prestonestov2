import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class FlutterFlowPdfViewer extends StatefulWidget {
  const FlutterFlowPdfViewer({
    Key? key,
    this.networkPath,
    this.assetPath,
    this.filePath,
    this.width,
    this.height,
    this.horizontalScroll = false,
  })  : assert(
          (networkPath != null ? 1 : 0) +
                  (assetPath != null ? 1 : 0) +
                  (filePath != null ? 1 : 0) ==
              1,
          'Exactly one of networkPath, assetPath, or filePath must be provided.',
        ),
        super(key: key);

  final String? networkPath;
  final String? assetPath;
  final String? filePath;
  final double? width;
  final double? height;
  final bool horizontalScroll;

  @override
  _FlutterFlowPdfViewerState createState() => _FlutterFlowPdfViewerState();
}

class _FlutterFlowPdfViewerState extends State<FlutterFlowPdfViewer> {
  PdfController? controller;
  String get networkPath => widget.networkPath ?? '';
  String get assetPath => widget.assetPath ?? '';
  String get filePath => widget.filePath ?? '';

  void initializeController() {
    if (assetPath.isNotEmpty) {
      controller = PdfController(
        document: PdfDocument.openAsset(assetPath),
      );
    } else if (filePath.isNotEmpty) {
      controller = PdfController(
        document: PdfDocument.openFile(filePath),
      );
    } else if (networkPath.isNotEmpty) {
      controller = PdfController(
        document: PdfDocument.openData(InternetFile.get(networkPath)),
      );
    } else {
      controller = null;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  @override
  void didUpdateWidget(FlutterFlowPdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.networkPath != widget.networkPath) {
      initializeController();
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        width: widget.width,
        height: widget.height,
        child: controller != null
            ? PdfView(
                controller: controller!,
                scrollDirection:
                    widget.horizontalScroll ? Axis.horizontal : Axis.vertical,
                builders: PdfViewBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  documentLoaderBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  pageLoaderBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  errorBuilder: (_, __) => Container(),
                ),
              )
            : Container(),
      );
}

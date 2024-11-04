import 'dart:async';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:prestonesto/backend/backend.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_icon_button.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ApplicationCarrouselWidget extends StatefulWidget {
  const ApplicationCarrouselWidget(
      {Key? key, required this.applicationRecieve, required this.equifaxStatus})
      : super(key: key);

  final DocumentReference? applicationRecieve;
  final String equifaxStatus;

  @override
  _ApplicationCarrouselWidgetState createState() =>
      _ApplicationCarrouselWidgetState();
}

class _ApplicationCarrouselWidgetState extends State<ApplicationCarrouselWidget>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  PageController _pageViewController = PageController();
  PageController _step1PageViewController = PageController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1200.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1200.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1200.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };
  late Timer _pageChangeTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoPageSwitch();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _step1PageViewController.dispose();
    _pageViewController.dispose();
    _pageChangeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  automaticallyImplyLeading: false,
                  actions: [],
                  leading: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
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
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.goNamed(
                            'Application_Map',
                            queryParameters: {
                              'applicationRecieve': serializeParam(
                                widget.applicationRecieve,
                                ParamType.DocumentReference,
                              ),
                              'equifaxStatus': widget.equifaxStatus,
                            }.withoutNulls,
                          );
                        }
                      },
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0.0,
                ),
              )
            : null,
        key: scaffoldKey,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 2.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x3416202A),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: StreamBuilder<ApplicationRecord>(
                    stream: ApplicationRecord.getDocument(
                        widget.applicationRecieve!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF2AAF7A),
                              ),
                            ),
                          ),
                        );
                      }
                      final progressBarApplicationRecord = snapshot.data!;
                      return LinearPercentIndicator(
                        percent: progressBarApplicationRecord.index / 6,
                        lineHeight: 7,
                        animation: true,
                        progressColor: FlutterFlowTheme.of(context).secondary,
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        padding: EdgeInsets.zero,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildStep0(context),
                    _buildStep1(context),
                    _buildStep2(context),
                    _buildStep3(context),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.7),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: smooth_page_indicator.SmoothPageIndicator(
                    controller: _pageViewController,
                    count: 4,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) async {
                      await _pageViewController.animateToPage(
                        i,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: smooth_page_indicator.ExpandingDotsEffect(
                      expansionFactor: 3.0,
                      spacing: 8.0,
                      radius: 16.0,
                      dotWidth: 35.0,
                      dotHeight: 8.0,
                      dotColor: Color(0xFFBDBDBD),
                      activeDotColor: Colors.white,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
              if (_currentPage == 3)
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 10.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await widget.applicationRecieve!.update({
                                    'index': FieldValue.increment(1),
                                  });
                                  context.pushNamed(
                                    'Application_UploadDocs',
                                    queryParameters: {
                                      'applicationRecieve': serializeParam(
                                        widget.applicationRecieve,
                                        ParamType.DocumentReference,
                                      ),
                                      'equifaxStatus': widget.equifaxStatus,
                                    }.withoutNulls,
                                  );
                                },
                                text: 'Continuar',
                                options: FFButtonOptions(
                                  width: 190.0,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(48.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (_currentPage != 3)
                SizedBox(
                  height: 70.0,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _startAutoPageSwitch() {
    _pageChangeTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentPage == 1) {
        int nextPage = _step1PageViewController.page!.toInt() + 1;

        if (nextPage >= 3) nextPage = 0;

        _step1PageViewController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  Widget _buildStep0(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
              child: AutoSizeText(
                '¡Ya casi terminamos!',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: FlutterFlowTheme.of(context).displayMedium.override(
                      fontFamily: 'Urbanist',
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: Text(
              'Verifiquemos tu información para completar el proceso',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
            ),
          ),
          Image.asset(
            'assets/images/business-success.png',
            width: 350.0,
            height: 350.0,
            fit: BoxFit.fill,
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation1']!),
    );
  }

  Widget _buildStep1(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: AutoSizeText(
              'Compártenos documentación para comprobar tus ingresos',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    lineHeight: 0.8,
                  ),
            ),
          ),
          Center(
            child: Lottie.asset(
              'assets/lottie_animations/comprobante_ingresos_lottie.json',
              width: 300.0,
              height: 300.0,
              fit: BoxFit.fill,
              animate: true,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildInfoImage(context, 'assets/images/constancia_de_trabajo.png',
              'Constancia de trabajo'),
          const SizedBox(height: 13.0),
          _buildInfoImage(
              context, 'assets/images/voucher_de_pago.png', 'Voucher de pago'),
          const SizedBox(height: 13.0),
          _buildInfoImage(context, 'assets/images/extracto_bancario.png',
              'Extracto bancario'),
          const SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 15.0, 0.0),
            child: Text(
              'U otra documentación que nos permita verificar tus ingresos mensuales',
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation2']!),
    );
  }

  Widget _buildStep3(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: AutoSizeText(
              'Completa tu evaluación personal',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
          Lottie.asset(
            'assets/lottie_animations/elearning-platform.json',
            width: 350.0,
            height: 350.0,
            fit: BoxFit.fill,
            animate: true,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: AutoSizeText(
              'Es muy fácil! No es necesario tener información a la mano o preparate antes.\n\n Una vez inicies tendaras 24 horas para terminarla.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
    );
  }

  Widget _buildStep2(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: AutoSizeText(
              'Compártenos el número de tu cuenta bancaria',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Lottie.asset(
            'assets/lottie_animations/financial-planning.json',
            width: 350.0,
            height: 350.0,
            fit: BoxFit.fill,
            animate: true,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 15.0, 0.0),
            child: Text(
              'Si todo se ve bien y tu prestamo es aprobado, tu desembolso se enviará a tu cuenta',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
    );
  }

  Widget _buildInfoImage(BuildContext context, String imagePath, String title) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(title),
                content: Image.asset(imagePath),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar'),
                  ),
                ],
              );
            });
      },
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.0,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(Icons.info_outline, color: Colors.white, size: 20.0),
          ]),
    );
  }
}

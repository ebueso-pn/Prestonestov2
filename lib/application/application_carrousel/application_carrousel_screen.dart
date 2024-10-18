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
  final String? equifaxStatus;

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
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
                        context.pop();
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
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: PageView(
                  controller: _pageViewController,
                  scrollDirection: Axis.horizontal,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
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
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
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
                                context.pushNamed(
                                  'Application_UploadDocs',
                                  queryParameters: {
                                    'applicationRecieve': serializeParam(
                                      widget.applicationRecieve,
                                      ParamType.DocumentReference,
                                    ),
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
            ],
          ),
        ),
      ),
    );
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
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
              child: AutoSizeText(
                'Estás a tres pasos de completar tu solicitud!',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: FlutterFlowTheme.of(context).displayMedium.override(
                      fontFamily: 'Urbanist',
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
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
              'Documentación para comprobar tus ingresos',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 15.0, 0.0),
            child: Text(
              'Estos pueden ser:',
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
            ),
          ),
          SizedBox(
            height: 350.0,
            child: PageView(
              controller: _step1PageViewController,
              children: [
                Image.asset(
                  'assets/images/Paso_1_carousel_1.png',
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/images/Paso_1_carousel_2.png',
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/images/Paso_1_carousel_3.png',
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.7),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 20.0),
              child: smooth_page_indicator.SmoothPageIndicator(
                controller: _step1PageViewController,
                count: 3,
                axisDirection: Axis.horizontal,
                onDotClicked: (i) async {
                  await _step1PageViewController.animateToPage(
                    i,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                effect: smooth_page_indicator.SlideEffect(
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 15.0, 0.0),
            child: Text(
              'Para cualquiera de estos, es necesario que su nombre completo sea legible en el documento.',
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation2']!),
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
              'Completa tu evaluación personal',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
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
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
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
              'Compártenos el número de tu cuenta de banco',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 15.0, 0.0),
            child: Text(
              '(donde desenbolsaremos tu crédito si eres aprobado)',
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 16.0,
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
              'Y Listo! \n Una vez termines estos 3 pasos, tendrás respuesta a tu solicitud en menos de 24 horas hábiles.',
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation3']!),
    );
  }
}

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'application_name_model.dart';
export 'application_name_model.dart';

class ApplicationNameWidget extends StatefulWidget {
  const ApplicationNameWidget({
    Key? key,
    required this.applicationRecieve,
  }) : super(key: key);

  final DocumentReference? applicationRecieve;

  @override
  _ApplicationNameWidgetState createState() => _ApplicationNameWidgetState();
}

class _ApplicationNameWidgetState extends State<ApplicationNameWidget>
    with TickerProviderStateMixin {
  late ApplicationNameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-60.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 60.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  final List<DropdownMenuItem> ingresoMenusal = List.generate(
      46,
      (index) => DropdownMenuItem(
          value: 5000 + index * 1000,
          child: index == 45
              ? Text('+${5000 + index * 1000}')
              : Text('${5000 + index * 1000}')));
  int selectedValue = 5000;

  final Map<String, bool> earningTypes = {
    'Salario': false,
    'Negocio propio': false,
    'Remesas': false,
    'Otros': false,
  };
  String? earningTypeError;

  bool hasBankAccount = false;
  bool hasGrantedCreditHistory = false;
  String? hasGrantedCreditHistoryError;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplicationNameModel());

    _model.nombresController ??= TextEditingController();
    _model.apellidosController ??= TextEditingController();
    _model.dniController ??= TextEditingController();
    _model.ingresosController ??= TextEditingController();
    _model.ingresosController.text = selectedValue.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userData =
          await UsersRecord.collection.doc(currentUserReference!.id).get();
      try {
        _model.dniController.text = userData.get('DNI');
      } catch (e) {
        _model.dniController.text = '';
      }
      try {
        _model.apellidosController.text = userData.get('apellidos');
      } catch (e) {
        _model.apellidosController.text = '';
      }
      try {
        _model.nombresController.text = userData.get('nombres');
      } catch (e) {
        _model.nombresController.text = '';
      }

      setState(() {});
    });
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? PreferredSize(
                preferredSize: Size.fromHeight(110.0),
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            'Nombre',
                            style: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color(0x3416202A),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                          ),
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF2AAF7A),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final progressBarApplicationRecord =
                                  snapshot.data!;
                              return LinearPercentIndicator(
                                percent: progressBarApplicationRecord.index / 5,
                                lineHeight: 7.0,
                                animation: true,
                                progressColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                padding: EdgeInsets.zero,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child:
                      Wrap(alignment: WrapAlignment.start, children: <Widget>[
                    Text(
                      'Como esta escrito en tu DNI. \nNecesitamos tu nombre para verificar tu identidad.',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyLarge,
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation']!),
                  ]),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: TextFormField(
                            controller: _model.nombresController,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.nombresController',
                              Duration(milliseconds: 100),
                              () async {
                                if (_model.nombresController.text != null &&
                                    _model.nombresController.text != '') {
                                  setState(() {
                                    FFAppState().nombresApplicationState =
                                        false;
                                  });
                                } else {
                                  setState(() {
                                    FFAppState().nombresApplicationState = true;
                                  });
                                }
                              },
                            ),
                            onFieldSubmitted: (_) async {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                nombres: _model.nombresController.text,
                              ));
                            },
                            autofocus: true,
                            textCapitalization: TextCapitalization.words,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nombres',
                              labelStyle:
                                  FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Juan Pablo',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    fontStyle: FontStyle.italic,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FFAppState().nombresApplicationState
                                      ? FlutterFlowTheme.of(context).error
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FFAppState().nombresApplicationState
                                      ? FlutterFlowTheme.of(context).error
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.name,
                            validator: _model.nombresControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: TextFormField(
                          controller: _model.apellidosController,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.apellidosController',
                            Duration(milliseconds: 100),
                            () async {
                              if (_model.apellidosController.text != null &&
                                  _model.apellidosController.text != '') {
                                setState(() {
                                  FFAppState().apellidosApplicationState =
                                      false;
                                });
                              } else {
                                setState(() {
                                  FFAppState().apellidosApplicationState = true;
                                });
                              }
                            },
                          ),
                          onFieldSubmitted: (_) async {
                            await currentUserReference!
                                .update(createUsersRecordData(
                              apellidos: _model.apellidosController.text,
                            ));
                          },
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Apellidos',
                            labelStyle: FlutterFlowTheme.of(context).labelLarge,
                            hintText: 'Perez Gomez',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().apellidosApplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().apellidosApplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          validator: _model.apellidosControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: TextFormField(
                          controller: _model.dniController,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.dniController',
                            Duration(milliseconds: 100),
                            () async {
                              if (_model.dniController.text != null &&
                                  _model.dniController.text != '') {
                                setState(() {
                                  FFAppState().DNIapplicationState = false;
                                });
                              } else {
                                setState(() {
                                  FFAppState().DNIapplicationState = true;
                                });
                              }
                            },
                          ),
                          onFieldSubmitted: (_) async {
                            await currentUserReference!
                                .update(createUsersRecordData(
                              dni: '',
                            ));
                          },
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Documento Nacional de Identidad (DNI)',
                            labelStyle: FlutterFlowTheme.of(context).labelLarge,
                            hintText: '0801-1989-00000',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().DNIapplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().DNIapplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          validator: _model.dniControllerValidator
                              .asValidator(context),
                          inputFormatters: [_model.dniMask],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.0, 0, 16.0, 0),
                          child: Text('Ingreso promedio mensual',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0, 16.0, 16.0),
                          child: Text(
                            'El cual nos pueda comprobar',
                            style: TextStyle(
                                color: Color(0xFF757575), fontSize: 12),
                          )),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: SizedBox(
                          height: 60,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Selecciona un valor',
                              labelStyle:
                                  FlutterFlowTheme.of(context).labelMedium,
                              hintText: selectedValue.toString(),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    fontStyle: FontStyle.italic,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<dynamic>(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                            0.5 -
                                        60),
                                isExpanded: true,
                                value: selectedValue,
                                items: ingresoMenusal,
                                hint: Text(
                                  selectedValue.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                onChanged: (dynamic value) {
                                  setState(() {
                                    selectedValue = value;
                                    _model.ingresosController.text =
                                        selectedValue.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.0, 0, 16.0, 0),
                          child: Text('Fuente principal de ingresos',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0, 16.0, 16.0),
                          child: Text(
                            'Seleccione las que apliquen',
                            style: TextStyle(
                                color: Color(0xFF757575), fontSize: 12),
                          )),
                      SizedBox(
                        height: 120,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 4),
                          itemCount: 4,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0, 16.0, 16.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  setState(() {
                                    earningTypes[
                                        earningTypes.keys
                                            .elementAt(index)] = !earningTypes[
                                        earningTypes.keys.elementAt(index)]!;
                                    earningTypeError = null;
                                  });
                                },
                                text: earningTypes.keys.elementAt(index),
                                options: FFButtonOptions(
                                  width: 80.0,
                                  color: earningTypes[
                                          earningTypes.keys.elementAt(index)]!
                                      ? FlutterFlowTheme.of(context).primary
                                      : Colors.black,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.white,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      earningTypeError != null
                          ? Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0, 16.0, 16.0),
                              child: Text(
                                earningTypeError!,
                                style: TextStyle(
                                    color: FlutterFlowTheme.of(context).error,
                                    fontSize: 12),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0, 16.0, 16.0),
                          child: Text('Tiene una cuenta bancaria a su nombre?',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                              text: 'Si',
                              onPressed: () {
                                setState(() {
                                  hasBankAccount = true;
                                });
                              },
                              options: FFButtonOptions(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    32,
                                color: hasBankAccount
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.black,
                                textStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.white,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              )),
                          const SizedBox(width: 32),
                          FFButtonWidget(
                              text: 'No',
                              onPressed: () {
                                setState(() {
                                  hasBankAccount = false;
                                });
                              },
                              options: FFButtonOptions(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    32,
                                color: !hasBankAccount
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.black,
                                textStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.white,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              )),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Text(
                              'Autoriza a Prestonesto a revisar su historial crediticio en el Buró de Crédito?',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0, 16.0, 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                                text: 'Si',
                                onPressed: () {
                                  setState(() {
                                    hasGrantedCreditHistory =
                                        !hasGrantedCreditHistory;

                                    hasGrantedCreditHistoryError = null;
                                  });
                                },
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          32,
                                  color: hasGrantedCreditHistory
                                      ? FlutterFlowTheme.of(context).primary
                                      : Colors.black,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.white,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      hasGrantedCreditHistoryError != null
                          ? Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0, 16.0, 16.0),
                              child: Text(
                                hasGrantedCreditHistoryError!,
                                style: TextStyle(
                                    color: FlutterFlowTheme.of(context).error,
                                    fontSize: 12),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ).animateOnPageLoad(
                      animationsMap['columnOnPageLoadAnimation']!),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_model.nombresController.text != null &&
                            _model.nombresController.text != '') {
                          setState(() {
                            FFAppState().nombresApplicationState = false;
                          });
                        } else {
                          setState(() {
                            FFAppState().nombresApplicationState = true;
                          });
                        }

                        if (_model.apellidosController.text != null &&
                            _model.apellidosController.text != '') {
                          setState(() {
                            FFAppState().apellidosApplicationState = false;
                          });
                        } else {
                          setState(() {
                            FFAppState().apellidosApplicationState = true;
                          });
                        }

                        if (_model.dniController.text != null &&
                            _model.dniController.text != '') {
                          setState(() {
                            FFAppState().DNIapplicationState = false;
                          });
                        } else {
                          setState(() {
                            FFAppState().DNIapplicationState = true;
                          });
                        }

                        if (_model.ingresosController.text != null &&
                            _model.ingresosController.text != '' &&
                            _model.ingresosController.text.length > 3) {
                          try {
                            double.parse(_model.ingresosController.text);
                            setState(() {
                              FFAppState().ingresoss = false;
                            });
                          } catch (e) {
                            setState(() {
                              FFAppState().ingresoss = true;
                            });
                          }
                          setState(() {
                            FFAppState().ingresoss = false;
                          });
                        } else {
                          setState(() {
                            FFAppState().ingresoss = true;
                          });
                        }

                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }
                        bool allFalse = true;
                        earningTypes.forEach((key, value) {
                          if (value) {
                            allFalse = false;
                          }
                        });
                        if (allFalse) {
                          setState(() {
                            earningTypeError =
                                'Debes seleccionar al menos una fuente de ingresos';
                          });
                          return;
                        }

                        if (!hasGrantedCreditHistory) {
                          setState(() {
                            hasGrantedCreditHistoryError =
                                'Debes autorizar a Prestonesto a revisar tu historial crediticio para continuar';
                          });
                          return;
                        }

                        await currentUserReference!
                            .update(createUsersRecordData(
                          nombres: _model.nombresController.text,
                          apellidos: _model.apellidosController.text,
                          dni: (_model.dniController.text).replaceAll('-', ''),
                          ingresoMensual:
                              double.tryParse(_model.ingresosController.text),
                          hasBankAccount: hasBankAccount,
                          earningTypes: earningTypes.keys
                              .where((element) => earningTypes[element]!)
                              .toList(),
                          hasGrantedCreditHistory: hasGrantedCreditHistory,
                        ));

                        await widget.applicationRecieve!.update({
                          'index': FieldValue.increment(1),
                        });

                        FirebaseAnalytics.instance
                            .logEvent(name: 'app_ingresar_datos_basicos');
                        FacebookAppEvents().logEvent(
                          name: 'app_ingresar_datos_basicos',
                        );

                        context.pushNamed(
                          'Application_DNI_Validation',
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
                    ).animateOnPageLoad(
                        animationsMap['buttonOnPageLoadAnimation']!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

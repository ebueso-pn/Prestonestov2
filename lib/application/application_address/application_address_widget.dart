import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'application_address_model.dart';
export 'application_address_model.dart';

class ApplicationAddressWidget extends StatefulWidget {
  const ApplicationAddressWidget({
    Key? key,
    required this.applicationRecieve,
    required this.equifaxStatus,
  }) : super(key: key);

  final DocumentReference? applicationRecieve;
  final String? equifaxStatus;

  @override
  _ApplicationAddressWidgetState createState() =>
      _ApplicationAddressWidgetState();
}

class _ApplicationAddressWidgetState extends State<ApplicationAddressWidget>
    with TickerProviderStateMixin {
  late ApplicationAddressModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showChipsError = false;

  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 60),
          end: Offset(0, 0),
        ),
      ],
    ),
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-60, 0),
          end: Offset(0, 0),
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
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplicationAddressModel());

    _model.addressFieldCasaCalleController ??= TextEditingController();
    _model.addressFieldDescripcionController ??= TextEditingController();
    _model.addressFieldColoniaController ??= TextEditingController();
    _model.addressFieldCiudadController ??= TextEditingController();

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
                preferredSize: Size.fromHeight(100),
                child: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  automaticallyImplyLeading: false,
                  actions: [],
                  flexibleSpace: FlexibleSpaceBar(
                    title: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 50,
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await widget.applicationRecieve!.update({
                                      'index': FieldValue.increment(-(1)),
                                    });
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.goNamed(
                                        'Application_LoanCalculator',
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
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: Text(
                                  'Dirección',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.0,
                  ),
                  elevation: 2,
                ),
              )
            : null,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xFF2AAF7A),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final progressBarApplicationRecord =
                                    snapshot.data!;
                                return LinearPercentIndicator(
                                  percent:
                                      progressBarApplicationRecord.index / 6,
                                  lineHeight: 7,
                                  animation: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).primary,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  padding: EdgeInsets.zero,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 24),
                        child: Wrap(children: [
                          Text(
                            'Necesitamos tu dirección para validar tu identidad. ',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        ]),
                      ).animateOnPageLoad(
                          animationsMap['rowOnPageLoadAnimation']!),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Text(
                            'Tipo de Vivienda',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                            child: FlutterFlowChoiceChips(
                              options: [
                                ChipData('Propia', Icons.home),
                                ChipData('Alquiler', Icons.key),
                                ChipData('Familiar', Icons.family_restroom)
                              ],
                              onChanged: (val) {
                                setState(() {
                                  _model.choiceChipsValue = val?.first;
                                  _showChipsError = false;
                                });
                              },
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                elevation: 4,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              chipSpacing: 12,
                              rowSpacing: 12,
                              multiselect: false,
                              alignment: WrapAlignment.start,
                              controller: _model.choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_showChipsError)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '¿Tipo de Vivienda?',
                              style: TextStyle(
                                  color: FlutterFlowTheme.of(context).error,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: TextFormField(
                            controller: _model.addressFieldCasaCalleController,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.addressFieldCasaCalleController',
                              Duration(milliseconds: 100),
                              () async {
                                if (_model.addressFieldCasaCalleController
                                            .text !=
                                        null &&
                                    _model.addressFieldCasaCalleController
                                            .text !=
                                        '') {
                                  setState(() {
                                    FFAppState().ColoniaApplicationState =
                                        false;
                                  });
                                } else {
                                  setState(() {
                                    FFAppState().ColoniaApplicationState = true;
                                  });
                                }
                              },
                            ),
                            autofocus: true,
                            textCapitalization: TextCapitalization.words,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Numero de Casa y Calle',
                              labelStyle:
                                  FlutterFlowTheme.of(context).labelLarge,
                              hintText: '123 Calle Fransisco Morazan',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    fontStyle: FontStyle.italic,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FFAppState().CasayCalleApplicationState
                                      ? FlutterFlowTheme.of(context).error
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(42),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FFAppState().CasayCalleApplicationState
                                      ? FlutterFlowTheme.of(context).error
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(42),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(42),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(42),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.streetAddress,
                            validator: _model
                                .addressFieldCasaCalleControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: TextFormField(
                          controller: _model.addressFieldDescripcionController,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.addressFieldDescripcionController',
                            Duration(milliseconds: 100),
                            () => setState(() {}),
                          ),
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Descripción (opcional)',
                            labelStyle: FlutterFlowTheme.of(context).labelLarge,
                            hintText: 'Abajo del palo de mangos',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                          validator: _model
                              .addressFieldDescripcionControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: TextFormField(
                          controller: _model.addressFieldColoniaController,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.addressFieldColoniaController',
                            Duration(milliseconds: 100),
                            () async {
                              if (_model.addressFieldColoniaController.text !=
                                      null &&
                                  _model.addressFieldColoniaController.text !=
                                      '') {
                                setState(() {
                                  FFAppState().ColoniaApplicationState = false;
                                });
                              } else {
                                setState(() {
                                  FFAppState().ColoniaApplicationState = true;
                                });
                              }
                            },
                          ),
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Colonia o Barrio',
                            labelStyle: FlutterFlowTheme.of(context).labelLarge,
                            hintText: 'Las Lomas',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().ColoniaApplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().ColoniaApplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                          validator: _model
                              .addressFieldColoniaControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: TextFormField(
                          controller: _model.addressFieldCiudadController,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.addressFieldCiudadController',
                            Duration(milliseconds: 100),
                            () async {
                              if (_model.addressFieldCiudadController.text !=
                                      null &&
                                  _model.addressFieldCiudadController.text !=
                                      '') {
                                setState(() {
                                  FFAppState().CiudadApplicationState = false;
                                });
                              } else {
                                setState(() {
                                  FFAppState().CiudadApplicationState = true;
                                });
                              }
                            },
                          ),
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Ciudad',
                            labelStyle: FlutterFlowTheme.of(context).labelLarge,
                            hintText: 'Tegucigalpa',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().CiudadApplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FFAppState().CiudadApplicationState
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                          validator: _model
                              .addressFieldCiudadControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: FlutterFlowDropDown<String>(
                          controller: _model.dptoDropDownValueController ??=
                              FormFieldController<String>(null),
                          options: [
                            'Francisco Morazán',
                            'Cortés',
                            'Yoro',
                            'Atlántida',
                            'Olancho',
                            'Choluteca',
                            'Comayagua',
                            'El Paraíso',
                            'Santa Bárbara',
                            'Intibucá',
                            'La Paz',
                            'Lempira',
                            'Copán',
                            'Valle',
                            'Ocotepeque',
                            'Gracias a Dios',
                            'Islas de la Bahía',
                            'Colon'
                          ],
                          onChanged: (val) =>
                              setState(() => _model.dptoDropDownValue = val),
                          width: double.infinity,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Urbanist',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                          hintText: 'Departamento',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2,
                          borderRadius: 42,
                          margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                          hidesUnderline: true,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ),
                    ],
                  ).animateOnPageLoad(
                      animationsMap['columnOnPageLoadAnimation']!),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (_model.addressFieldCasaCalleController.text != null &&
                          _model.addressFieldCasaCalleController.text != '') {
                        setState(() {
                          FFAppState().nombresApplicationState = false;
                        });
                      } else {
                        setState(() {
                          FFAppState().nombresApplicationState = true;
                        });
                      }

                      if (_model.addressFieldColoniaController.text != null &&
                          _model.addressFieldColoniaController.text != '') {
                        setState(() {
                          FFAppState().apellidosApplicationState = false;
                        });
                      } else {
                        setState(() {
                          FFAppState().apellidosApplicationState = true;
                        });
                      }

                      if (_model.addressFieldCiudadController.text != null &&
                          _model.addressFieldCiudadController.text != '') {
                        setState(() {
                          FFAppState().DNIapplicationState = false;
                        });
                      } else {
                        setState(() {
                          FFAppState().DNIapplicationState = true;
                        });
                      }

                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate() ||
                          _model.choiceChipsValue == null) {
                        setState(() {
                          _showChipsError = true;
                        });
                        return;
                      } else {
                        setState(() {
                          _showChipsError = false;
                        });
                      }

                      if (_model.dptoDropDownValue == null) {
                        return;
                      }

                      await currentUserReference!.update(createUsersRecordData(
                        calle: _model.addressFieldCasaCalleController.text,
                        colonia: _model.addressFieldColoniaController.text,
                        ciudad: _model.addressFieldCiudadController.text,
                        departamento: _model.dptoDropDownValue,
                        residenceType: _model.choiceChipsValue,
                      ));

                      await widget.applicationRecieve!.update({
                        'index': FieldValue.increment(1),
                      });

                      FirebaseAnalytics.instance
                          .logEvent(name: 'app_ingresar_direccion');
                      FacebookAppEvents().logEvent(
                        name: 'app_ingresar_direccion',
                      );

                      context.pushNamed(
                        'Application_Map',
                        queryParameters: {
                          'applicationRecieve': serializeParam(
                            widget.applicationRecieve,
                            ParamType.DocumentReference,
                          ),
                          'equifaxStatus': widget.equifaxStatus,
                        }.withoutNulls,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        },
                      );
                    },
                    text: 'Continuar',
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
                  ).animateOnPageLoad(
                      animationsMap['buttonOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

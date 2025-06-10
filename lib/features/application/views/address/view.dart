import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'utils.dart';
import 'model.dart';
export 'model.dart';
import '/services/user_service.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({
    Key? key,
  }) : super(key: key);

  @override
  _ApplicationAddressWidgetState createState() =>
      _ApplicationAddressWidgetState();
}

class _ApplicationAddressWidgetState extends State<AddressPage>
    with TickerProviderStateMixin {
  late ApplicationAddressModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showChipsError = false;
  bool _loading = false;

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

  void _validateAddressFields() {}

  Future<void> _handleContinueButtonPressed() async {
    if (_loading) return;
    setState(() => _loading = true);

    _validateAddressFields();

    if (_model.formKey.currentState == null ||
        !_model.formKey.currentState!.validate() ||
        _model.choiceChipsValue == null) {
      setState(() {
        _showChipsError = true;
      });
      setState(() => _loading = false);
      return;
    } else {
      setState(() {
        _showChipsError = false;
      });
    }

    if (_model.dptoDropDownValue == null) {
      setState(() {
        _loading = false;
      });
      return;
    }

    // await widget.applicationRecieve!.update({'index': FieldValue.increment(1)});

    // Prepare address payload according to backend requirements
    // Translate chip value to backend enum
    String? housingType;
    switch (_model.choiceChipsValue) {
      case 'Propia':
        housingType = 'owned';
        break;
      case 'Alquiler':
        housingType = 'rented';
        break;
      case 'Familiar':
        housingType = 'family';
        break;
      default:
        housingType = '';
    }

    final addressPayload = {
      'housing_type': housingType,
      'house_and_street': _model.addressFieldCasaCalleController?.text ?? '',
      'description': _model.addressFieldDescripcionController?.text ?? '',
      'neighborhood': _model.addressFieldColoniaController?.text ?? '',
      'city': _model.addressFieldCiudadController?.text ?? '',
      'department': _model.dptoDropDownValue ?? '',
    };

    final result = await UserService.submitAddress(addressPayload);

    if (result['success'] == true) {
      context.pushNamed(
        'Map',
        extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.rightToLeft,
          ),
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error al guardar la dirección. Intenta de nuevo.')),
      );
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return SafeArea(
        child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(_model.unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: SafeArea(
                  top: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 32.0, bottom: 32.0),
                          child: Text(
                            'Validemos tu dirección',
                            style: FlutterFlowTheme.of(context).headlineMedium,
                          ).animateOnPageLoad(
                              animationsMap['rowOnPageLoadAnimation']!),
                        ),
                        Form(
                          key: _model.formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 8, 24, 16),
                                    child: FlutterFlowChoiceChips(
                                      options: [
                                        ChipData('Propia', Icons.home),
                                        ChipData('Alquiler', Icons.key),
                                        ChipData(
                                            'Familiar', Icons.family_restroom)
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          _model.choiceChipsValue = val?.first;
                                          _showChipsError = false;
                                        });
                                      },
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                        iconColor: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        iconSize: 18,
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      unselectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                        iconColor: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        iconSize: 18,
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      chipSpacing: 12,
                                      rowSpacing: 12,
                                      multiselect: false,
                                      alignment: WrapAlignment.start,
                                      controller:
                                          _model.choiceChipsValueController ??=
                                              FormFieldController<List<String>>(
                                        [],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_showChipsError)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, bottom: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '¿Tipo de Vivienda?',
                                      style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 16, 24, 16),
                                  child: TextFormField(
                                    controller:
                                        _model.addressFieldCasaCalleController,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.addressFieldCasaCalleController',
                                      Duration(milliseconds: 100),
                                      () async {
                                        if (_model
                                                .addressFieldCasaCalleController
                                                .text !=
                                            '') {
                                          setState(() {
                                            FFAppState()
                                                    .ColoniaApplicationState =
                                                false;
                                          });
                                        } else {
                                          setState(() {
                                            FFAppState()
                                                .ColoniaApplicationState = true;
                                          });
                                        }
                                      },
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Casa y Calle',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge,
                                      hintText:
                                          'Ejemplo: Casa #123, Calle Principal',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontStyle: FontStyle.italic,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FFAppState()
                                                  .ColoniaApplicationState
                                              ? FlutterFlowTheme.of(context)
                                                  .error
                                              : FlutterFlowTheme.of(context)
                                                  .alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(42),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FFAppState()
                                                  .ColoniaApplicationState
                                              ? FlutterFlowTheme.of(context)
                                                  .error
                                              : FlutterFlowTheme.of(context)
                                                  .alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(42),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(42),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(42),
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    textAlign: TextAlign.center,
                                    validator: _model
                                        .addressFieldCasaCalleControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 16, 24, 16),
                                child: TextFormField(
                                  controller:
                                      _model.addressFieldDescripcionController,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.addressFieldDescripcionController',
                                    Duration(milliseconds: 100),
                                    () => setState(() {}),
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Descripción (opcional)',
                                    labelStyle:
                                        FlutterFlowTheme.of(context).labelLarge,
                                    hintText: 'Abajo del palo de mangos',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontStyle: FontStyle.italic,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                  validator: _model
                                      .addressFieldDescripcionControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 16, 24, 16),
                                child: TextFormField(
                                  controller:
                                      _model.addressFieldColoniaController,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.addressFieldColoniaController',
                                    Duration(milliseconds: 100),
                                    () async {
                                      if (_model.addressFieldColoniaController
                                              .text !=
                                          '') {
                                        setState(() {
                                          FFAppState().ColoniaApplicationState =
                                              false;
                                        });
                                      } else {
                                        setState(() {
                                          FFAppState().ColoniaApplicationState =
                                              true;
                                        });
                                      }
                                    },
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Colonia o Barrio',
                                    labelStyle:
                                        FlutterFlowTheme.of(context).labelLarge,
                                    hintText: 'Las Lomas',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontStyle: FontStyle.italic,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFAppState()
                                                .ColoniaApplicationState
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFAppState()
                                                .ColoniaApplicationState
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                  validator: _model
                                      .addressFieldColoniaControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 16, 24, 16),
                                child: TextFormField(
                                  controller:
                                      _model.addressFieldCiudadController,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.addressFieldCiudadController',
                                    Duration(milliseconds: 100),
                                    () async {
                                      if (_model.addressFieldCiudadController
                                              .text !=
                                          '') {
                                        setState(() {
                                          FFAppState().CiudadApplicationState =
                                              false;
                                        });
                                      } else {
                                        setState(() {
                                          FFAppState().CiudadApplicationState =
                                              true;
                                        });
                                      }
                                    },
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Ciudad',
                                    labelStyle:
                                        FlutterFlowTheme.of(context).labelLarge,
                                    hintText: 'Tegucigalpa',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontStyle: FontStyle.italic,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFAppState()
                                                .CiudadApplicationState
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFAppState()
                                                .CiudadApplicationState
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(42),
                                    ),
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                  validator: _model
                                      .addressFieldCiudadControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 16, 24, 16),
                                child: FlutterFlowDropDown<String>(
                                  controller:
                                      _model.dptoDropDownValueController ??=
                                          FormFieldController<String>(null),
                                  options: hondurasDepartments,
                                  onChanged: (val) => setState(
                                      () => _model.dptoDropDownValue = val),
                                  width: double.infinity,
                                  height: 50,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                  hintText: 'Departamento',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  elevation: 2,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 2,
                                  borderRadius: 42,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16, 4, 16, 4),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                ),
                              ),
                            ],
                          ).animateOnPageLoad(
                              animationsMap['columnOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  )),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                child: FFButtonWidget(
                  isEnable: !_loading,
                  onPressed: _handleContinueButtonPressed,
                  text: 'Continuar',
                  options: FFButtonOptions(
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
            )));
  }
}

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/shared/widgets/animations/animations_map.dart';

import 'model.dart';
import 'service.dart';
export 'model.dart';

class BasicInformationWidget extends StatefulWidget {
  const BasicInformationWidget({
    Key? key,
  }) : super(key: key);

  @override
  _BasicInformationWidgetState createState() => _BasicInformationWidgetState();
}

class _BasicInformationWidgetState extends State<BasicInformationWidget>
    with TickerProviderStateMixin {
  late BasicInformationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final format = NumberFormat("###,###.###", "tr_TR");
  List<DropdownMenuItem> ingresoMenusal = [];
  int selectedValue = 5000;

  final Map<String, bool> earningTypes = {
    'Salario': false,
    'Negocio propio': false,
    'Remesas': false,
    'Otros': false,
  };
  String? earningTypeError;

  bool? hasBankAccount;
  bool hasGrantedCreditHistory = false;
  String? hasGrantedCreditHistoryError;
  String? hasSelectedBankAccountError;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BasicInformationModel());

    _model.nombresController ??= TextEditingController();
    _model.apellidosController ??= TextEditingController();
    _model.dniController ??= TextEditingController();
    _model.ingresosController ??= TextEditingController();
    _model.ingresosController.text = selectedValue.toString();

    ingresoMenusal = List.generate(
        46,
        (index) => DropdownMenuItem(
            value: 5000 + index * 1000,
            child: (index == 45)
                ? Text('HNL +${format.format(5000 + index * 1000)}')
                : Text('HNL ${format.format(5000 + index * 1000)}')));
  }

  String toDniFormat(String dni) {
    dni = dni.replaceAll('-', '');
    final firstFour = dni.substring(0, 4);
    final secondFour = dni.substring(4, 8);
    final lastFive = dni.substring(8);
    return '$firstFour-$secondFour-$lastFive';
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
      top: true,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 32.0, 16.0, 0.0),
                  child: Text(
                    'Tu información',
                    style: FlutterFlowTheme.of(context).headlineMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                  child:
                      Wrap(alignment: WrapAlignment.start, children: <Widget>[
                    Text(
                      'Como esta escrito en tu DNI.\nNecesitamos tu nombre para verificar tu identidad.',
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
                              16.0, 8.0, 16.0, 8.0),
                          child: TextFormField(
                            controller: _model.nombresController,
                            autofocus: true,
                            textCapitalization: TextCapitalization.words,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nombres',
                              labelStyle:
                                  FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Jose Francisco',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    fontStyle: FontStyle.italic,
                                  ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(42.0),
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
                            16.0, 8.0, 16.0, 8.0),
                        child: TextFormField(
                          controller: _model.apellidosController,
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Apellidos',
                            labelStyle: FlutterFlowTheme.of(context).labelLarge,
                            hintText: 'Morazán Quesada',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
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
                            16.0, 8.0, 16.0, 8.0),
                        child: TextFormField(
                          controller: _model.dniController,
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
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(42.0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 8.0),
                          child: Text('Ingreso promedio mensual',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0, 16.0, 0.0),
                          child: Text(
                            'El cual nos puedas comprobar',
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
                            'Seleccionar las que apliquen',
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
                                      : Colors.grey,
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
                          child: Text(
                              '¿Tienes una cuenta bancaria a tu nombre?',
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
                                  hasSelectedBankAccountError = null;
                                });
                              },
                              options: FFButtonOptions(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    32,
                                color: hasBankAccount == true
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.grey,
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
                                  hasSelectedBankAccountError = null;
                                });
                              },
                              options: FFButtonOptions(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    32,
                                color: hasBankAccount == false
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.grey,
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
                      hasSelectedBankAccountError != null
                          ? Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16, 16.0, 16.0),
                              child: Text(
                                hasSelectedBankAccountError!,
                                style: TextStyle(
                                    color: FlutterFlowTheme.of(context).error,
                                    fontSize: 12),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Text(
                              '¿Autorizas a Prestonesto a revisar su historial crediticio en el Buró de Crédito?',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0, 16.0, 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                  text: 'Si',
                                  onPressed: () {
                                    setState(() {
                                      hasGrantedCreditHistory =
                                          !hasGrantedCreditHistory;

                                      hasGrantedCreditHistoryError = null;
                                    });
                                  },
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    color: hasGrantedCreditHistory
                                        ? FlutterFlowTheme.of(context).primary
                                        : Colors.grey,
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
                            ),
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
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final result =
                            await BasicInformationService.processApplication(
                          ingresosController: _model.ingresosController!,
                          formKey: _model.formKey,
                          earningTypes: earningTypes,
                          setIngresosError: (bool hasError) {
                            setState(() {
                              FFAppState().ingresoss = hasError;
                            });
                          },
                          setEarningTypeError: (String? error) {
                            setState(() {
                              earningTypeError = error;
                            });
                          },
                          setBankAccountError: (String? error) {
                            setState(() {
                              hasSelectedBankAccountError = error;
                            });
                          },
                          setCreditHistoryError: (String? error) {
                            setState(() {
                              hasGrantedCreditHistoryError = error;
                            });
                          },
                          hasBankAccount: hasBankAccount,
                          hasGrantedCreditHistory: hasGrantedCreditHistory,
                        );

                        if (result) {
                          context.pushNamed(
                            'Application_DNI_Validation',
                            /*queryParameters: {
                              'applicationRecieve': serializeParam(
                                widget.applicationRecieve,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                            */
                          );
                        }
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

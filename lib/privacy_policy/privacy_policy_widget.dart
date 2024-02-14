import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'privacy_policy_model.dart';
export 'privacy_policy_model.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyWidgetState createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  late PrivacyPolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacyPolicyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
          context: context,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                    borderRadius: 30.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.safePop();
                    }),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    'Política de Privacidad ',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    'Última actualización: : 29 de agosto, 2023 ',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    'Reconocemos que tu privacidad es de suma importancia, y agradecemos la confianza que depositas en Prestonesto. Esta Política de Privacidad está diseñada para ayudarte a entender cómo recopilamos, utilizamos, compartimos y protegemos tus datos personales cuando utilizas nuestra aplicación móvil y sitio web para la solicitud de un crédito. La información personal privada no incluye aquella que esté disponible a través de fuentes públicas',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '1. Información que Recopilamos\nCuando utilizas nuestra aplicación, podemos recopilar información personal tuya, incluyendo, pero no limitada a:\n•\tTu nombre completo.\n•\tTu número de Documento Nacional de Identidad (DNI)\n•\tTu dirección de correo electrónico.\n•\tTu número de teléfono.\n•\tTu dirección residencial.\n•\tTu información financiera y crediticia, como ingresos, historial de crédito y otros datos necesarios para evaluar tu solicitud de crédito.\n',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '2. Uso de tu Información\nUtilizamos tu información personal para los siguientes fines:\n•\tProcesar tu solicitud de crédito y evaluar tu elegibilidad.\n•\tComunicarnos contigo en relación con tu solicitud de crédito.\n•\tMejorar nuestros servicios y productos.\n•\tEnviar comunicaciones de marketing si has dado tu consentimiento.\n•\tCumplir con las leyes y regulaciones aplicables.\n',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '3. Compartir tu Información\nSolo compartiremos tu información personal en las siguientes circunstancias:\n•\tCon terceros que sean necesarios para procesar tu solicitud de crédito.\n•\tCon entidades financieras que colaboren con nosotros en la evaluación de crédito.\n•\tCon tu consentimiento expreso para cualquier otro propósito.\n•\tCuando estemos obligados por ley a hacerlo.\n',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '4. Seguridad de tus Datos\nTomamos medidas de seguridad adecuadas para proteger tu información personal contra el acceso no autorizado o la divulgación.\nPrestonesto no asume responsabilidad por negligencia del usuario en cuanto a su propia protección de datos.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '5. Tus Derechos\nTienes derechos sobre tus datos personales, que incluyen el acceso, rectificación, eliminación y restricción de su procesamiento. Puedes ejercer estos derechos enviándonos una solicitud a hola@prestonesto.co.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '6. Cambios en esta Política de Privacidad\nPodemos actualizar esta Política de Privacidad ocasionalmente para reflejar cambios en nuestras prácticas de privacidad. Te notificaremos de cualquier cambio importante.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    '7. Contacto\nSi tienes alguna pregunta o preocupación sobre nuestra política de privacidad, contáctanos a través de hola@prestonesto.co.\nAl utilizar nuestra aplicación, aceptas esta Política de Privacidad. Si no estás de acuerdo con esta política, por favor, no utilices nuestra aplicación.\nGracias por confiar en nosotros con tus necesidades de crédito. Tu privacidad es importante para nosotros y estamos comprometidos en protegerla.\nAtentamente,\n\nPrestonesto S.A.\n',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Text(
                    'Última actualización: : 29 de agosto, 2023',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
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

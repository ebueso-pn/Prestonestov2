import 'package:prestonesto_shuftipro_sdk/prestonesto_shuftipro_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import '/services/user_service.dart';

import 'model.dart';
export 'model.dart';


String clientId = dotenv.env['SHUFTI_PRO_CLIENT_ID'] ?? ''; // load client id from env
String secretKey = dotenv.env['SHUFTI_PRO_SECRET_ID'] ?? ''; // load secret key from env

class KYCPage extends StatefulWidget {
  const KYCPage({
    Key? key,
  }) : super(key: key);

  @override
  _KYCPageState createState() => _KYCPageState();
}

class _KYCPageState extends State<KYCPage> {
  late KYCModel _model;
  var authObject = {
    "auth_type": "basic_auth",
    "client_id": clientId,
    "secret_key": secretKey,
  };

  Map<String, Object> createdPayload = {
    "country": "",
    "reference": "",
    // please send the Application Document reference available under the application receive parameter,
    "language": "ES",
    "verification_mode": "image_only",
    "allow_offline": "0",
    "show_results": 1,
    "face": {"allow_offline": "0"},
    "document": {
      "supported_types": [
        "id_card",
        "driving_license",
        "passport",
        "credit_or_debit_card",
      ],
      /* Keep name, dob, document_number, expiry_date, issue_date empty for with-OCR request*/
      "name": {
        "first_name": "",
        "last_name": "",
        "middle_name": "",
      },
      "dob": "",
      "document_number": "",
    },
  };

  Map<String, Object> configObj = {
    "open_webview": false,
    "asyncRequest": false,
    "captureEnabled": false,
    "dark_mode": false,
    "font_color": "#263B54",
    "button_text_color": "#FFFFFF",
    "button_background_color": "#2fa77a"
  };

  void _showErrorModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 48, // Tamaño personalizado del icono
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Lo sentimos, no fue posible verificar tu identidad en este momento, por lo que no podemos continuar con tu aplicación.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Si crees que esto fue un error, por favor comunícate con nosotros vía\n',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 24, // Tamaño personalizado del icono
                        ),
                      ),
                      TextSpan(
                        text: ' WhatsApp al +504-3311-5751.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Volver'),
            ),
          ],
        );
      },
    );
  }

  dynamic _handleEquifax() {
    return;
    /**
    () async {
      return;
      await EquifaxRecord.collection
          .doc()
          .set(createEquifaxRecordData(
            userDocReference: currentUserReference,
            applicationDocReference:
                _model.createdAppVar?.reference,
          ));
      final equifaxData = await EquifaxRecord.collection
          .where('UserDocReference',
              isEqualTo: currentUserReference)
          .where('ApplicationDocReference',
              isEqualTo: _model.createdAppVar?.reference)
          .get();
      final id = equifaxData.docs.first.id;
      String appStatus = '';
      try {
        final response =
            await ApiEquifaxCall.call(equifaxId: id);
        if (response.statusCode == 200) {
          appStatus = ApiEquifaxCall.equifaxStatus(
              response.jsonBody);
        } else {
          appStatus = 'CONTINUE_NO_SCORE';
        }
      } catch (e) {
        appStatus = 'CONTINUE_NO_SCORE';
      }

      if (appStatus == 'DENEGATE') {
        _model.createdAppVar?.reference.set(
          {'status': 'Denegada'},
          SetOptions(merge: true),
        );
        context.pushNamed('Application_Denied');
        return;
      }
      dynamic returnResult = await context.pushNamed(
        'Application_LoanCalculator',
        queryParameters: {
          'applicationRecieve': serializeParam(
            _model.createdAppVar?.reference,
            ParamType.DocumentReference,
          ),
          'equifaxStatus': appStatus,
        }.withoutNulls,
      );
      if (returnResult == "Refresh") {
        setState(() {
          _model.buttonDisplay = false;
        });
      }

    },
    **/
  }

  Future<void> startKYC() async {
    debugPrint('[DNI Validation] Starting ShuftiPro verification process...');
    String shuftiProRawResponse = '';
    try {
      debugPrint('[DNI Validation] Sending request to ShuftiPro...');
      shuftiProRawResponse = await ShuftiproSdk.sendRequest(
        authObject: authObject,
        createdPayload: createdPayload,
        configObject: configObj,
      );
      // shuftiProRawResponse

      debugPrint('[DNI Validation] Response received: $shuftiProRawResponse');
      // Placeholder for parsed response
      // VerificationResponse parsedVerificationResponse = verificationResponseFromJson(shuftiProRawResponse);
      final kycSubmissionResponse = await UserService.submitKyc(
        {
          "shufti_pro_response": shuftiProRawResponse,
          "application_reference": _model.createdAppVar?.reference,
        },
      );
      debugPrint('[DNI Validation] KYC submission response: $kycSubmissionResponse');
      // Use a placeholder map for now
      final verificationJson = {
        "status": "Iniciada",
        "date_applied": DateTime.now().toIso8601String(),
        "shufti_data": {
          "document_number": "12345678",
          "country": "AR",
          "document_type": "DNI",
          // Add more mock fields as needed
        },
        "verification_result": {
          "result": "accepted",
          "score": 0.98,
          // Add more mock fields as needed
        },
        "shufti_additional": "",
        "index": 1,
        // Add more fields as needed for your backend
      };

      // Print or log the JSON for inspection
      debugPrint('[DNI Validation] Verification JSON for endpoint: ${verificationJson.toString()}');

      // Here you would send `verificationJson` to your backend endpoint

      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(content: Text("Verification Success (Mocked)")),
      );

      setState(() {
        _model.buttonDisplay = true;
      });
      debugPrint('[DNI Validation] UI updated: buttonDisplay set to true.');
    } catch (e, stack) {
      debugPrint('[DNI Validation] Exception occurred: $e');
      debugPrint('[DNI Validation] Stack trace: $stack');
      _showErrorModal(context);
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    if (!mounted) {
      debugPrint('[DNI Validation] Widget no longer mounted. Exiting.');
      return;
    }
    debugPrint('[DNI Validation] ShuftiPro verification process completed.');
  }

  void continueFun() async {
    var v = DateTime.now();
    var reference = "package_sample_Flutter_$v";
    createdPayload["reference"] = reference;
    startKYC();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KYCModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.buttonDisplay = false;
      });
    });

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

    return SafeArea(
      top: true,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 0),
                  child: Text(
                    'Hora de tomarnos fotos',
                    style: FlutterFlowTheme.of(context).headlineMedium,
                  ),
                ),
                Center(
                  child: Lottie.asset(
                    'assets/lottie_animations/tmpo2dz_7be.json',
                    width: 350.0,
                    height: 350.0,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Builder(
                    builder: (context) {
                      if (_model.buttonDisplay == false) {
                        return FFButtonWidget(
                          onPressed: () {
                            continueFun();
                          },
                          text: 'Verificar mi identidad',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        );
                      } else {
                        return FFButtonWidget(
                          onPressed: _handleEquifax,
                          text: 'Continuar',
                          options: FFButtonOptions(
                            width: 194.0,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        );
                      }
                    },
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

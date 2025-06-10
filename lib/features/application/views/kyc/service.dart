import 'dart:convert';
import 'package:prestonesto_shuftipro_sdk/prestonesto_shuftipro_sdk.dart';
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/services/user_service.dart';
import '/shared/services/auth_api.dart';
import '/shared/services/api_client.dart';
import '/app/app_state.dart';

String clientId =
    dotenv.env['SHUFTI_PRO_CLIENT_ID'] ?? ''; // load client id from env
String secretKey =
    dotenv.env['SHUFTI_PRO_SECRET_ID'] ?? ''; // load secret key from env

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

var authObject = {
  "auth_type": "basic_auth",
  "client_id": clientId,
  "secret_key": secretKey,
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

/// Processes the KYC verification flow using ShuftiPro and submits the result to the backend.
///
/// [context] is required for showing dialogs and snackbars.
/// [model] is the KYCModel instance for updating UI state.
Future<void> processKyc({
  required BuildContext context,
  required dynamic model, // Use your actual KYCModel type if available
}) async {
  final now = DateTime.now();
  final reference = "package_sample_Flutter_$now";
  createdPayload["reference"] = reference;

  String shuftiProRawResponse = '';
  try {
    // debugPrint('[DNI Validation] Sending request to ShuftiPro...');
    // shuftiProRawResponse = await ShuftiproSdk.sendRequest(
    //   authObject: authObject,
    //   createdPayload: createdPayload,
    //   configObject: configObj,
    // );

    // debugPrint('[DNI Validation] Response received: $shuftiProRawResponse');
    // final parsedResponse = jsonDecode(shuftiProRawResponse);

    // Mocked response using good.json
    shuftiProRawResponse = '''
{
  "reference": "package_sample_Flutter_2025-06-07 21:51:48.527290",
  "country": "CO",
  "verification_data": {
    "document": {
      "name": {
        "first_name": "GABRIEL JESUS",
        "middle_name": null,
        "last_name": "GARCIA YEPES"
      },
      "dob": "2000-10-17",
      "document_number": "1041695822",
      "selected_type": ["id_card"],
      "supported_types": [
        "id_card",
        "driving_license",
        "passport",
        "credit_or_debit_card"
      ],
      "face_match_confidence": 70
    }
  },
  "verification_result": {
    "face": 1,
    "document": {
      "document": 1,
      "document_visibility": 1,
      "document_must_not_be_expired": 1,
      "document_proof": 1,
      "selected_type": 1,
      "document_country": 1,
      "face_on_document_matched": 1,
      "document_number": 1,
      "dob": 1,
      "name": 1
    }
  },
  "event": "verification.accepted",
  "email": null,
  "info": {
    "agent": {
      "is_desktop": false,
      "is_phone": true,
      "useragent": "Dalvik/2.1.0 (Linux; U; Android 15; CPH2581 Build/AP3A.240617.008)",
      "device_name": "0",
      "browser_name": "",
      "platform_name": "AndroidOS - 15"
    },
    "geolocation": {
      "host": "186.170.106.61",
      "ip": "186.170.106.61",
      "rdns": "186.170.106.61",
      "asn": "3816",
      "isp": "Colombia Telecomunicaciones s.a. Esp Bic",
      "country_name": "Colombia",
      "country_code": "CO",
      "region_name": "Atlantico",
      "region_code": "ATL",
      "city": "Barranquilla",
      "postal_code": "080001",
      "continent_name": "South America",
      "continent_code": "SA",
      "latitude": "10.968500137329",
      "longitude": "-74.781303405762",
      "metro_code": "",
      "timezone": "America/Bogota",
      "ip_type": "ipv4",
      "capital": "Bogotá",
      "currency": "COP"
    }
  }
}
    ''';

    final parsedResponse = jsonDecode(shuftiProRawResponse);

    // Show full-screen loading dialog while submitting KYC
    showDialog(
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
                Icons.verified_user_rounded,
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
                'Procesando, por favor espera...',
                style: TextStyle(
                  color: Color(0xFF263B54),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    final kycSubmissionResponse = await UserService.submitKyc(parsedResponse);

    // Hide loading dialog
    Navigator.of(context, rootNavigator: true).pop();

    if (kycSubmissionResponse['success'] == true) {
       // Refresh user info after successful KYC
       try {
         final apiClient = await ApiClient.create();
         final authApi = AuthApi(apiClient);
         final user = await authApi.fetchMe();
         FFAppState().currentUser = user;
       } catch (e) {
         debugPrint('Error refreshing user info after KYC: $e');
       }
       context.pushNamed("Calculator");
    } else {
       // Show error dialog with message from backend
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: Text('Verificación fallida'),
           content:
               Text(kycSubmissionResponse['message'] ?? 'Error desconocido'),
           actions: [
             TextButton(
               onPressed: () => Navigator.of(context).pop(),
               child: Text('OK'),
             ),
           ],
         ),
       );
     }

    debugPrint('[DNI Validation] UI updated: buttonDisplay set to true.');
  } catch (e, stack) {
    debugPrint('[DNI Validation] Exception occurred: $e');
    debugPrint('[DNI Validation] Stack trace: $stack');
    _showErrorModal(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
  debugPrint('[DNI Validation] ShuftiPro verification process completed.');
}

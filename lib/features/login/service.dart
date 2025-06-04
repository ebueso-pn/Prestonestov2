import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/services/auth_service.dart';
import '/auth/api_auth/models/api_auth_user.dart';
import '/shared/services/api_client.dart';
import '/shared/services/auth_api.dart';
import '/utils/show_error.dart';

Future<void> handleLoginPressed(
  BuildContext context,
  dynamic model,
) async {
  GoRouter.of(context).prepareAuthEvent();

  final result = await AuthService.loginUser(
    email: model.emailAddressController.text,
    password: model.passwordLoginController.text,
  );

  if (result['success'] != true) {
    final statusCode = result['status_code'];
    final error = result['error'] ?? '';
    if (statusCode == 401) {
      showErrorSnackbar(context, 'Correo o contraseña incorrectos');
    } else if (error == 'network') {
      showErrorSnackbar(context, 'Error de red. Intenta de nuevo.');
    } else {
      showErrorSnackbar(context, 'No se pudo iniciar sesión. Intenta de nuevo.');
    }
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', result['access_token']);
  await prefs.setString('refresh_token', result['refresh_token']);

  AppStateNotifier.instance.user = ApiAuthUser(
    email: model.emailAddressController.text,
    phoneNumber: '',
  );

  // Fetch and set FFAppState().currentUser here:
  try {
    final apiClient = await ApiClient.create();
    final authApi = AuthApi(apiClient);
    final user = await authApi.fetchMe();
    FFAppState().currentUser = user;
  } catch (e) {
    print('Error fetching user info after login: $e');
    // Optionally handle logout or error state here
  }

  context.goNamedAuth('Home', context.mounted);
}

void handleForgotPasswordPressed(BuildContext context) {
  context.pushNamed('Email_ForgotPassword');
}

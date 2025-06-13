import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/utils/show_error.dart';
import '/auth/api_auth/models/api_auth_user.dart';
import '/services/auth_service.dart';
import '/shared/services/api_client.dart';
import '/shared/services/auth_api.dart';

Future<void> handleCreateAccount(
  BuildContext context,
  dynamic model,
) async {
  if (model.passwordController.text != model.confirmPasswordController.text) {
    showErrorSnackbar(context, '¡Las contraseñas no coinciden!');
    return;
  }
  final dni = model.dniController.text.replaceAll('-', '');
  if (dni.isEmpty) {
    showErrorSnackbar(context, 'Por favor ingresa tu DNI');
    return;
  }

  final phoneNumber = sanitizePhoneNumber(model.phoneNumberController.text);

  final result = await AuthService.registerUser(
    email: model.emailAddressController.text,
    phoneNumber: phoneNumber,
    password: model.passwordController.text,
    idType: "dni",
    idNumber: dni,
  );

  if (result['success']) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', result['access_token']);
    await prefs.setString('refresh_token', result['refresh_token']);

    // Set user as logged in for navigation to work
    AppStateNotifier.instance.user = ApiAuthUser(
      email: model.emailAddressController.text,
      phoneNumber: phoneNumber,
    );

    // Fetch and set FFAppState().currentUser here:
    try {
      final apiClient = await ApiClient.create();
      final authApi = AuthApi(apiClient);
      final user = await authApi.fetchMe();
      FFAppState().currentUser = user;
    } catch (e) {
      print('Error fetching user info after registration: $e');
      // Optionally handle logout or error state here
    }

    if (context.mounted) {
      context.goNamedAuth('Home', context.mounted);
    }
  } else {
    final error = result['error'] ?? '';
    if (error.contains('email')) {
      showErrorSnackbar(context, 'El correo ya está registrado con otro usuario');
    } else if (error.contains('DNI')) {
      showErrorSnackbar(context, 'Tu DNI ya está registrado con otro usuario');
    } else if (error == 'network') {
      showErrorSnackbar(context, 'Error de red. Intenta de nuevo.');
    } else {
      showErrorSnackbar(context, 'No se pudo crear la cuenta. Intenta de nuevo.');
    }
  }
}

String sanitizePhoneNumber(String input) {
  String digits = input.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.startsWith('504')) {
    return '+504' + digits.substring(3);
  }
  return '+504' + digits;
}

import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _nombresApplicationState = false;
  bool get nombresApplicationState => _nombresApplicationState;
  set nombresApplicationState(bool _value) {
    _nombresApplicationState = _value;
  }

  bool _apellidosApplicationState = false;
  bool get apellidosApplicationState => _apellidosApplicationState;
  set apellidosApplicationState(bool _value) {
    _apellidosApplicationState = _value;
  }

  bool _DNIapplicationState = false;
  bool get DNIapplicationState => _DNIapplicationState;
  set DNIapplicationState(bool _value) {
    _DNIapplicationState = _value;
  }

  bool _CasayCalleApplicationState = false;
  bool get CasayCalleApplicationState => _CasayCalleApplicationState;
  set CasayCalleApplicationState(bool _value) {
    _CasayCalleApplicationState = _value;
  }

  bool _ColoniaApplicationState = false;
  bool get ColoniaApplicationState => _ColoniaApplicationState;
  set ColoniaApplicationState(bool _value) {
    _ColoniaApplicationState = _value;
  }

  bool _CiudadApplicationState = false;
  bool get CiudadApplicationState => _CiudadApplicationState;
  set CiudadApplicationState(bool _value) {
    _CiudadApplicationState = _value;
  }

  bool _ApplicationEnviada = false;
  bool get ApplicationEnviada => _ApplicationEnviada;
  set ApplicationEnviada(bool _value) {
    _ApplicationEnviada = _value;
  }

  bool _LoanCreado = false;
  bool get LoanCreado => _LoanCreado;
  set LoanCreado(bool _value) {
    _LoanCreado = _value;
  }

  bool _LoanFirmado = false;
  bool get LoanFirmado => _LoanFirmado;
  set LoanFirmado(bool _value) {
    _LoanFirmado = _value;
  }

  bool _LoanDesembolsado = false;
  bool get LoanDesembolsado => _LoanDesembolsado;
  set LoanDesembolsado(bool _value) {
    _LoanDesembolsado = _value;
  }

  bool _LoanLiquidado = false;
  bool get LoanLiquidado => _LoanLiquidado;
  set LoanLiquidado(bool _value) {
    _LoanLiquidado = _value;
  }

  bool _LoanAlDia = false;
  bool get LoanAlDia => _LoanAlDia;
  set LoanAlDia(bool _value) {
    _LoanAlDia = _value;
  }

  bool _LoanMora = false;
  bool get LoanMora => _LoanMora;
  set LoanMora(bool _value) {
    _LoanMora = _value;
  }

  bool _ApplicationAceptada = false;
  bool get ApplicationAceptada => _ApplicationAceptada;
  set ApplicationAceptada(bool _value) {
    _ApplicationAceptada = _value;
  }

  bool _ApplicationAprobada = false;
  bool get ApplicationAprobada => _ApplicationAprobada;
  set ApplicationAprobada(bool _value) {
    _ApplicationAprobada = _value;
  }

  String _ApplicationDenegada = '';
  String get ApplicationDenegada => _ApplicationDenegada;
  set ApplicationDenegada(String _value) {
    _ApplicationDenegada = _value;
  }

  bool _IngresosEnviados = false;
  bool get IngresosEnviados => _IngresosEnviados;
  set IngresosEnviados(bool _value) {
    _IngresosEnviados = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_util.dart';

import '/shared/services/models/user_info.dart';

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

  UserInfo? _currentUser;
  UserInfo? get currentUser => _currentUser;
  set currentUser(UserInfo? user) {
    _currentUser = user;
    notifyListeners();
  }

  DocumentReference<Object?>? _currentApplication = null;
  DocumentReference<Object?>? get currentApplication => _currentApplication;
  set currentApplication(DocumentReference<Object?>? _value) {
    _currentApplication = _value;
  }

  String? _currentEquifaxStatus = null;
  String? get currentEquifaxStatus => _currentEquifaxStatus;
  set currentEquifaxStatus(String? _value) {
    _currentEquifaxStatus = _value;
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

  bool _ingresoss = false;
  bool get ingresoss => _ingresoss;
  set ingresoss(bool _value) {
    _ingresoss = _value;
  }

  bool _userHasBankAccount = false;
  bool get userHasBankAccount => _userHasBankAccount;
  set userHasBankAccount(bool _value) {
    _userHasBankAccount = _value;
  }

  bool _userHasIncomeVerification = false;
  bool get userHasIncomeVerification => _userHasIncomeVerification;
  set userHasIncomeVerification(bool _value) {
    _userHasIncomeVerification = _value;
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

import 'package:flutter/material.dart';
import '/backend/backend.dart';
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

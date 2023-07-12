import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

double loanCalculator(
  double loanAmount,
  double interestRate,
  double loanTerm,
) {
  // loan payment calculator
  double monthlyInterestRate = interestRate! / 2;
  double termInMonths = loanTerm! * 2;
  double monthlyPayment = (loanAmount * monthlyInterestRate) /
      (1 - math.pow(1 + monthlyInterestRate, -termInMonths));
  return monthlyPayment;
}

bool appIneligible(DateTime dateApplied) {
  // if a date happened greater than three months ago return true, else false
  DateTime currentDate = DateTime.now();
  Duration difference = currentDate.difference(dateApplied);
  if (difference.inDays < 90) {
    return true;
  } else {
    return false;
  }
}

int numeroCuotas(double plazo) {
  // multiply plazo by 2
  return (plazo * 2).toInt();
}

DateTime fechaFirmaMas15(DateTime? fecha) {
  // add 15 days to fecha
  if (fecha != null) {
    return fecha.add(Duration(days: 15));
  } else {
    return DateTime.now().add(Duration(days: 15));
  }
}

DateTime fechaUltimoPago(
  DateTime fechaFrima,
  double plazo,
) {
  // add 30 days to a double
// add plazo in months to fechaFirma
  DateTime fechaUltimoPago =
      fechaFrima.add(Duration(days: (plazo * 30).toInt()));
  return fechaUltimoPago;
}

String montoEnLetras(double numero) {
  Map<double, String> numberTable = {
    1000.0: 'un',
    2000.0: 'dos',
    3000.0: 'tres',
    4000.0: 'cuatro',
    5000.0: 'cinco',
    6000.0: 'seis',
    7000.0: 'siete',
    8000.0: 'ocho',
    9000.0: 'nueve',
    10000.0: 'diez',
    11000.0: 'once',
    12000.0: 'doce',
    13000.0: 'trece',
    14000.0: 'catorce',
    15000.0: 'quince',
    16000.0: 'dieciséis',
    17000.0: 'diecisiete',
    18000.0: 'dieciocho',
    19000.0: 'diecinueve',
    20000.0: 'veinte',
    21000.0: 'veintiun',
    22000.0: 'veintidós',
    23000.0: 'veintitrés',
    24000.0: 'veinticuatro',
    25000.0: 'veinticinco',
    26000.0: 'veintiseis',
    27000.0: 'veintisiete',
    28000.0: 'veintiocho',
    29000.0: 'veintinueve',
    30000.0: 'treinta',
    // Add more number-text mappings as needed
  };

  double key = numero.floor().toDouble();
  String result = numberTable[key] ?? 'Número desconocido';

  return result;
}

String tasaEnLetras(double numero) {
  Map<double, String> numberTable = {
    0.02: 'dos',
    0.021: 'dos punto uno',
    0.022: 'dos punto dos',
    0.023: 'dos punto tres',
    0.024: 'dos punto cuatro',
    0.025: 'dos punto cinco',
    0.026: 'dos punto seis',
    0.027: 'dos punto siete',
    0.028: 'dos punto ocho',
    0.029: 'dos punto nueve',
    0.03: 'tres',
    0.031: 'tres punto uno',
    0.032: 'tres punto dos',
    0.033: 'tres punto tres',
    0.034: 'tres punto cuatro',
    0.035: 'tres punto cinco',
    0.036: 'tres punto seis',
    0.037: 'tres punto siete',
    0.038: 'tres punto ocho',
    0.039: 'tres punto nueve',
    0.04: 'cuatro',
    0.041: 'cuatro punto uno',
    0.042: 'cuatro punto dos',
    0.043: 'cuatro punto tres',
    0.044: 'cuatro punto cuatro',
    0.045: 'cuatro punto cinco',
    0.046: 'cuatro punto seis',
    0.047: 'cuatro punto siete',
    0.048: 'cuatro punto ocho',
    0.049: 'cuatro punto nueve',
    0.05: 'cinco',
    0.051: 'cinco punto uno',
    0.052: 'cinco punto dos',
    0.053: 'cinco punto tres',
    0.054: 'cinco punto cuatro',
    0.055: 'cinco punto cinco',
    // Add more number-text mappings as needed
  };
  String result = numberTable[numero] ?? 'Número desconocido';

  return result;
}

String diaEnLetras(DateTime fecha) {
  Map<int, String> numberTable = {
    1: 'primero',
    2: 'dos',
    3: 'tres',
    4: 'cuatro',
    5: 'cinco',
    6: 'seis',
    7: 'siete',
    8: 'ocho',
    9: 'nueve',
    10: 'diez',
    11: 'once',
    12: 'doce',
    13: 'trece',
    14: 'catorce',
    15: 'quince',
    16: 'dieciséis',
    17: 'diecisiete',
    18: 'dieciocho',
    19: 'diecinueve',
    20: 'veinte',
    21: 'veintiun',
    22: 'veintidós',
    23: 'veintitrés',
    24: 'veinticuatro',
    25: 'veinticinco',
    26: 'veintiseis',
    27: 'veintisiete',
    28: 'veintiocho',
    29: 'veintinueve',
    30: 'treinta',
    31: 'treinta y uno',
    // Add more day-number mappings as needed
  };

  int day = fecha.day;
  String result = numberTable[day] ?? 'Día desconocido';

  return result;
}

String mesEnLetras(DateTime fecha) {
  Map<int, String> numberTable = {
    1: 'enero',
    2: 'febrero',
    3: 'marzo',
    4: 'abril',
    5: 'mayo',
    6: 'junio',
    7: 'julio',
    8: 'agosto',
    9: 'septiembre',
    10: 'octubre',
    11: 'noviembre',
    12: 'diciembre',
  };

  int month = fecha.month;
  String result = numberTable[month] ?? 'Mes desconocido';

  return result;
}

String anoEnLetras(DateTime fecha) {
  Map<int, String> numberTable = {
    2023: 'dos mil veintitrés',
    2024: 'dos mil veinticuatro',
    2025: 'dos mil veinticinco',
    2026: 'dos mil veintiséis',
    2027: 'dos mil veintisiete',
    2028: 'dos mil veintiocho',
    2029: 'dos mil veintinueve',
    2030: 'dos mil treinta',
  };

  int year = fecha.year;
  String result = numberTable[year] ?? 'Año desconocido';

  return result;
}

String decimaltoPercent(double decimal) {
  // convet a decimal to a percent and format output as a percentage
  return (decimal * 100).toStringAsFixed(2) + '%';
}

String formatNumber(double number) {
  // format number with a comma and two decimals
  final formatter = NumberFormat('#,##0.00');
  return formatter.format(number);
}

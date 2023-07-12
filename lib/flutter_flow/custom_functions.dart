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

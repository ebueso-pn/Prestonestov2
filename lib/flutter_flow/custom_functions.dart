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

String appIneligible(DateTime dateApplied) {
  // compare if the date happned greater than three months ago, return false, else true
  DateTime currentDate = DateTime.now();
  Duration difference = currentDate.difference(dateApplied);
  if (difference.inDays > 90) {
    return 'false';
  } else {
    return 'true';
  }
}

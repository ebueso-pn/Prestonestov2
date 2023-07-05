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

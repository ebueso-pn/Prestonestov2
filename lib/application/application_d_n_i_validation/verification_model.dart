// To parse this JSON data, do
//
//     final verificationResponse = verificationResponseFromJson(jsonString);

import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) => VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) => json.encode(data.toJson());

class VerificationResponse {
  String? reference;
  String? verificationData;
  String? verificationResult;
  String? event;
  String error;
  String? body;
  String? verificationUrl;
  String declinedReason;
  String message;

  VerificationResponse({
    this.reference,
    this.verificationData,
    this.verificationResult,
    required this.event,
    required this.error,
    this.body,
    this.verificationUrl,
    required this.declinedReason,
    required this.message,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) => VerificationResponse(
    reference: json["reference"],
    verificationData: json["verification_data"],
    verificationResult: json["verification_result"],
    event: json["event"] ?? '',
    error: json["error"] ?? '',
    body: json["body"],
    verificationUrl: json["verification_url"],
    declinedReason: json["declined_reason"] ?? '',
    message: json["message"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "verification_data": verificationData,
    "verification_result": verificationResult,
    "event": event,
    "error": error,
    "body": body,
    "verification_url": verificationUrl,
    "declined_reason": declinedReason,
    "message": message,
  };
}

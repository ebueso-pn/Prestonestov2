// To parse this JSON data, do
//
//     final verificationResponse = verificationResponseFromJson(jsonString);

import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) =>
    VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) =>
    json.encode(data.toJson());

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

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      VerificationResponse(
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

VerificationDataResponseModel verificationDataResponseModelFromJson(
        String str) =>
    VerificationDataResponseModel.fromJson(json.decode(str));

String verificationDataResponseModelToJson(
        VerificationDataResponseModel data) =>
    json.encode(data.toJson());

class VerificationDataResponseModel {
  VerificationDataDocument? document;

  VerificationDataResponseModel({
    this.document,
  });

  factory VerificationDataResponseModel.fromJson(Map<String, dynamic> json) =>
      VerificationDataResponseModel(
        document: json["document"] == null
            ? null
            : VerificationDataDocument.fromJson(json["document"]),
      );

  Map<String, dynamic> toJson() => {
        "document": document?.toJson(),
      };
}

class VerificationDataDocument {
  List<String>? selectedType;
  List<String>? supportedTypes;
  int? faceMatchConfidence;

  VerificationDataDocument({
    this.selectedType,
    this.supportedTypes,
    this.faceMatchConfidence,
  });

  factory VerificationDataDocument.fromJson(Map<String, dynamic> json) =>
      VerificationDataDocument(
        selectedType: json["selected_type"] == null
            ? []
            : List<String>.from(json["selected_type"]!.map((x) => x)),
        supportedTypes: json["supported_types"] == null
            ? []
            : List<String>.from(json["supported_types"]!.map((x) => x)),
        faceMatchConfidence: json["face_match_confidence"],
      );

  Map<String, dynamic> toJson() => {
        "selected_type": selectedType == null
            ? []
            : List<dynamic>.from(selectedType!.map((x) => x)),
        "supported_types": supportedTypes == null
            ? []
            : List<dynamic>.from(supportedTypes!.map((x) => x)),
        "face_match_confidence": faceMatchConfidence,
      };
}

VerificationResultResponseModel verificationResultResponseModelFromJson(
        String str) =>
    VerificationResultResponseModel.fromJson(json.decode(str));

String verificationResultResponseModelToJson(
        VerificationResultResponseModel data) =>
    json.encode(data.toJson());

class VerificationResultResponseModel {
  int? face;
  VerificationResultDocument? document;

  VerificationResultResponseModel({
    this.face,
    this.document,
  });

  factory VerificationResultResponseModel.fromJson(Map<String, dynamic> json) =>
      VerificationResultResponseModel(
        face: json["face"],
        document: json["document"] == null
            ? null
            : VerificationResultDocument.fromJson(json["document"]),
      );

  Map<String, dynamic> toJson() => {
        "face": face,
        "document": document?.toJson(),
      };
}

class VerificationResultDocument {
  int? document;
  int? documentVisibility;
  int? documentMustNotBeExpired;
  dynamic documentProof;
  int? selectedType;
  int? documentCountry;
  int? faceOnDocumentMatched;

  VerificationResultDocument({
    this.document,
    this.documentVisibility,
    this.documentMustNotBeExpired,
    this.documentProof,
    this.selectedType,
    this.documentCountry,
    this.faceOnDocumentMatched,
  });

  factory VerificationResultDocument.fromJson(Map<String, dynamic> json) =>
      VerificationResultDocument(
        document: json["document"],
        documentVisibility: json["document_visibility"],
        documentMustNotBeExpired: json["document_must_not_be_expired"],
        documentProof: json["document_proof"],
        selectedType: json["selected_type"],
        documentCountry: json["document_country"],
        faceOnDocumentMatched: json["face_on_document_matched"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
        "document_visibility": documentVisibility,
        "document_must_not_be_expired": documentMustNotBeExpired,
        "document_proof": documentProof,
        "selected_type": selectedType,
        "document_country": documentCountry,
        "face_on_document_matched": faceOnDocumentMatched,
      };
}

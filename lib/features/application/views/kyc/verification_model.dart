// To parse this JSON data, do
//
//     final verificationResponse = verificationResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

VerificationResponse verificationResponseFromJson(String str) =>
    VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) =>
    json.encode(data.toJson());

class VerificationResponse {
  VerificationDataResponseModel? verificationData;
  VerificationResultResponseModel? verificationResult;
  dynamic email;
  String? country;
  String? event;
  Info? info;
  String? reference;
  String error;
  Map<String, dynamic>? body;
  String? verificationUrl;
  String declinedReason;
  String message;

  VerificationResponse({
    this.verificationData,
    this.verificationResult,
    this.email,
    this.country,
    this.event,
    this.info,
    this.reference,
    required this.error,
    this.body,
    this.verificationUrl,
    required this.declinedReason,
    required this.message,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      VerificationResponse(
        verificationData: json["verification_data"] == null
            ? null
            : Platform.isAndroid
                ? VerificationDataResponseModel.fromJson(
                    jsonDecode(json["verification_data"]),
                  )
                : VerificationDataResponseModel.fromJson(
                    json["verification_data"],
                  ),
        verificationResult: json["verification_result"] == null
            ? null
            : Platform.isAndroid
                ? VerificationResultResponseModel.fromJson(
                    jsonDecode(json["verification_result"]),
                  )
                : VerificationResultResponseModel.fromJson(
                    json["verification_result"],
                  ),
        email: json["email"],
        country: json["country"],
        event: json["event"],
        info: json["info"] == null
            ? null
            : Platform.isAndroid
                ? Info.fromJson(jsonDecode(json["info"]))
                : Info.fromJson(
                    json["verification_result"],
                  ),
        reference: json["reference"],
        error: json["error"] ?? '',
        body: json["body"] == null
            ? null
            : Platform.isAndroid
                ? jsonDecode(
                    json["body"],
                  )
                : json["body"],
        verificationUrl: json["verification_url"],
        declinedReason: json["declined_reason"] ?? '',
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "verification_data": verificationData?.toJson(),
        "verification_result": verificationResult?.toJson(),
        "email": email,
        "country": country,
        "event": event,
        "info": info?.toJson(),
        "reference": reference,
        "error": error,
        "body": body,
        "verification_url": verificationUrl,
        "declined_reason": declinedReason,
        "message": message,
      };
}

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
  Name? name;
  DateTime? dob;
  String? documentNumber;
  List<String>? selectedType;
  List<String>? supportedTypes;
  int? faceMatchConfidence;

  VerificationDataDocument({
    this.name,
    this.dob,
    this.documentNumber,
    this.selectedType,
    this.supportedTypes,
    this.faceMatchConfidence,
  });

  factory VerificationDataDocument.fromJson(Map<String, dynamic> json) =>
      VerificationDataDocument(
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        documentNumber: json["document_number"] ?? '',
        selectedType: json["selected_type"] == null
            ? []
            : List<String>.from(json["selected_type"]!.map((x) => x)),
        supportedTypes: json["supported_types"] == null
            ? []
            : List<String>.from(json["supported_types"]!.map((x) => x)),
        faceMatchConfidence: json["face_match_confidence"],
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "document_number": documentNumber,
        "selected_type": selectedType == null
            ? []
            : List<dynamic>.from(selectedType!.map((x) => x)),
        "supported_types": supportedTypes == null
            ? []
            : List<dynamic>.from(supportedTypes!.map((x) => x)),
        "face_match_confidence": faceMatchConfidence,
      };
}

class Name {
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;

  Name({
    this.firstName,
    this.middleName,
    this.lastName,
    this.fullName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstName: json["first_name"] ?? '',
        middleName: json["middle_name"] ?? '',
        lastName: json["last_name"] ?? '',
        fullName: json["full_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "full_name": fullName,
      };
}

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
  int? documentNumber;
  int? dob;
  int? name;

  VerificationResultDocument({
    this.document,
    this.documentVisibility,
    this.documentMustNotBeExpired,
    this.documentProof,
    this.selectedType,
    this.documentCountry,
    this.faceOnDocumentMatched,
    this.documentNumber,
    this.dob,
    this.name,
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
        documentNumber: json["document_number"],
        dob: json["dob"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
        "document_visibility": documentVisibility,
        "document_must_not_be_expired": documentMustNotBeExpired,
        "document_proof": documentProof,
        "selected_type": selectedType,
        "document_country": documentCountry,
        "face_on_document_matched": faceOnDocumentMatched,
        "document_number": documentNumber,
        "dob": dob,
        "name": name,
      };
}

class Info {
  Agent? agent;
  Geolocation? geolocation;

  Info({
    this.agent,
    this.geolocation,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        geolocation: json["geolocation"] == null
            ? null
            : Geolocation.fromJson(json["geolocation"]),
      );

  Map<String, dynamic> toJson() => {
        "agent": agent?.toJson(),
        "geolocation": geolocation?.toJson(),
      };
}

class Agent {
  String? platformName;
  String? useragent;
  bool? isPhone;
  bool? isDesktop;
  String? browserName;
  String? deviceName;

  Agent({
    this.platformName,
    this.useragent,
    this.isPhone,
    this.isDesktop,
    this.browserName,
    this.deviceName,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        platformName: json["platform_name"],
        useragent: json["useragent"],
        isPhone: json["is_phone"],
        isDesktop: json["is_desktop"],
        browserName: json["browser_name"],
        deviceName: json["device_name"],
      );

  Map<String, dynamic> toJson() => {
        "platform_name": platformName,
        "useragent": useragent,
        "is_phone": isPhone,
        "is_desktop": isDesktop,
        "browser_name": browserName,
        "device_name": deviceName,
      };
}

class Geolocation {
  String? ip;
  String? postalCode;
  String? host;
  String? countryCode;
  String? regionCode;
  String? currency;
  String? latitude;
  String? city;
  String? countryName;
  String? continentCode;
  String? longitude;
  String? isp;
  String? continentName;
  String? metroCode;
  String? asn;
  String? timezone;
  String? ipType;
  String? rdns;
  String? capital;
  String? regionName;

  Geolocation({
    this.ip,
    this.postalCode,
    this.host,
    this.countryCode,
    this.regionCode,
    this.currency,
    this.latitude,
    this.city,
    this.countryName,
    this.continentCode,
    this.longitude,
    this.isp,
    this.continentName,
    this.metroCode,
    this.asn,
    this.timezone,
    this.ipType,
    this.rdns,
    this.capital,
    this.regionName,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        ip: json["ip"],
        postalCode: json["postal_code"],
        host: json["host"],
        countryCode: json["country_code"],
        regionCode: json["region_code"],
        currency: json["currency"],
        latitude: json["latitude"],
        city: json["city"],
        countryName: json["country_name"],
        continentCode: json["continent_code"],
        longitude: json["longitude"],
        isp: json["isp"],
        continentName: json["continent_name"],
        metroCode: json["metro_code"],
        asn: json["asn"],
        timezone: json["timezone"],
        ipType: json["ip_type"],
        rdns: json["rdns"],
        capital: json["capital"],
        regionName: json["region_name"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "postal_code": postalCode,
        "host": host,
        "country_code": countryCode,
        "region_code": regionCode,
        "currency": currency,
        "latitude": latitude,
        "city": city,
        "country_name": countryName,
        "continent_code": continentCode,
        "longitude": longitude,
        "isp": isp,
        "continent_name": continentName,
        "metro_code": metroCode,
        "asn": asn,
        "timezone": timezone,
        "ip_type": ipType,
        "rdns": rdns,
        "capital": capital,
        "region_name": regionName,
      };
}

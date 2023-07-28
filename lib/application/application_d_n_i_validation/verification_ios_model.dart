// To parse this JSON data, do
//
//     final verificationResponseIosModel = verificationResponseIosModelFromJson(jsonString);

import 'dart:convert';

import 'package:prestonesto_v1/application/application_d_n_i_validation/verification_model.dart';

VerificationResponseIosModel verificationResponseIosModelFromJson(String str) =>
    VerificationResponseIosModel.fromJson(json.decode(str));

String verificationResponseIosModelToJson(VerificationResponseIosModel data) =>
    json.encode(data.toJson());

class VerificationResponseIosModel {
  VerificationDataResponseModel? verificationData;
  VerificationResultResponseModel? verificationResult;
  dynamic email;
  String? country;
  String? event;
  Info? info;
  String? reference;

  VerificationResponseIosModel({
    this.verificationData,
    this.verificationResult,
    this.email,
    this.country,
    this.event,
    this.info,
    this.reference,
  });

  factory VerificationResponseIosModel.fromJson(Map<String, dynamic> json) =>
      VerificationResponseIosModel(
        verificationData: json["verification_data"] == null
            ? null
            : VerificationDataResponseModel.fromJson(json["verification_data"]),
        verificationResult: json["verification_result"] == null
            ? null
            : VerificationResultResponseModel.fromJson(
                json["verification_result"]),
        email: json["email"],
        country: json["country"],
        event: json["event"],
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "verification_data": verificationData?.toJson(),
        "verification_result": verificationResult?.toJson(),
        "email": email,
        "country": country,
        "event": event,
        "info": info?.toJson(),
        "reference": reference,
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

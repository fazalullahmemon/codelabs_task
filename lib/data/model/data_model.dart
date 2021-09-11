// To parse this JSON data, do
//
//     final romanNumeral = romanNumeralFromJson(jsonString);

import 'dart:convert';

RomanNumeral romanNumeralFromJson(String str) => RomanNumeral.fromJson(json.decode(str));

String romanNumeralToJson(RomanNumeral data) => json.encode(data.toJson());

class RomanNumeral {
  RomanNumeral({
    required this.number,
    required this.roman,
  });

  int number;
  String roman;

  factory RomanNumeral.fromJson(Map<String, dynamic> json) => RomanNumeral(
        number: json["number"],
        roman: json["roman"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "roman": roman,
      };
}

// To parse this JSON data, do
//
//     final apiNews = apiNewsFromJson(jsonString);

ApiNews apiNewsFromJson(String str) => ApiNews.fromJson(json.decode(str));

String apiNewsToJson(ApiNews data) => json.encode(data.toJson());

class ApiNews {
  ApiNews({
    required this.status,
    required this.statusCode,
    required this.version,
    required this.access,
    required this.data,
  });

  String status;
  int statusCode;
  String version;
  String access;
  List<Datum> data;

  factory ApiNews.fromJson(Map<String, dynamic> json) => ApiNews(
        status: json["status"],
        statusCode: json["status-code"],
        version: json["version"],
        access: json["access"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status-code": statusCode,
        "version": version,
        "access": access,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.summary,
    required this.link,
    required this.published,
    required this.image,
  });

  int id;
  String title;
  String? summary;
  String link;
  String published;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        summary: json["summary"] ?? 'N/A',
        link: json["link"],
        published: json["published"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary ?? 'N/A',
        "link": link,
        "published": published,
        "image": image ?? 'N/A',
      };
}

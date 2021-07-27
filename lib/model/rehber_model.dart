import 'dart:convert';

RehberModel rehberModelFromJson(String str) => RehberModel.fromJson(json.decode(str));

String rehberModelToJson(RehberModel data) => json.encode(data.toJson());

class RehberModel {
  RehberModel({
    this.status,
  });

  bool status;

  factory RehberModel.fromJson(Map<String, dynamic> json) => RehberModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

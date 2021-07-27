import 'dart:convert';

RehberSilModel rehberSilModelFromJson(String str) => RehberSilModel.fromJson(json.decode(str));

String rehberSilModelToJson(RehberSilModel data) => json.encode(data.toJson());

class RehberSilModel {
  RehberSilModel({
    this.status,
  });

  bool status;

  factory RehberSilModel.fromJson(Map<String, dynamic> json) => RehberSilModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

import 'dart:convert';

AlisverisListemModel alisverisListemModelFromJson(String str) => AlisverisListemModel.fromJson(json.decode(str));

String alisverisListemModelToJson(AlisverisListemModel data) => json.encode(data.toJson());

class AlisverisListemModel {
  AlisverisListemModel({
    this.status,
  });

  String status;

  factory AlisverisListemModel.fromJson(Map<String, dynamic> json) => AlisverisListemModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

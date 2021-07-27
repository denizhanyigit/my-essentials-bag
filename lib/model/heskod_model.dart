import 'dart:convert';

HesKodModel hesKodModelFromJson(String str) => HesKodModel.fromJson(json.decode(str));

String hesKodModelToJson(HesKodModel data) => json.encode(data.toJson());

class HesKodModel {
  HesKodModel({
    this.hesKod,
  });

  String hesKod;

  factory HesKodModel.fromJson(Map<String, dynamic> json) => HesKodModel(
        hesKod: json["hes_kod"],
      );

  Map<String, dynamic> toJson() => {
        "hes_kod": hesKod,
      };
}

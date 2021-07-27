import 'dart:convert';

HarcamalarimModel harcamalarimModelFromJson(String str) => HarcamalarimModel.fromJson(json.decode(str));

String harcamalarimModelToJson(HarcamalarimModel data) => json.encode(data.toJson());

class HarcamalarimModel {
  HarcamalarimModel({
    this.status,
  });

  String status;

  factory HarcamalarimModel.fromJson(Map<String, dynamic> json) => HarcamalarimModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

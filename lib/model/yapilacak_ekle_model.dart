import 'dart:convert';

YapilacakEkleModel yapilacakEkleModelFromJson(String str) => YapilacakEkleModel.fromJson(json.decode(str));

String yapilacakEkleModelToJson(YapilacakEkleModel data) => json.encode(data.toJson());

class YapilacakEkleModel {
  YapilacakEkleModel({
    this.status,
  });

  String status;

  factory YapilacakEkleModel.fromJson(Map<String, dynamic> json) => YapilacakEkleModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

import 'dart:convert';

ToplamHarcamaModel toplamHarcamaModelFromJson(String str) => ToplamHarcamaModel.fromJson(json.decode(str));

String toplamHarcamaModelToJson(ToplamHarcamaModel data) => json.encode(data.toJson());

class ToplamHarcamaModel {
  ToplamHarcamaModel({
    this.totalPrice,
  });

  String totalPrice;

  factory ToplamHarcamaModel.fromJson(Map<String, dynamic> json) => ToplamHarcamaModel(
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "total_price": totalPrice,
      };
}

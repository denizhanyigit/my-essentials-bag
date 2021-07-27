import 'dart:convert';
import 'package:alet_cantam/model/harcamalarim_model.dart';
import 'package:alet_cantam/model/rehber_model.dart';
import 'package:alet_cantam/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'model/rehber_sil_model.dart';

void main() => runApp(Harcamalarim());

class Harcamalarim extends StatefulWidget {
  @override
  __Harcamalarim createState() => __Harcamalarim();
}

Future<HarcamalarimModel> harcamaEkle(String title, String price) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/harcamalarim.php?islem=ekle";
  final response = await http.post(apiUrl, body: {"title": title, "price": price});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return harcamalarimModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<RehberSilModel> harcamaSil(String id) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/harcamalarim.php?islem=sil";
  final response = await http.post(apiUrl, body: {"id": id});
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return rehberSilModelFromJson(responseString);
  } else {
    return null;
  }
}

class __Harcamalarim extends State<Harcamalarim> {
  HarcamalarimModel _harcamalarimModel;
  HarcamalarimModel _harcamaEkle;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Harcama Ekleyin"),
            content: Container(
              height: 182.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: new InputDecoration(
                        labelText: "Harcama Adı",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: titleController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: new InputDecoration(
                        labelText: "Miktarı",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: priceController,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _harcamalarimModel == null ? Container() : Text("İşlem başarılı."),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Ekle"),
                onPressed: () async {
                  final String title = titleController.text.toString();
                  final String price = priceController.text.toString();
                  final HarcamalarimModel todo = await harcamaEkle(title, price);
                  setState(() {
                    _harcamaEkle = todo;
                    apiCall();
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        });
  }

  Map data;
  List userData;
  Future apiCall() async {
    final response = await http.get("https://denizhanyigit.com/kisisel-alet-cantam/harcamalarim.php?islem=listele");
    // ignore: unrelated_type_equality_checks data = json.decode(response.body);
    setState(() {
      final data = utf8.decode(response.bodyBytes);
      userData = json.decode(data);
    });
    debugPrint(userData.toString());
  }

  String toplamHarcama = "";
  Map data2;
  List userData2;
  Future totalPrice() async {
    final response = await http.get("https://denizhanyigit.com/kisisel-alet-cantam/harcamalarim.php?islem=total-price");
    // ignore: unrelated_type_equality_checks data = json.decode(response.body);
    setState(() {
      final data = utf8.decode(response.bodyBytes);
      userData = json.decode(data);
    });
    debugPrint(userData.toString());
    toplamHarcama = userData[0]["total_price"];
  }

  @override
  void initState() {
    super.initState();
    apiCall();
    totalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Harcamalarım'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                createAlertDialog(context);
              },
            )
          ],
        ),
        body: Column(children: <Widget>[
          new Card(
            margin: EdgeInsets.all(10),
            elevation: 20,
            color: Colors.grey,
            child: ListTile(
              title: Text(
                "Toplam Harcama: " + toplamHarcama + " ₺",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
              ),
            ),
          ), // I want widget or widgets here to be part of the scroll instead of them being fixed.
          new Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: userData == null ? 0 : userData.length,
              itemBuilder: (BuilderContext, int index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.money),
                    ),
                    title: Text("${userData[index]["title"]}"),
                    trailing: Text("${userData[index]["date"]}"),
                    subtitle: Text("${userData[index]["price"]}" + " ₺"),
                  ),
                );
              },
            ),
          ),
        ]),
        /*ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuilderContext, int index) {
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 20,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.money),
                ),
                title: Text("${userData[index]["title"]}"),
                trailing: Text("${userData[index]["date"]}"),
                subtitle: Text("${userData[index]["price"]}" + " ₺"),
              ),
            );
          },
        ),*/
        drawer: YanMenu(),
      ),
    );
  }
}

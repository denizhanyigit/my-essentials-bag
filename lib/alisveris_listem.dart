import 'dart:convert';
import 'package:alet_cantam/model/alisveris_listem_model.dart';
import 'package:alet_cantam/model/rehber_sil_model.dart';
import 'package:alet_cantam/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(AlisverisListem());

class AlisverisListem extends StatefulWidget {
  @override
  __AlisverisListem createState() => __AlisverisListem();
}

Future<AlisverisListemModel> alisverisEkle(String title, var date) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/alisveris-listem.php?islem=ekle";
  final response = await http.post(apiUrl, body: {"title": title, "date": date});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return alisverisListemModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<RehberSilModel> alisverisSil(String id) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/alisveris-listem.php?islem=sil";
  final response = await http.post(apiUrl, body: {"id": id});
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return rehberSilModelFromJson(responseString);
  } else {
    return null;
  }
}

class __AlisverisListem extends State<AlisverisListem> {
  AlisverisListemModel _alisverisListemModel;
  RehberSilModel _rehberSilModel;

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alışveriş Listenize Ekleyin"),
            content: Container(
              height: 182.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: new InputDecoration(
                        labelText: "Ürün Adı",
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
                        labelText: "Kaç Gün Sonra Alınacak",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: dateController,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _alisverisListemModel == null ? Container() : Text("İşlem başarılı."),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Ekle"),
                onPressed: () async {
                  final String title = titleController.text.toString();
                  final String date = dateController.text.toString();
                  final AlisverisListemModel alisveris = await alisverisEkle(title, date);
                  setState(() {
                    _alisverisListemModel = alisveris;
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
    final response = await http.get("https://denizhanyigit.com/kisisel-alet-cantam/alisveris-listem.php?islem=listele");
    // ignore: unrelated_type_equality_checks data = json.decode(response.body);
    setState(() {
      final data = utf8.decode(response.bodyBytes);
      userData = json.decode(data);
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alışveriş Listem'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  createAlertDialog(context);
                })
          ],
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (BuilderContext, int index) {
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 20,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.shopping_basket_sharp),
                  ),
                  title: Text("${userData[index]["title"]}"),
                  subtitle: Text("${userData[index]["date"]}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.blue),
                    onPressed: () {
                      alisverisSil(userData[index]["id"]);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AlisverisListem()));
                    },
                  ),
                ),
              );
            }),
        drawer: YanMenu(),
      ),
    );
  }
}

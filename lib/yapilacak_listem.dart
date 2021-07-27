import 'dart:convert';
import 'package:alet_cantam/model/rehber_sil_model.dart';
import 'package:alet_cantam/model/yapilacak_ekle_model.dart';
import 'package:alet_cantam/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(YapilacakListem());

class YapilacakListem extends StatefulWidget {
  @override
  __YapilacakListem createState() => __YapilacakListem();
}

Future<YapilacakEkleModel> kisiEkle(String name, var date) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/yapilacak-listem.php?islem=ekle";
  final response = await http.post(apiUrl, body: {"to_do_name": name, "to_do_date": date});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return yapilacakEkleModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<RehberSilModel> todoSil(String to_do_id) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/yapilacak-listem.php?islem=sil";
  final response = await http.post(apiUrl, body: {"to_do_id": to_do_id});
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return rehberSilModelFromJson(responseString);
  } else {
    return null;
  }
}

class __YapilacakListem extends State<YapilacakListem> {
  YapilacakEkleModel _yapilacakEkleModel;
  RehberSilModel _rehberSilModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Kişi Ekleyin"),
            content: Container(
              height: 182.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: new InputDecoration(
                        labelText: "Yapılacak",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: new InputDecoration(
                        labelText: "Kaç Gün Sonra",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: phoneController,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _yapilacakEkleModel == null ? Container() : Text("İşlem başarılı."),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Ekle"),
                onPressed: () async {
                  final String name = nameController.text.toString();
                  final String date = phoneController.text.toString();
                  final YapilacakEkleModel todo = await kisiEkle(name, date);
                  setState(() {
                    _yapilacakEkleModel = todo;
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
    final response = await http.get("https://denizhanyigit.com/kisisel-alet-cantam/yapilacak-listem.php?islem=listele");
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
          title: Text('Yapılacak Listem'),
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
                    child: Icon(Icons.playlist_add_check),
                  ),
                  title: Text("${userData[index]["to_do_name"]}"),
                  subtitle: Text("${userData[index]["to_do_date"]}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.blue),
                    onPressed: () {
                      //launch('tel:05339630754');
                      todoSil(userData[index]["to_do_id"]);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YapilacakListem()));
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

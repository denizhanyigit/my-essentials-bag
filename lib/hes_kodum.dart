import 'dart:convert';
import 'package:alet_cantam/model/heskod_model.dart';
import 'package:alet_cantam/model/rehber_model.dart';
import 'package:alet_cantam/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(HesKodum());

class HesKodum extends StatefulWidget {
  @override
  _HesKodumState createState() => _HesKodumState();
}

Future<RehberModel> hesKodEkle(String hesKod) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/hes-kodum.php?islem=HesKoduEkle";
  final response = await http.post(apiUrl, body: {"hes_kod": hesKod});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return rehberModelFromJson(responseString);
  } else {
    return null;
  }
}

class _HesKodumState extends State<HesKodum> {
  HesKodModel _hesKodModel;
  TextEditingController hesKodumController = TextEditingController();
  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Yeni Hes Kodunuz"),
            content: Container(
              height: 115.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: new InputDecoration(
                        labelText: "Hes Kodunuz",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: hesKodumController,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _hesKodModel == null ? Container() : Text("İşlem başarılı."),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Ekle"),
                onPressed: () async {
                  final String hesKodu = hesKodumController.text.toString();
                  hesKodEkle(hesKodu);
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HesKodum()));
                },
              )
            ],
          );
        });
  }

  var Kod = "";

  Map data;
  List userData;
  Future apiCall() async {
    final response = await http.get("https://denizhanyigit.com/kisisel-alet-cantam/hes-kodum.php?islem=HesKoduGetir");
    // ignore: unrelated_type_equality_checks data = json.decode(response.body);
    setState(() {
      userData = json.decode(response.body);
    });
    debugPrint(userData.toString());
    Kod = userData[0]["hes_kod"];
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
          title: Text('Hes Kodum'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  createAlertDialog(context);
                })
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(
            height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 200.0,
          ),
          padding: const EdgeInsets.all(8.0),
          margin: EdgeInsets.only(top: 200.0),
          color: Colors.blue[600],
          alignment: Alignment.center,
          child: Text("${Kod}", style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white)),
          transform: Matrix4.rotationZ(0.0),
        ),
        drawer: YanMenu(),
      ),
    );
  }
}

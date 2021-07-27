import 'dart:convert';
import 'package:alet_cantam/model/rehber_model.dart';
import 'package:alet_cantam/model/rehber_sil_model.dart';
import 'package:alet_cantam/yanmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Rehberim());

class Rehberim extends StatefulWidget {
  @override
  __RehberimState createState() => __RehberimState();
}

Future<RehberModel> kisiEkle(String name, var phone) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/kisi-ekle.php";

  final response = await http.post(apiUrl, body: {"name": name, "phone": phone});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return rehberModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<RehberSilModel> kisiSil(String phone_number) async {
  final String apiUrl = "https://denizhanyigit.com/kisisel-alet-cantam/kisi-sil.php";
  final response = await http.post(apiUrl, body: {"phone_number": phone_number});
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return rehberSilModelFromJson(responseString);
  } else {
    return null;
  }
}

class __RehberimState extends State<Rehberim> {
  RehberModel _rehberModel;
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
                        labelText: "Adı Soyadı",
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
                        labelText: "Telefon",
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
                  _rehberModel == null ? Container() : Text("İşlem başarılı."),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Ekle"),
                onPressed: () async {
                  final String name = nameController.text.toString();
                  final String phone = phoneController.text.toString();
                  final RehberModel kisi = await kisiEkle(name, phone);
                  setState(() {
                    _rehberModel = kisi;
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
    final response = await http.get("https://denizhanyigit.com/kisisel-alet-cantam/rehberim.php");
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
          title: Text('Rehberim'),
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
                    child: Icon(Icons.person),
                    radius: 15,
                  ),
                  title: Text("${userData[index]["name"]}"),
                  subtitle: Text("${userData[index]["phone_number"]}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.blue),
                    onPressed: () {
                      //launch('tel:05339630754');
                      kisiSil(userData[index]["phone_number"]);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Rehberim()));
                    },
                  ),
                  onTap: () {
                    launch('tel:05339630754');
                  },
                ),
              );
            }),
        drawer: YanMenu(),
      ),
    );
  }
}

void _rehberEkleModal(context) {
  TextEditingController nameController = TextEditingController();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Rehbere Kişi Ekle",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    onChanged: (newText) {},
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.cancel, color: Colors.blue, size: 25),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

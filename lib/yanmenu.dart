import 'package:alet_cantam/alisveris_listem.dart';
import 'package:alet_cantam/calculator/calculator.dart';
import 'package:alet_cantam/harcamalarim.dart';
import 'package:alet_cantam/hes_kodum.dart';
import 'package:alet_cantam/rehberim.dart';
import 'package:alet_cantam/yapilacak_listem.dart';
import 'package:flutter/material.dart';
import 'dil.dart';

class YanMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset("assets/logo2.png"),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(turkce["1.menu"]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AlisverisListem()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.fact_check),
                    title: Text("Yapılacaklar Listem"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YapilacakListem()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.money),
                    title: Text("Harcamalarım"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Harcamalarim()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.integration_instructions),
                    title: Text("Hes Kodum"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HesKodum()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text("Rehberim"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Rehberim()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calculate),
                    title: Text("Hesap Makinesi"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Calculator()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

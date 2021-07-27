import 'package:alet_cantam/yanmenu.dart';
import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Benim Uygulamam"),
        // centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            tooltip: 'Puan Ver',
            onPressed: null,
          ),
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              tooltip: 'Paylaş',
              onPressed: null)
        ],
      ),
      body: Container(),
      drawer: YanMenu(),
    );
  }
}

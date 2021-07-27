import 'package:alet_cantam/yapilacak_listem.dart';
import 'package:flutter/material.dart';
import 'anasayfa.dart';
import 'rehberim.dart';

void main() {
  runApp(GirisEkrani());
}

class GirisEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.indigo),
      home: YapilacakListem(),
      routes: rotalar,
      debugShowCheckedModeBanner: false,
    );
  }
}

var rotalar = <String, WidgetBuilder>{
  "/anasayfa": (BuildContext context) => AnaSayfa(),
  "/rehberim": (BuildContext context) => Rehberim(),
};

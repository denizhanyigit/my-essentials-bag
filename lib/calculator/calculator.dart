import 'package:flutter/material.dart';

import '../yanmenu.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  Calculator({Key key, this.title}) : super(key: key);
  final String title;

  @override
  __Calculator createState() => __Calculator();
}

class __Calculator extends State<Calculator> {
  String defaultOutput = "0";

  String _defaultOutput = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "TEMIZLE") {
      _defaultOutput = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
      num1 = double.parse(defaultOutput);
      operand = buttonText;
      _defaultOutput = "0";
    } else if (buttonText == ".") {
      if (_defaultOutput.contains(".")) {
        return;
      } else {
        _defaultOutput = _defaultOutput + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.tryParse(defaultOutput);

      if (operand == "+") {
        _defaultOutput = (num1 + num2).toString();
      }
      if (operand == "-") {
        _defaultOutput = (num1 - num2).toString();
      }
      if (operand == "X") {
        _defaultOutput = (num1 * num2).toString();
      }
      if (operand == "/") {
        _defaultOutput = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _defaultOutput = _defaultOutput + buttonText;
    }
    print(_defaultOutput);

    setState(() {
      if (buttonText == "=") {
        defaultOutput = double.parse(_defaultOutput).toStringAsFixed(2);
      } else {
        defaultOutput = double.parse(_defaultOutput).toStringAsFixed(0);
      }
    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
          highlightColor: Colors.white,
          padding: new EdgeInsets.all(24.0),
          child: new Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Calculator',
                // backgroundColor: Colors.yellow,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(buttonText)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.purple,
        title: Text("Hesap Makinesi"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
                color: Colors.white,
                alignment: Alignment.centerRight,
                padding: new EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                child: new Text(
                  defaultOutput,
                  style: new TextStyle(
                    fontFamily: 'Calculator',
                    fontSize: 75.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            new Expanded(
              // Sonuç ekranı ile tuşlar arasına mesafe koymak için
              //child: new Divider(), // Renk ataması yapılmadığı için kullanmadım
              child: Container(
                color: Colors.white,
              ),
            ),
            new Column(children: [
              new Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/"),
              ]),
              new Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("X"),
              ]),
              new Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
              ]),
              new Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+"),
              ]),
              new Row(children: [
                buildButton("TEMIZLE"),
                buildButton("="),
              ])
            ])
          ],
        ),
      ),
      drawer: YanMenu(),
    );
  }
}

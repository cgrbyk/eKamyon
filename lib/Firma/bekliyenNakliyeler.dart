import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';

class BekleyenNakliyeler extends StatefulWidget {
  @override
  _BekleyenNakliyelerState createState() => _BekleyenNakliyelerState();
}

class _BekleyenNakliyelerState extends State<BekleyenNakliyeler> {
  Database _database = Database();
  @override
  void initState() {
    super.initState();
    bekleyenNakliyeleriAl();
  }

  bekleyenNakliyeleriAl() async {
    await _database.getBekleyenNakliyeler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Hızlı İşlem Münüsü',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
        ],
      ),
      body: Container(
        child: Text("asd"),
      ),
    );
  }
}

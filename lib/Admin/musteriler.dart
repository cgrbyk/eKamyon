import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';

class Musteriler extends StatefulWidget {
  @override
  _MusterilerState createState() => _MusterilerState();
}

class _MusterilerState extends State<Musteriler> {
  Database _database=Database();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database.getMusteriler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Müşteriler',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        color: Color(0xFF96beff),
        child: ListView.builder(
          
        ),
      ),
    );
  }
}

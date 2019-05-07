import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'package:ekamyon/database.dart';
import 'package:ekamyon/Modeller/Fiyat.dart';

class FiyatListe extends StatefulWidget {
  @override
  FiyatListeEkrani createState() => FiyatListeEkrani();
}

class FiyatListeEkrani extends State<FiyatListe> {
  Database _database = Database();
  List<Fiyat> fiyatlar = new List<Fiyat>();

  bool aracaktifmi = false;

  @override
  void initState() {
    fiyatListesiDoldur();
    super.initState();
  }

  Widget customTextBox(
      TextInputType type,
      String placeholder,
      TextEditingController controller,
      TextInputAction action,
      FocusNode ownFocus,
      FocusNode tofocus,
      bool password) {
    return TextField(
      focusNode: ownFocus,
      obscureText: password,
      keyboardType: type,
      autofocus: false,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      controller: controller,
      textInputAction: action,
      onSubmitted: (String s) {
        FocusScope.of(context).requestFocus(tofocus);
      },
      style: TextStyle(
          fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 20),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  fiyatListesiDoldur() async {
    fiyatlar = Fiyat.fromArray(await _database.fiyatlariCek());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF96beff),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Fiyat Listesi Güncelle'),
          actions: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Image.asset('images/logoson.png'))
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: ListView.builder(
                itemCount: fiyatlar.length,
                itemBuilder: (context, index) {
                  if (fiyatlar.length != 0) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: <Widget>[
                                Text("Varış İl",
                                    style: TextStyle(
                                        color: Colors.grey[1000],
                                        fontSize: 14)),
                                Text(fiyatlar[index].varisIl,
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12)),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("Ev Tipi",
                                  style: TextStyle(
                                      color: Colors.grey[1000], fontSize: 14)),
                              Text(fiyatlar[index].evTipi,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Fiyat",
                                  style: TextStyle(
                                      color: Colors.grey[1000], fontSize: 14)),
                              Text(fiyatlar[index].tasimaUcretiTam,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              child: Text("Fiyat Güncelle"),
                              onPressed: () {
                                showDialog(context: context, builder: (_) {
                                  //fiyat güncelle popupu
                                });
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: RaisedButton(
                              child: Text("Sil"),
                              onPressed: () {
                                //Fiyatı sil
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Yeni Fiyat"),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  onPressed: () {
                    //yeni fiyat ekle
                  },
                ),
                RaisedButton(
                  child: Text("Toplu Fiyat Güncelle"),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  onPressed: () {
                    //toplu fiyat Güncelle
                  },
                )
              ],
            )
          ],
        ));
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/Modeller/Nakliye.dart';
import 'package:ekamyon/Modeller/firma.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Firmalar extends StatefulWidget {
  @override
  _FirmalarState createState() => _FirmalarState();
}

class _FirmalarState extends State<Firmalar> {
  Database _database = Database();
  List<Firma> firmalar = List<Firma>();
  int itemcount = 1;
  @override
  void initState() {
    super.initState();
    getFirmalar();
  }

  getFirmalar() async {
    firmalar = await _database.getFirmalar();
    itemcount = firmalar.length;
    if (this.mounted) {           setState(() {});         }
  }

  void _showDetay(Firma firma) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new AutoSizeText(firma.firmaUnvani)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AutoSizeText("İl :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaIl, maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("İlçe :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaIlce, maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Adres :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaAdres, maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Cep NO :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      child: AutoSizeText(firma.firmaCepTel, maxLines: 1),
                      onTap: () {
                        launch("tel://" + firma.firmaCepTel);
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Sabit Tel :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      child: AutoSizeText(firma.firmaSabitTel, maxLines: 1),
                      onTap: () {
                        launch("tel://" + firma.firmaSabitTel);
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Faaliyet süresi :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaKacYildirFaaliyette, maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Araç sayısı :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaAracSayisi, maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Personel Sayısı :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaPersonelSayisi, maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Web sitesi :",
                        maxLines: 1, style: TextStyle(color: Colors.grey)),
                    AutoSizeText(firma.firmaWebSitesi, maxLines: 1),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new AutoSizeText("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new AutoSizeText("İşlem geçimişi"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return MusteriBekleyenNakliyelerAdmin(
                        firma: firma,
                      );
                    });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Firmalar',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        color: Color(0xFF96beff),
        child: ListView.builder(
          itemCount: itemcount,
          itemBuilder: (context, index) {
            if (firmalar.length != 0) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AutoSizeText("Firma unvan",
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1),
                          AutoSizeText(firmalar[index].firmaUnvani,
                              style: TextStyle(color: Colors.grey[600]),
                              maxLines: 1),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          AutoSizeText("Şehir",
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1),
                          AutoSizeText(
                              firmalar[index].firmaIl +
                                  "/" +
                                  firmalar[index].firmaIlce,
                              style: TextStyle(color: Colors.grey[600]),
                              maxLines: 1),
                        ],
                      ),
                      OutlineButton(
                        color: Colors.blue,
                        splashColor: Colors.blue[600],
                        highlightColor: Colors.blue[300],
                        child: AutoSizeText(
                          "Detay",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          _showDetay(firmalar[index]);
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class MusteriBekleyenNakliyelerAdmin extends StatefulWidget {
  final Firma firma;
  MusteriBekleyenNakliyelerAdmin({this.firma});
  @override
  _MusteriBekleyenNakliyelerAdminState createState() =>
      _MusteriBekleyenNakliyelerAdminState(firma: firma);
}

class _MusteriBekleyenNakliyelerAdminState
    extends State<MusteriBekleyenNakliyelerAdmin> {
  final Firma firma;
  _MusteriBekleyenNakliyelerAdminState({this.firma});
  Database _database = Database();
  List<Nakliye> nakliyeler = List<Nakliye>();
  int itemcount = 1;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    bekleyenNakliyeleriAl();
  }

  bekleyenNakliyeleriAl() async {
    nakliyeler = await _database.getFirmaNakliyelerAdmin(firma.userid);
    itemcount = nakliyeler.length;
    loading = false;
    if (this.mounted) {           setState(() {});         }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: AutoSizeText(
                    firma.firmaUnvani + "'ait nakliyeler",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemcount,
                    itemBuilder: (context, index) {
                      if (nakliyeler.length != 0) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    AutoSizeText("Durum",
                                        style: TextStyle(color: Colors.grey),
                                        maxLines: 1),
                                    AutoSizeText(nakliyeler[index].odemeDurumu,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        maxLines: 1),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText("Ücret",
                                        style: TextStyle(color: Colors.grey),
                                        maxLines: 1),
                                    AutoSizeText(
                                        nakliyeler[index].anlasilanFiyat + "₺",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        maxLines: 1),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText("Tarih",
                                        style: TextStyle(color: Colors.grey),
                                        maxLines: 1),
                                    AutoSizeText(
                                        nakliyeler[index].tasinmaTarihi,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        maxLines: 1),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    AutoSizeText("Firma",
                                        style: TextStyle(color: Colors.grey),
                                        maxLines: 1),
                                    AutoSizeText(
                                        nakliyeler[index].anlasilanFirmaID,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        maxLines: 1),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (loading)
                          return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text('Kapat'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}

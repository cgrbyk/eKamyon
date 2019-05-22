import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/Modeller/Nakliye.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';
import 'package:ekamyon/Modeller/musteri.dart';
import 'package:url_launcher/url_launcher.dart';

class Musteriler extends StatefulWidget {
  @override
  _MusterilerState createState() => _MusterilerState();
}

class _MusterilerState extends State<Musteriler> {
  Database _database = Database();
  List<Musteri> musteriler = List<Musteri>();
  int itemcount = 1;

  @override
  void initState() {
    super.initState();
    getMusteriler();
  }

  getMusteriler() async {
    musteriler = await _database.getMusteriler();
    itemcount = musteriler.length;
    if (this.mounted) {           setState(() {});         }
  }

  void _showDetay(Musteri musteri) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(
              child: new Text(musteri.firstname + " " + musteri.lastname)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Musteri ili :", style: TextStyle(color: Colors.grey)),
                    Text(musteri.musteriil),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Musteri İlçe :",
                        style: TextStyle(color: Colors.grey)),
                    Text(musteri.musteriilce),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Musteri Adres :",
                        style: TextStyle(color: Colors.grey)),
                    Text(musteri.musteriadres),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Musteri Cep NO :",
                        style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      child: Text(musteri.musteriiletisimtel),
                      onTap: () {
                        launch("tel://" + musteri.musteriiletisimtel);
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Musteri Posta Kodu :",
                        style: TextStyle(color: Colors.grey)),
                    Text(musteri.musteripostakodu),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Musteri TcNo :",
                        style: TextStyle(color: Colors.grey)),
                    Text(musteri.musteritckimlikno),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("İşlem Geçmişi"),
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (_) {
                      return MusteriBekleyenNakliyelerAdmin(
                        musteri: musteri,
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
          'Müşteriler',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        color: Color(0xFF96beff),
        child: ListView.builder(
          itemCount: itemcount,
          itemBuilder: (context, index) {
            if (musteriler.length != 0) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AutoSizeText("Ad Soyad",
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1),
                          AutoSizeText(
                              musteriler[index].firstname +
                                  " " +
                                  musteriler[index].lastname,
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
                              musteriler[index].musteriil +
                                  "/" +
                                  musteriler[index].musteriilce,
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
                          _showDetay(musteriler[index]);
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
  final Musteri musteri;
  MusteriBekleyenNakliyelerAdmin({this.musteri});
  @override
  _MusteriBekleyenNakliyelerAdminState createState() =>
      _MusteriBekleyenNakliyelerAdminState(musteri: musteri);
}

class _MusteriBekleyenNakliyelerAdminState
    extends State<MusteriBekleyenNakliyelerAdmin> {
  final Musteri musteri;
  _MusteriBekleyenNakliyelerAdminState({this.musteri});
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
    nakliyeler =
        await _database.getMusteriBekleyenNakliyelerAdmin(musteri.userid);
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
                  musteri.firstname +
                        " " +
                        musteri.lastname +
                        "'ait nakliyeler",
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/Modeller/Nakliye.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BekleyenNakliyeler extends StatefulWidget {
  @override
  _BekleyenNakliyelerState createState() => _BekleyenNakliyelerState();
}

class _BekleyenNakliyelerState extends State<BekleyenNakliyeler> {
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
    nakliyeler = await _database.getBekleyenNakliyeler();
    itemcount = nakliyeler.length;
    loading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  void _showDetay(Nakliye n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text(n.musteriAdi)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                AutoSizeText("Taşıma türü :",
                    style: TextStyle(color: Colors.grey), maxLines: 1),
                AutoSizeText(n.tasinmaTuru,maxLines: 1),
                Row(
                  children: <Widget>[
                    AutoSizeText("Mevcut ili :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.mevcutIl,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Mevcut İlçe :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.mevcutIlce,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Mevcut Adres :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.mevcutAdres,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Varış Il :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.varisIl,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Varış Ilce :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.varisIlce,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Varış adres :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.varisAdres,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Tasinma Tarihi :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.tasinmaTarihi,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Anlasma Tarihi :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.anlasilanTarih.split(' ')[0],maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Eposta :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.eposta,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("yakınlık :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.yukeYaklasma + "m",maxLines: 1),
                  ],
                ),
                AutoSizeText("Eşyalar nasıl paketlenecek :",
                    style: TextStyle(color: Colors.grey), maxLines: 1),
                AutoSizeText(n.nasilPaketlenecek,maxLines: 1),
                AutoSizeText("Eşyalar nasıl taşınacak :",
                    style: TextStyle(color: Colors.grey), maxLines: 1),
                AutoSizeText(n.nasilTasinacak,maxLines: 1),
                Row(
                  children: <Widget>[
                    AutoSizeText(
                        n.mevcutOda == null ? "Esya Cinsi" : "Evin büyüklüğü :",
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1),
                    AutoSizeText(n.mevcutOda ?? n.esyaCinsi ,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Mevcut ev katı:",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.mevcutKat,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Varış ev katı :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.varisKat,maxLines: 1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AutoSizeText("Sigorta :",
                        style: TextStyle(color: Colors.grey), maxLines: 1),
                    AutoSizeText(n.sigorta,maxLines: 1),
                  ],
                ),
                Visibility(
                  visible: n.tasinmaTuru == "EvdenEve" ? true : false,
                  child: Row(
                    children: <Widget>[
                      AutoSizeText("Eşya Listesi :",
                          style: TextStyle(color: Colors.grey), maxLines: 1),
                      Text(n.esyaListesi ?? ""),
                    ], 
                  ),
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
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF96beff),
      appBar: AppBar(
        title: AutoSizeText(
          'Bekleyen Nakliyeler',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
        ],
      ),
      body: Container(
          child: ListView.builder(
        itemCount: itemcount,
        itemBuilder: (context, index) {
          if (nakliyeler.length != 0) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AutoSizeText("Ad Soyad",
                            style: TextStyle(color: Colors.grey), maxLines: 1),
                        AutoSizeText(nakliyeler[index].musteriAdi,
                            style: TextStyle(color: Colors.grey[600]),
                            maxLines: 1),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        AutoSizeText("Ücret",
                            style: TextStyle(color: Colors.grey), maxLines: 1),
                        AutoSizeText(nakliyeler[index].anlasilanFiyat + "₺",
                            style: TextStyle(color: Colors.grey[600]),
                            maxLines: 1),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        AutoSizeText("Tarih",
                            style: TextStyle(color: Colors.grey), maxLines: 1),
                        AutoSizeText(nakliyeler[index].tasinmaTarihi,
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
                        _showDetay(nakliyeler[index]);
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            if (loading) return Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}

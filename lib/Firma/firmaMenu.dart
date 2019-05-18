import 'dart:async';
import 'package:ekamyon/Firma/FirmaBilgisiGuncelle.dart';
import 'package:flutter/material.dart';
import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'FiyatListesi.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'araclar.dart';

class FirmaMenu extends StatefulWidget {
  @override
  FirmaMenuEkrani createState() => FirmaMenuEkrani();
}

class FirmaMenuEkrani extends State<FirmaMenu> {
  stateGuncelle() {
    setState(() {});
  }

  Widget getImageButton(String imagePath, String isim) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.25,
          child: new Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: new Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/" + imagePath,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.20),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                    child: AutoSizeText(
                      isim,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ))
              ],
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AutoSizeText('Hızlı İşlem Münüsü',style: TextStyle(fontSize: 18),),
          actions: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Image.asset('images/logoson.png'))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFFFFFFF),
                const Color(0xFF2084b8)
              ], // whitish to gray
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                      "Hoşgeldiniz " +
                          AktifKullaniciBilgileri.firmaAdi.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: getImageButton(
                        "bekleyennakliyeler.png", "bekleyen nakliyelerim"),
                    onTap: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AracListe()),
                      );*/
                    },
                  ),
                  GestureDetector(
                      child: getImageButton("sarikamyon.png", "Araçlarım"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AracListe()),
                        );
                      })
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: getImageButton(
                        "fiyatguncelle.png", "Fiyat listeri Güncelle"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FiyatListe()),
                      );
                    },
                  ),
                  GestureDetector(
                    child: getImageButton(
                        "firmabilgisiguncelle.png", "Firma bilgisi güncelle"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirmaBilgisiGuncelle(
                                  mainState: this,
                                )),
                      );
                    },
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  getImageButton("tamamlanan.png", "Tamamlanan nakliyeler"),
                  GestureDetector(
                    child: getImageButton(
                        "bildirimayarlari.png", "Bildirim Ayarları"),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: BildirimEkrani());
                          });
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class BildirimEkrani extends StatefulWidget {
  @override
  BildirimEkraniPopup createState() => BildirimEkraniPopup();
}

class BildirimEkraniPopup extends State<BildirimEkrani> {
  bool titresimBildirim = false;
  bool sesliBildirim = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: AlertDialog(
            title: Center(
              child: Text("Bilgirim Ayarları"),
            ),
            content: Column(
              children: <Widget>[
                CheckboxListTile(
                  value: titresimBildirim,
                  title: Text("Titreşim ile bildirim"),
                  onChanged: (bool value) {
                    titresimBildirim = value;
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  value: sesliBildirim,
                  title: Text("Ses ile bildirim"),
                  onChanged: (bool value) {
                    sesliBildirim = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Vazgeç"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Değişiklikleri Kaydet"),
                onPressed: () {
                  //değişim Kaydetme
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

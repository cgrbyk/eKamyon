import 'dart:async';
import 'package:flutter/material.dart';
import 'aktifKullaniciBilgileri.dart';

class FirmaMenu extends StatefulWidget {
  @override
  FirmaMenuEkrani createState() => FirmaMenuEkrani();
}

class FirmaMenuEkrani extends State<FirmaMenu> {
  Widget getImageButton(String imagePath, String isim) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.20,
          child: new Card(
            child: new Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/" + imagePath,
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.15),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                    child: Text(isim,style: TextStyle(fontWeight: FontWeight.bold),))
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
          title: Text('Hızlı İşlem Münüsü'),
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
                        onTap: (){},
                  ),
                  getImageButton("sarikamyon.png", "Araçlarım")
                ],
              ),
              Row(
                children: <Widget>[
                  getImageButton("fiyatguncelle.png", "Fiyat listeri Güncelle"),
                  getImageButton(
                      "firmabilgisiguncelle.png", "Firma bilgisi güncelle")
                ],
              ),
              Row(
                children: <Widget>[
                  getImageButton("tamamlanan.png", "Tamamlanan nakliyeler"),
                  getImageButton("bildirimayarlari.png", "Bildirim Ayarları")
                ],
              ),
            ],
          ),
        ));
  }
}

import 'package:ekamyon/Admin/firmalar.dart';
import 'package:ekamyon/Admin/musteriler.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  Widget getImageButton(String imagePath, String isim) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.20,
          child: new Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: new Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/" + imagePath,
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
          title: AutoSizeText(
            'Admin İşlem Münüsü',
            style: TextStyle(fontSize: 18),
          ),
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
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  child: getImageButton("musteriler.png", "Müşteriler"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Musteriler()),
                    );
                  },
                ),
                GestureDetector(
                  child: getImageButton("firmalar.png", "Firmalar"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Firmalar()),
                    );
                  },
                ),
                getImageButton("talepler.png", "Talepler"),
                GestureDetector(
                  child: getImageButton("bildirimayarlari.png", "Bildirim"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return BildirimEkrani();
                        });
                  },
                ),
              ],
            )));
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
                    if (this.mounted) {           setState(() {});         }
                  },
                ),
                CheckboxListTile(
                  value: sesliBildirim,
                  title: Text("Ses ile bildirim"),
                  onChanged: (bool value) {
                    sesliBildirim = value;
                    if (this.mounted) {           setState(() {});         }
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

/*
ÇAĞRI BIYIK 2019
*/

import 'package:ekamyon/Admin/AdminMenu.dart';
import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'package:ekamyon/Musteri/kullaniciMenu.dart';
import 'package:flutter/material.dart';
import 'database.dart';

import 'Firma/firmaMenu.dart';
import 'KayitKullanici.dart';
import 'KayitFirma.dart';

import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(Ekamyon());

class Ekamyon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekamyon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GirisSayfasi(),
    );
  }
}

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  Database _database = new Database();
  TextEditingController kulmail = TextEditingController();
  TextEditingController kulsifre = TextEditingController();
  FocusNode kulsifreNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    kulmail.text = "firma1@yusuf.com";
    kulsifre.text = "1234";
  }

  void _kayitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(
            title: Center(child: new Text("Yeni Hesap Oluştur")),
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                      "Size daha iyi hizmet verebilmem için bütün bilgileri eksiksiz girmeniz gerekmektedir."),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Müşteri Hesabı",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      //Müşteri Kayıt Ekranı açılacak
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KayitKullanici()),
                      );
                    },
                  ),
                  new FlatButton(
                    child: new Text("Firma Hesabı",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KayitFirma()),
                      );
                    },
                  ),
                ],
              )
            ]);
      },
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

  void _showPasswordReset() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Şifremi Unuttum"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: <Widget>[
                AutoSizeText(
                  "Mail adresinizi giriniz.",
                  maxLines: 1,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.lightBlueAccent,
                    ),
                    hintText: 'Email',
                    contentPadding: EdgeInsets.only(top: 20.0),
                  ),
                  controller: kulmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (String s) {
                    //Şifre yenileme postası gönderme
                  },
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15),
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
              child: new Text("Şifremi Yenile"),
              onPressed: () {
                //Şifre yenileme postası gönder
              },
            ),
          ],
        );
      },
    );
  }

  _showIndicator() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  void oturumAc(String kulEmail, String kulSifre) async {
    String girenKullaniciTuru = await _database.giris(kulEmail, kulSifre);
    Navigator.pop(context);
    if (girenKullaniciTuru == "basarisiz") {
      _showDialog("Kullanıcı adı veya şifre yanlış",
          "Girmiş olduğunuz Kullanıcı adı veya şifreyi kontrol ediniz üye değilseniz aşağıdan üye olabilirsiniz");
    } else if (girenKullaniciTuru == "musteri") {
      AktifKullaniciBilgileri.musteriSifresi = kulSifre;
      AktifKullaniciBilgileri.musteriEposta = kulEmail;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KullaniciMenu()),
      );
    } else if (girenKullaniciTuru == "firma") {
      AktifKullaniciBilgileri.firmaSifresi = kulSifre;
      AktifKullaniciBilgileri.firmaEposta = kulEmail;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirmaMenu()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminMenu()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
              //logo
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.asset('images/logoson.png')),
                ),
              ),
              //Email textfield
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.lightBlueAccent,
                        ),
                        hintText: 'Email',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      controller: kulmail,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (String s) {
                        FocusScope.of(context).requestFocus(kulsifreNode);
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              //Şifre Textfield
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.03),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.lightBlueAccent,
                        ),
                        hintText: 'Şifre',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      controller: kulsifre,
                      focusNode: kulsifreNode,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (String deger) {
                        _showIndicator();
                        oturumAc(kulmail.text, kulsifre.text);
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              //Oturum aç butonu
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: RaisedButton(
                        color: Colors.white,
                        child: new Text(
                          "Oturum Aç",
                          textScaleFactor: 2,
                        ),
                        onPressed: () async {
                          //Oturum açma kodu
                          _showIndicator();
                          oturumAc(kulmail.text, kulsifre.text);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  )),
              //Yeni Kullanıcı ve Şifremi unuttum
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Şifremi Unuttum',
                          style: TextStyle(color: Colors.white, fontSize: 19)),
                      onPressed: () {
                        _showPasswordReset();
                      },
                    ),
                    FlatButton(
                      child: Text('Yeni Kullanıcı',
                          style: TextStyle(color: Colors.white, fontSize: 19)),
                      onPressed: () {
                        _kayitDialog();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

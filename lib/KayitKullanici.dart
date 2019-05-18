import 'package:flutter/material.dart';
import 'database.dart';
import 'package:url_launcher/url_launcher.dart';

class KayitKullanici extends StatefulWidget {
  @override
  KayitKullaniciEkrani createState() => KayitKullaniciEkrani();
}

class KayitKullaniciEkrani extends State<KayitKullanici> {
  TextEditingController adController = new TextEditingController();
  TextEditingController soyadController = new TextEditingController();
  TextEditingController tcNoController = new TextEditingController();
  TextEditingController telNoController = new TextEditingController();
  TextEditingController evAdresController = new TextEditingController();
  TextEditingController ePostaAdresController = new TextEditingController();
  TextEditingController kullaniciAdiController = new TextEditingController();
  TextEditingController sifre1Controller = new TextEditingController();
  TextEditingController sifre2Controller = new TextEditingController();

  FocusNode soyadFocus = new FocusNode();
  FocusNode tcNoFocus = new FocusNode();
  FocusNode telNoFocus = new FocusNode();
  FocusNode evAdresFocus = new FocusNode();
  FocusNode ePostaAdresFocus = new FocusNode();
  FocusNode kullaniciAdiFocus = new FocusNode();
  FocusNode sifre1Focus = new FocusNode();
  FocusNode sifre2Focus = new FocusNode();

  bool ischecked = false;
  Database _database = new Database();

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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget customTextBox(
    TextInputType type,
    String placeholder,
    TextEditingController controller,
    TextInputAction action,
    FocusNode ownFocus,
    FocusNode tofocus,
    bool passoword,
  ) {
    return TextField(
      focusNode: ownFocus,
      obscureText: passoword,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Kullanıcı Kayıt'),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF96beff)),
        child: ListView(
          children: <Widget>[
            customTextBox(TextInputType.text, "Adınız", adController,
                TextInputAction.next, null, soyadFocus, false),
            customTextBox(TextInputType.text, "Soyadınız", soyadController,
                TextInputAction.next, soyadFocus, tcNoFocus, false),
            customTextBox(
                TextInputType.number,
                "Tc kimlik numaranız",
                tcNoController,
                TextInputAction.next,
                tcNoFocus,
                telNoFocus,
                false),
            customTextBox(
                TextInputType.number,
                "Telefon numaranızı giriniz",
                telNoController,
                TextInputAction.next,
                telNoFocus,
                evAdresFocus,
                false),
            customTextBox(TextInputType.text, "Ev adresiniz", evAdresController,
                TextInputAction.next, evAdresFocus, ePostaAdresFocus, false),
            customTextBox(
                TextInputType.emailAddress,
                "E-posta adresiniz",
                ePostaAdresController,
                TextInputAction.next,
                ePostaAdresFocus,
                kullaniciAdiFocus,
                false),
            customTextBox(
                TextInputType.text,
                "Kullanıcı adınız",
                kullaniciAdiController,
                TextInputAction.next,
                kullaniciAdiFocus,
                sifre1Focus,
                false),
            customTextBox(
                TextInputType.text,
                "Bir şifre girin",
                sifre1Controller,
                TextInputAction.next,
                sifre1Focus,
                sifre2Focus,
                true),
            customTextBox(
                TextInputType.text,
                "Şifreyi tekrar girin",
                sifre2Controller,
                TextInputAction.next,
                sifre2Focus,
                new FocusNode(),
                true),
            Center(
              child: FlatButton(
                child: Text("Kullanıcı sözleşmesini buradan okuyabilirsiniz",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _launchURL("http://gelengigames.com/privacyPolicy.html");
                },
              ),
            ),
            CheckboxListTile(
              value: ischecked,
              onChanged: (bool changestate) {
                setState(() {
                  ischecked = changestate;
                });
              },
              title: Text(
                "Gizlilik sözleşmesini okudum ve kabul ediyorum",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                "Üye olabilmek için gizlilik sözleşmesini kabul etmelisiniz",
                style: TextStyle(fontSize: 10),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.08,
              child: RaisedButton(
                  child: new Text(
                    "Kayıt",
                    textScaleFactor: 2,
                  ),
                  onPressed: () async {
                    //Kullanıcı Kayıt kodu
                    if (adController.text.isEmpty ||
                        soyadController.text.isEmpty ||
                        tcNoController.text.isEmpty ||
                        telNoController.text.isEmpty ||
                        evAdresController.text.isEmpty ||
                        ePostaAdresController.text.isEmpty ||
                        kullaniciAdiController.text.isEmpty ||
                        sifre1Controller.text.isEmpty ||
                        sifre2Controller.text.isEmpty)
                      _showDialog("Boş alan var",
                          "Kullanıcı kaydı yapabilmek için bütün alanları doldurmanız gerekmektedir.");
                    else {
                      if (sifre1Controller.text != sifre2Controller.text) {
                        _showDialog("Şifreler aynı olmalıdır",
                            "Girmiş olduğunuz şifreler birbiri ile aynı değil lütfen kontrol edin");
                      } else {
                        if (!ischecked)
                          _showDialog("Gizlilik sözleşmesi",
                              "kayıt olmak için gizlilik sözleşmesini kabul etmek zorundasınız");
                        else {
                          bool sonuc = await _database.yeniKullaniciEkle(
                              kullaniciAdiController.text,
                              sifre1Controller.text,
                              adController.text,
                              soyadController.text,
                              tcNoController.text,
                              telNoController.text,
                              evAdresController.text,
                              ePostaAdresController.text);
                          if (sonuc)
                            _showDialog("Ekleme Başarılı",
                                "Kayıt işlemi başarıyla tamamlandı");
                          else
                            _showDialog("Başarısız",
                                "Böyle bir kullanıcı zaten var olabilir");
                        }
                      }
                    }
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            ),
          ],
        ),
      ),
    );
  }
}

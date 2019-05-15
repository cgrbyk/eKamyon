import 'dart:async';
import 'package:flutter/material.dart';
import 'database.dart';
import 'package:url_launcher/url_launcher.dart';

class KayitFirma extends StatefulWidget {
  @override
  KayitFirmaEkrani createState() => KayitFirmaEkrani();
}

class KayitFirmaEkrani extends State<KayitFirma> {
  TextEditingController firmayetkiliadController = new TextEditingController();
  TextEditingController firmayetkilisoyadController =
      new TextEditingController();
  TextEditingController tcNoController = new TextEditingController();
  TextEditingController vergiDaireController = new TextEditingController();
  TextEditingController vergiNumaraController = new TextEditingController();
  TextEditingController telNoController = new TextEditingController();
  TextEditingController bankaAdiController = new TextEditingController();
  TextEditingController bankaIbanNoController = new TextEditingController();
  TextEditingController firmaUnvaniController = new TextEditingController();
  TextEditingController firmaIlController = new TextEditingController();
  TextEditingController firmaIlceController = new TextEditingController();
  TextEditingController firmaAdresiController = new TextEditingController();
  TextEditingController postaKoduController = new TextEditingController();
  TextEditingController ePostaAdresController = new TextEditingController();
  TextEditingController firmaWebSitesiController = new TextEditingController();
  TextEditingController kullaniciAdiController = new TextEditingController();
  TextEditingController sifre1Controller = new TextEditingController();
  TextEditingController sifre2Controller = new TextEditingController();

  FocusNode firmayetkiliadFocusNode = new FocusNode();
  FocusNode firmayetkilisoyadFocusNode = new FocusNode();
  FocusNode tcNoFocusNode = new FocusNode();
  FocusNode vergiDaireFocusNode = new FocusNode();
  FocusNode vergiNumaraFocusNode = new FocusNode();
  FocusNode telNoFocusNode = new FocusNode();
  FocusNode bankaAdiFocusNode = new FocusNode();
  FocusNode bankaIbanNoFocusNode = new FocusNode();
  FocusNode firmaUnvaniFocusNode = new FocusNode();
  FocusNode firmaIlFocusNode = new FocusNode();
  FocusNode firmaIlceFocusNode = new FocusNode();
  FocusNode firmaAdresiFocusNode = new FocusNode();
  FocusNode postaKoduFocusNode = new FocusNode();
  FocusNode ePostaAdresFocusNode = new FocusNode();
  FocusNode firmaWebSitesiFocusNode = new FocusNode();
  FocusNode kullaniciAdiFocusNode = new FocusNode();
  FocusNode sifre1FocusNode = new FocusNode();
  FocusNode sifre2FocusNode = new FocusNode();

  bool ischecked = false;
  Database _database = new Database();

  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
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
            customTextBox(
                TextInputType.text,
                "Firma yetkilisi adı",
                firmayetkiliadController,
                TextInputAction.next,
                null,
                firmayetkilisoyadFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma yetkilisi soyadı",
                firmayetkilisoyadController,
                TextInputAction.next,
                firmayetkilisoyadFocusNode,
                tcNoFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Tc numaranız",
                tcNoController,
                TextInputAction.next,
                tcNoFocusNode,
                vergiDaireFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Vergi daire",
                vergiDaireController,
                TextInputAction.next,
                vergiDaireFocusNode,
                vergiNumaraFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Vergi numaranız",
                vergiNumaraController,
                TextInputAction.next,
                vergiNumaraFocusNode,
                telNoFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Telefon numaranız",
                telNoController,
                TextInputAction.next,
                telNoFocusNode,
                bankaAdiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Banka adı",
                bankaAdiController,
                TextInputAction.next,
                bankaAdiFocusNode,
                bankaIbanNoFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Banka Iban numaranız",
                bankaIbanNoController,
                TextInputAction.next,
                bankaIbanNoFocusNode,
                firmaUnvaniFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma Ünvanı",
                firmaUnvaniController,
                TextInputAction.next,
                firmaUnvaniFocusNode,
                firmaIlFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma İl",
                firmaIlController,
                TextInputAction.next,
                firmaIlFocusNode,
                firmaIlceFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma İlçe",
                firmaIlceController,
                TextInputAction.next,
                firmaIlceFocusNode,
                firmaAdresiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma Adresi",
                firmaAdresiController,
                TextInputAction.next,
                firmaAdresiFocusNode,
                postaKoduFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Firma posta kodu",
                postaKoduController,
                TextInputAction.next,
                postaKoduFocusNode,
                ePostaAdresFocusNode,
                false),
            customTextBox(
                TextInputType.emailAddress,
                "Firma email adresi",
                ePostaAdresController,
                TextInputAction.next,
                ePostaAdresFocusNode,
                firmaWebSitesiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma web sitesi",
                firmaWebSitesiController,
                TextInputAction.next,
                firmaWebSitesiFocusNode,
                kullaniciAdiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Kullanıcı Adı oluşturunuz",
                kullaniciAdiController,
                TextInputAction.next,
                kullaniciAdiFocusNode,
                sifre1FocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Bir şifre oluşturunuz",
                sifre1Controller,
                TextInputAction.next,
                sifre1FocusNode,
                sifre2FocusNode,
                true),
            customTextBox(
                TextInputType.text,
                "Tekrar şifrenizi giriniz",
                sifre2Controller,
                TextInputAction.next,
                sifre2FocusNode,
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
                    if (tcNoController.text.isEmpty ||
                        vergiDaireController.text.isEmpty ||
                        vergiNumaraController.text.isEmpty ||
                        telNoController.text.isEmpty ||
                        bankaAdiController.text.isEmpty ||
                        bankaIbanNoController.text.isEmpty ||
                        firmaUnvaniController.text.isEmpty ||
                        firmaIlController.text.isEmpty ||
                        firmaIlceController.text.isEmpty ||
                        firmaAdresiController.text.isEmpty ||
                        postaKoduController.text.isEmpty ||
                        ePostaAdresController.text.isEmpty ||
                        firmaWebSitesiController.text.isEmpty ||
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
                          bool sonuc = await _database.yeniFirmaEkle(
                              telNoController.text,
                              firmaUnvaniController.text,
                              firmaIlController.text,
                              firmaIlceController.text,
                              firmaAdresiController.text,
                              kullaniciAdiController.text,
                              sifre1Controller.text,
                              ePostaAdresController.text,
                              firmaWebSitesiController.text,
                              firmayetkiliadController.text,
                              firmayetkilisoyadController.text,
                              tcNoController.text,
                              vergiDaireController.text,
                              vergiNumaraController.text,
                              bankaAdiController.text,
                              bankaIbanNoController.text,
                              postaKoduController.text);
                          if (sonuc)
                            _showDialog(
                                "Kayıt Başarılı", "Firma başarıyla kaydedildi");
                          else
                            _showDialog("Kayıt işlemi başarısız",
                                "Zaten böyle bir kullanıcı olabilir");
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

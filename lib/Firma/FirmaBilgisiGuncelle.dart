import 'package:ekamyon/Firma/firmaMenu.dart';
import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';

class FirmaBilgisiGuncelle extends StatefulWidget {
  final FirmaMenuEkrani mainState;
  FirmaBilgisiGuncelle({this.mainState});
  @override
  FirmaBilgisiGuncelleEkrani createState() => FirmaBilgisiGuncelleEkrani(mainState: mainState);
}

class FirmaBilgisiGuncelleEkrani extends State<FirmaBilgisiGuncelle> {
  final FirmaMenuEkrani mainState;
  FirmaBilgisiGuncelleEkrani({this.mainState});
  Database _database = Database();
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
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
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

  TextEditingController firmaAdi = TextEditingController();
  TextEditingController firmaIl = TextEditingController();
  TextEditingController firmaIlce = TextEditingController();
  TextEditingController firmaAdres = TextEditingController();
  TextEditingController vergiDaires = TextEditingController();
  TextEditingController vergiNumarasi = TextEditingController();
  TextEditingController toplamAracSayisi = TextEditingController();
  TextEditingController personelSayisi = TextEditingController();
  TextEditingController sahipOlunanBelgeler = TextEditingController();
  TextEditingController faaliyetSuresi = TextEditingController();
  TextEditingController webSitesi = TextEditingController();
  TextEditingController sabitTel = TextEditingController();
  TextEditingController cepTel = TextEditingController();
  TextEditingController bankaAdiBir = TextEditingController();
  TextEditingController bankaIbanBir = TextEditingController();
  TextEditingController bankaAdiIki = TextEditingController();
  TextEditingController bankaIbanIki = TextEditingController();
  TextEditingController bankaAdiUc = TextEditingController();
  TextEditingController bankaIbanUc = TextEditingController();

  FocusNode firmaAdiNode = FocusNode();
  FocusNode firmaIlNode = FocusNode();
  FocusNode firmaIlceNode = FocusNode();
  FocusNode firmaAdresNode = FocusNode();
  FocusNode vergiDairesNode = FocusNode();
  FocusNode vergiNumarasiNode = FocusNode();
  FocusNode toplamAracSayisiNode = FocusNode();
  FocusNode personelSayisiNode = FocusNode();
  FocusNode sahipOlunanBelgelerNode = FocusNode();
  FocusNode faaliyetSuresiNode = FocusNode();
  FocusNode webSitesiNode = FocusNode();
  FocusNode sabitTelNode = FocusNode();
  FocusNode cepTelNode = FocusNode();
  FocusNode bankaAdiBirNode = FocusNode();
  FocusNode bankaIbanBirNode = FocusNode();
  FocusNode bankaAdiIkiNode = FocusNode();
  FocusNode bankaIbanIkiNode = FocusNode();
  FocusNode bankaAdiUcNode = FocusNode();
  FocusNode bankaIbanUcNode = FocusNode();

  @override
  void initState() {
    super.initState();
    firmaAdi.text = AktifKullaniciBilgileri.firmaAdi;
    firmaIl.text = AktifKullaniciBilgileri.firmaIl;
    firmaIlce.text = AktifKullaniciBilgileri.firmaIlce;
    firmaAdres.text = AktifKullaniciBilgileri.firmaAdres;
    vergiDaires.text = AktifKullaniciBilgileri.firmaVergiDairesi;
    toplamAracSayisi.text = AktifKullaniciBilgileri.firmaAracSayisi;
    personelSayisi.text = AktifKullaniciBilgileri.firmaPersonelSayisi;
    sahipOlunanBelgeler.text = AktifKullaniciBilgileri.firmaBelgeler;
    faaliyetSuresi.text = AktifKullaniciBilgileri.firmaKacYildirFaaliyette;
    webSitesi.text = AktifKullaniciBilgileri.firmaWebSitesi;
    sabitTel.text = AktifKullaniciBilgileri.firmaSabitTel;
    cepTel.text = AktifKullaniciBilgileri.firmaCepTel;
    bankaAdiBir.text = AktifKullaniciBilgileri.firmaBankaBir;
    bankaIbanBir.text = AktifKullaniciBilgileri.firmaIbanBir;
    bankaAdiIki.text = AktifKullaniciBilgileri.firmaBankaIki;
    bankaIbanIki.text = AktifKullaniciBilgileri.firmaIbanIki;
    bankaAdiUc.text = AktifKullaniciBilgileri.firmaBankaUc;
    bankaIbanUc.text = AktifKullaniciBilgileri.firmaIbanUc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Firma Bilgileri Güncelle'),
          actions: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Image.asset('images/logoson.png'))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xFFFFFFFF),
                const Color(0xFFDDDDDD)
              ], // whitish to gray
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: ListView(
            children: <Widget>[
              //                                                               ownFocus     nextFocus
              customTextBox(TextInputType.text, "Firma Adi", firmaAdi,
                  TextInputAction.next, firmaAdiNode, firmaIlNode, false),
              customTextBox(TextInputType.text, "Firma Il", firmaIl,
                  TextInputAction.next, firmaIlNode, firmaIlceNode, false),
              customTextBox(TextInputType.text, "Firma Ilce", firmaIlce,
                  TextInputAction.next, firmaIlceNode, firmaAdresNode, false),
              customTextBox(TextInputType.text, "Firma Adres", firmaAdres,
                  TextInputAction.next, firmaAdresNode, vergiDairesNode, false),
              customTextBox(
                  TextInputType.text,
                  "Vergi Dairesi",
                  vergiDaires,
                  TextInputAction.next,
                  vergiDairesNode,
                  toplamAracSayisiNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "Toplam Araç Sayısı",
                  toplamAracSayisi,
                  TextInputAction.next,
                  toplamAracSayisiNode,
                  personelSayisiNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "Personel Sayısı",
                  personelSayisi,
                  TextInputAction.next,
                  personelSayisiNode,
                  sahipOlunanBelgelerNode,
                  false),
              customTextBox(
                  TextInputType.text,
                  "Sahip olunan belgeler",
                  sahipOlunanBelgeler,
                  TextInputAction.next,
                  sahipOlunanBelgelerNode,
                  faaliyetSuresiNode,
                  false),
              customTextBox(TextInputType.phone, "Web Sitesi", webSitesi,
                  TextInputAction.next, webSitesiNode, sabitTelNode, false),
              customTextBox(TextInputType.phone, "Sabit telefon", sabitTel,
                  TextInputAction.next, sabitTelNode, cepTelNode, false),
              customTextBox(TextInputType.text, "Ceb telefonu", cepTel,
                  TextInputAction.next, cepTelNode, bankaAdiBirNode, false),
              customTextBox(
                  TextInputType.text,
                  "1.Banka Adi",
                  bankaAdiBir,
                  TextInputAction.next,
                  bankaAdiBirNode,
                  bankaIbanBirNode,
                  false),
              customTextBox(
                  TextInputType.text,
                  "1.Banka Iban",
                  bankaIbanBir,
                  TextInputAction.next,
                  bankaIbanBirNode,
                  bankaAdiIkiNode,
                  false),
              customTextBox(
                  TextInputType.text,
                  "2.Banka Adi",
                  bankaAdiIki,
                  TextInputAction.next,
                  bankaAdiIkiNode,
                  bankaIbanIkiNode,
                  false),
              customTextBox(
                  TextInputType.text,
                  "2.Banka Iban",
                  bankaIbanIki,
                  TextInputAction.next,
                  bankaIbanIkiNode,
                  bankaAdiUcNode,
                  false),
              customTextBox(TextInputType.text, "3.Banka Adi", bankaAdiUc,
                  TextInputAction.next, bankaAdiUcNode, bankaIbanUcNode, false),
              customTextBox(
                  TextInputType.text,
                  "3.Banka Iban",
                  bankaIbanUc,
                  TextInputAction.done,
                  bankaIbanUcNode,
                  new FocusNode(),
                  false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Vazgeç",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Değişiklikleri Kaydet",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                    onPressed: () async {
                      bool sonuc = await _database.firmaBilgileriGuncelle(
                          firmaAdi.text,
                          firmaIl.text,
                          firmaIlce.text,
                          firmaAdres.text,
                          vergiDaires.text,
                          vergiNumarasi.text,
                          toplamAracSayisi.text,
                          personelSayisi.text,
                          sahipOlunanBelgeler.text,
                          faaliyetSuresi.text,
                          webSitesi.text,
                          sabitTel.text,
                          cepTel.text,
                          bankaAdiBir.text,
                          bankaIbanBir.text,
                          bankaAdiIki.text,
                          bankaIbanIki.text,
                          bankaAdiUc.text,
                          bankaIbanUc.text);
                      if (sonuc)
                        _showDialog("Değişiklier kaydedildi",
                            "Yaptığınız değişiklikler başarıyla kaydedildi");
                      else
                        _showDialog("Kayıt başarısız", "Değşiklikler kaydedilirken bir hata meydana geldi");          
                        mainState.stateGuncelle();            
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'package:ekamyon/Musteri/kullaniciMenu.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';

class KullaniciBilgileri extends StatefulWidget {
  final KullaniciMenuEkrani mainState;
  KullaniciBilgileri({this.mainState});
  @override
  _KullaniciBilgileriState createState() => _KullaniciBilgileriState(mainState: mainState);
}

class _KullaniciBilgileriState extends State<KullaniciBilgileri> {

  final KullaniciMenuEkrani mainState;
  _KullaniciBilgileriState({this.mainState});

  TextEditingController kulAdi = TextEditingController();
  TextEditingController kulIsim = TextEditingController();
  TextEditingController kulSoyIsim = TextEditingController();
  TextEditingController kulTc = TextEditingController();
  TextEditingController kulTelNo = TextEditingController();
  TextEditingController kulEposta = TextEditingController();
  TextEditingController kulAdres = TextEditingController();

  TextEditingController kulPass1 = TextEditingController();
  TextEditingController kulPass2 = TextEditingController();
  FocusNode kulPass2Node = FocusNode();

  FocusNode kulAdiNode = FocusNode();
  FocusNode kulIsimNode = FocusNode();
  FocusNode kulSoyIsimNode = FocusNode();
  FocusNode kulTcNode = FocusNode();
  FocusNode kulTelNoNode = FocusNode();
  FocusNode kulEpostaNode = FocusNode();
  FocusNode kulAdresNode = FocusNode();

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
  chooseColor(bool isEnable)
  {
    if(isEnable)
      return Colors.black;
    else
      return Colors.grey;
  }

  Widget customTextBox(
      TextInputType type,
      String placeholder,
      TextEditingController controller,
      TextInputAction action,
      FocusNode ownFocus,
      FocusNode tofocus,
      bool isEnable,
      bool password) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: TextField(       
        enabled: isEnable,
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
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 15,color: chooseColor(isEnable)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    kulAdi.text = AktifKullaniciBilgileri.musteriKullaniciAdi;
    kulIsim.text = AktifKullaniciBilgileri.musteriAdi;
    kulSoyIsim.text = AktifKullaniciBilgileri.musteriSoyadi;
    kulTc.text = AktifKullaniciBilgileri.musteriTcNo;
    kulTelNo.text = AktifKullaniciBilgileri.musteriTelNo;
    kulEposta.text = AktifKullaniciBilgileri.musteriEposta;
    kulAdres.text = AktifKullaniciBilgileri.musteriAdresi;

    kulPass1.text = AktifKullaniciBilgileri.musteriSifresi;
    kulPass2.text = AktifKullaniciBilgileri.musteriSifresi;
  }

  @override
  Widget build(BuildContext context) {
    Database _database = Database();
    return Scaffold(
        backgroundColor: Colors.blue[400],
        appBar: AppBar(
          title: Text('Bilgileri Güncelle'),
          actions: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Image.asset('images/logoson.png'))
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    customTextBox(TextInputType.text, "Kullanıcı Adı", kulAdi,
                        TextInputAction.next, null, kulIsimNode, false, false),
                    customTextBox(
                        TextInputType.text,
                        "İsiminiz",
                        kulIsim,
                        TextInputAction.next,
                        kulIsimNode,
                        kulSoyIsimNode,
                        false,
                        false),
                    customTextBox(
                        TextInputType.text,
                        "Soy İsiminiz",
                        kulSoyIsim,
                        TextInputAction.next,
                        kulSoyIsimNode,
                        kulTcNode,
                        false,
                        false),
                    customTextBox(
                        TextInputType.number,
                        "Tc Numarası",
                        kulTc,
                        TextInputAction.next,
                        kulTcNode,
                        kulTelNoNode,
                        false,
                        false),
                    customTextBox(
                        TextInputType.phone,
                        "Tel No",
                        kulTelNo,
                        TextInputAction.next,
                        kulTelNoNode,
                        kulAdresNode,
                        true,
                        false),
                    customTextBox(
                        TextInputType.text,
                        "Ev Adresi",
                        kulAdres,
                        TextInputAction.next,
                        kulAdresNode,
                        kulEpostaNode,
                        true,
                        false),
                    customTextBox(
                        TextInputType.emailAddress,
                        "Eposta Adresi",
                        kulEposta,
                        TextInputAction.done,
                        kulEpostaNode,
                        new FocusNode(),
                        true,
                        false),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    customTextBox(TextInputType.text, "Şifreniz", kulPass1,
                        TextInputAction.next, null, kulPass2Node, false, true),
                    customTextBox(
                        TextInputType.text,
                        "Tekrar Şifre",
                        kulPass2,
                        TextInputAction.next,
                        kulPass2Node,
                        new FocusNode(),
                        false,
                        true)
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text("Vazgeç",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text(
                      "Kaydet",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      bool sonuc = await _database.kullaniciBilgileriGuncelle(
                          kulTelNo.text, kulAdres.text, kulEposta.text);
                      if (sonuc)
                        _showDialog("Güncelleme başarılı",
                            "girmiş olduğunuz bilgiler başarıyla güncellendi");
                      else
                        _showDialog("Hata", "Güncelleme sırasında hata");
                        mainState.stateGuncelle();
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

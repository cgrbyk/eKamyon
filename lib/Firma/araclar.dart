import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ekamyon/database.dart';
import 'package:ekamyon/Modeller/arac.dart';

class AracListe extends StatefulWidget {
  @override
  AracListeEkrani createState() => AracListeEkrani();
}

class AracListeEkrani extends State<AracListe> {
  Database _database = Database();
  List<Arac> araclar = new List<Arac>();

  bool aracaktifmi = false;

  @override
  void initState() {
    aracListesiDoldur();
    super.initState();
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

  aracListesiDoldur() async {
    araclar = Arac.fromArray(await _database.araclar());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Araçlarım'),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
        ],
      ),
      body: Container(
        color: Color(0xFF96beff),
        child: ListView.builder(
          itemCount: araclar.length,
          itemBuilder: (context, index) {
            if (araclar.length != 0) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: <Widget>[
                          Text("Araç plakası",
                              style: TextStyle(
                                  color: Colors.grey[1000], fontSize: 14)),
                          Text(araclar[index].aracPlakasi,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        child: Text("Araç detay"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AracGuncellemeDialog(
                                  arac: araclar[index],
                                  ale: this,
                                );
                              });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: RaisedButton(
                        child: Text("Araç Müsaitlik Tarihi"),
                        onPressed: () {
                          //araç müsaitlik ekranı
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: RaisedButton(
            color: Colors.white,
            child: Text("Araç Ekle"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AracEklemeDialog(
                      ale: this,
                    );
                  });
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
      ),
    );
  }
}

class AracEklemeDialog extends StatefulWidget {
  final AracListeEkrani ale;
  AracEklemeDialog({this.ale});
  @override
  YeniAracEkle createState() => new YeniAracEkle(ale: ale);
}

class YeniAracEkle extends State<AracEklemeDialog> {
  final AracListeEkrani ale;
  YeniAracEkle({this.ale});
  TextEditingController aracPlaka = TextEditingController();
  TextEditingController aracMarka = TextEditingController();
  TextEditingController aracModel = TextEditingController();

  FocusNode aracMarkaNode = FocusNode();
  FocusNode aracModelNode = FocusNode();

  Database _database = Database();
  bool aracaktifmi = false;

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
      backgroundColor: Color(0x00000000),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Yeni Araç Ekle",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )),
              ),
              customTextBox(TextInputType.text, "Araç Plakası", aracPlaka,
                  TextInputAction.next, null, new FocusNode(), false),
              customTextBox(TextInputType.text, "Araç Markası", aracMarka,
                  TextInputAction.next, aracMarkaNode, new FocusNode(), false),
              customTextBox(TextInputType.text, "Araç Modeli", aracModel,
                  TextInputAction.send, aracModelNode, new FocusNode(), false),
              CheckboxListTile(
                  title: Text("Aracınız aktif kullanılıyor mu ?"),
                  value: aracaktifmi,
                  onChanged: (bool yd) {
                    setState(() {
                      aracaktifmi = yd;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text("İptal",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                    new FlatButton(
                      child: new Text("Ekle",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (aracPlaka.text != "" ||
                            aracMarka.text != "" ||
                            aracModel.text != "") {
                          await _database.yeniAracKayit(aracPlaka.text,
                              aracMarka.text, aracModel.text, aracaktifmi);
                          Navigator.of(context).pop();
                          _showDialog(
                              "Ekleme Başarılı", "Yeni aracınız eklenmiştir.");
                          ale.aracListesiDoldur();
                          setState(() {});
                        } else {
                          _showDialog("Boş bırakılamaz",
                              "Bütün alanları doldurmalısınız");
                        }
                      },
                    ),     
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AracGuncellemeDialog extends StatefulWidget {
  final Arac arac;
  final AracListeEkrani ale;
  AracGuncellemeDialog({this.arac, this.ale});
  @override
  AracGuncelleme createState() => new AracGuncelleme(arac: arac, ale: ale);
}

class AracGuncelleme extends State<AracGuncellemeDialog> {
  final Arac arac;
  final AracListeEkrani ale;
  AracGuncelleme({this.arac, this.ale});
  TextEditingController aracPlaka = TextEditingController();
  TextEditingController aracMarka = TextEditingController();
  TextEditingController aracModel = TextEditingController();

  FocusNode aracMarkaNode = FocusNode();
  FocusNode aracModelNode = FocusNode();

  Database _database = Database();
  bool aracaktifmi = false;

  @override
  void initState() {
    super.initState();
    aracPlaka.text = arac.aracPlakasi;
    aracMarka.text = arac.aracMarkasi;
    aracModel.text = arac.aracModel;
    arac.aracAktifmi == "true" ? aracaktifmi = true : aracaktifmi = false;
  }

  _showDialog(String title, String message) {
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

  _showQuestionDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Evet"),
              onPressed: () async {
                Navigator.of(context).pop();
                bool islemsonuc = await _database.aracSil(arac.aracPlakasi);
                if (islemsonuc) {
                  _showDialog("Araç silme", "Araç silme işlemi başarılı.");
                  ale.aracListesiDoldur();
                  setState(() {});
                }
              },
            ),
            new FlatButton(
              child: new Text("Hayır"),
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
        backgroundColor: Color(0x00000000),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 8, right: 8, bottom: 15),
                    child: Center(
                        child: Text(
                      "Araç bilgileri",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ),
                  customTextBox(TextInputType.text, "Araç Plakası", aracPlaka,
                      TextInputAction.next, null, aracMarkaNode, false),
                  customTextBox(
                      TextInputType.text,
                      "Araç Markası",
                      aracMarka,
                      TextInputAction.next,
                      aracMarkaNode,
                      aracModelNode,
                      false),
                  customTextBox(
                      TextInputType.text,
                      "Araç Modeli",
                      aracModel,
                      TextInputAction.send,
                      aracModelNode,
                      new FocusNode(),
                      false),
                  CheckboxListTile(
                      title: Text("Aracınız aktif kullanılıyor mu ?"),
                      value: aracaktifmi,
                      onChanged: (bool yd) {
                        setState(() {
                          aracaktifmi = yd;
                        });
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new GestureDetector(
                          child: new Text("Bilgileri Güncelle",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          onTap: () async {
                            if (aracPlaka.text != "" ||
                                aracMarka.text != "" ||
                                aracModel.text != "") {
                              await _database.aracBilgiGuncelle(aracPlaka.text,
                                  aracMarka.text, aracModel.text, aracaktifmi);
                              _showDialog(
                                  "Araç", "Araç bilgileriniz güncellenmiştir.");
                              setState(() {});
                            } else {
                              _showDialog("Boş bırakılamaz",
                                  "Bütün alanları doldurmalısınız");
                            }
                          },
                        ),
                        new GestureDetector(
                          child: new Text("Araçı Sil",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          onTap: () async {
                            _showQuestionDialog(
                                "Aracı Sil",
                                arac.aracPlakasi +
                                    " Plakalı aracı silmek istediğinizden emin misiniz?");
                            setState(() {});
                          },
                        ),
                        new GestureDetector(
                          child: new Text("Kapat",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/Modeller/EkFiyatlar.dart';
import 'package:ekamyon/Modeller/Ilce.dart';
import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'package:ekamyon/Modeller/sehirIciFiyat.dart';
import 'package:flutter/material.dart';
import 'package:ekamyon/database.dart';
import 'package:ekamyon/Modeller/Fiyat.dart';

class FiyatListe extends StatefulWidget {
  @override
  FiyatListeEkrani createState() => FiyatListeEkrani();
}

class FiyatListeEkrani extends State<FiyatListe> {
  Database _database = Database();
  List<Fiyat> fiyatlar = new List<Fiyat>();

  TextEditingController teklicontroller = TextEditingController();
  TextEditingController yakitcontroller = TextEditingController();
  TextEditingController iscilikcontroller = TextEditingController();
  TextEditingController asansorcontroller = TextEditingController();
  TextEditingController karcontroller = TextEditingController();
  TextEditingController ilcecontroller = TextEditingController();

  FocusNode yakitNode = FocusNode();
  FocusNode iscilikNode = FocusNode();
  FocusNode karNode = FocusNode();
  FocusNode asansorNode = FocusNode();
  int toplamFiya = 0;
  int itemCount = 1;

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
        toplamFiya = int.tryParse(yakitcontroller.text) ?? 0;
        toplamFiya += int.tryParse(iscilikcontroller.text) ?? 0;
        toplamFiya += int.tryParse(asansorcontroller.text) ?? 0;
        toplamFiya += int.tryParse(karcontroller.text) ?? 0;
        FocusScope.of(context).requestFocus(tofocus);
        if (this.mounted) {
          setState(() {});
        }
      },
      style: TextStyle(
          fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 20),
    );
  }

  @override
  void initState() {
    fiyatListesiDoldur();
    super.initState();
  }

  fiyatListesiDoldur() async {
    fiyatlar = Fiyat.fromArray(await _database.fiyatlariCek());
    itemCount = fiyatlar.length;
    if (this.mounted) {
      setState(() {});
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

  _showDialogTekliFiyat(Fiyat f) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Rota için yeni fiyatı giriniz"),
          content: ListView(
            shrinkWrap: true,
            children: <Widget>[
              customTextBox(
                  TextInputType.number,
                  "Yakit Masrafi",
                  yakitcontroller,
                  TextInputAction.done,
                  yakitNode,
                  iscilikNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "İşcilik Ücreti",
                  iscilikcontroller,
                  TextInputAction.done,
                  iscilikNode,
                  asansorNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "Asansör Bedeli",
                  asansorcontroller,
                  TextInputAction.done,
                  asansorNode,
                  karNode,
                  false),
              customTextBox(TextInputType.number, "Firma Kârı", karcontroller,
                  TextInputAction.done, karNode, new FocusNode(), false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text("ToplamFiyat :",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(toplamFiya.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("İptal"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Güncelle"),
              onPressed: () async {
                await _database.tekliFiyatGuncelle(
                    yakitcontroller.text,
                    iscilikcontroller.text,
                    asansorcontroller.text,
                    karcontroller.text,
                    toplamFiya.toString(),
                    f.varisIl,
                    f.evTipi);
                Navigator.of(context).pop();
                await fiyatListesiDoldur();
              },
            ),
          ],
        );
      },
    );
  }

  _showDialogSilme(Fiyat f) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Fiyat Silme"),
          content: new Text("Bu fiyatı silmek istediğinizden emin misiniz ?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Evet"),
              onPressed: () async {
                await _database.fiyatsil(
                    f.varisIl, f.evTipi, f.tasimaUcretiTam);
                Navigator.of(context).pop();
                await fiyatListesiDoldur();
                return true;
              },
            ),
            new FlatButton(
              child: new Text("hayır"),
              onPressed: () {
                Navigator.of(context).pop();
                return false;
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Color(0xFF96beff),
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: AutoSizeText('Fiyat Listesi'),
            actions: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Image.asset('images/logoson.png'))
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.location_city),
                  text: "Şehir arası",
                ),
                Tab(
                  icon: Icon(Icons.home),
                  text: "Şehir içi",
                ),
                Tab(
                  icon: Icon(Icons.donut_small),
                  text: "Km başına fiyat",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        if (fiyatlar.length != 0) {
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Text("Varış İl",
                                          style: TextStyle(
                                              color: Colors.grey[1000],
                                              fontSize: 14)),
                                      Text(fiyatlar[index].varisIl,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Ev Tipi",
                                        style: TextStyle(
                                            color: Colors.grey[1000],
                                            fontSize: 14)),
                                    Text(fiyatlar[index].evTipi.split('.')[0]+"+1",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12)),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Fiyat",
                                        style: TextStyle(
                                            color: Colors.grey[1000],
                                            fontSize: 14)),
                                    Text(fiyatlar[index].tasimaUcretiTam,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12)),
                                  ],
                                ),
                                FlatButton(
                                  highlightColor: Colors.blue[100],
                                  child: Text("Fiyat Güncelle",style: TextStyle(color: Colors.blue,fontSize: 12)),
                                  onPressed: () {
                                    _showDialogTekliFiyat(fiyatlar[index]);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: FlatButton(
                                    highlightColor: Colors.blue[100],
                                    child: Text("Sil",style: TextStyle(color: Colors.blue,fontSize: 12)),
                                    onPressed: () {
                                      _showDialogSilme(fiyatlar[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                          child: Text("Yeni Fiyat"),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30)),
                          onPressed: () async {
                            //yeni fiyat ekle
                            await showDialog(
                                context: context,
                                builder: (_) {
                                  return FiyatDialog(
                                    fle: this,
                                    isSehirlerArasi: true,
                                  );
                                });
                            if (this.mounted) {
                              setState(() {});
                            }
                          }),
                      RaisedButton(
                        child: Text("Toplu Fiyat Güncelle"),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30)),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return TopluFiyatGuncelle(
                                  fle: this,
                                  isSehirlerArasi: true,
                                );
                              });
                          if (this.mounted) {
                            setState(() {});
                          }
                          //toplu fiyat Güncelle
                        },
                      ),
                    ],
                  )
                ],
              ),
              SecondPage(),
              ThridPage(),
            ],
          )),
    );
  }
}

class ThridPage extends StatefulWidget {
  @override
  _ThridPageState createState() => _ThridPageState();
}

class _ThridPageState extends State<ThridPage> {
  EkFiyatlar ekFiyatlar = new EkFiyatlar();
  Database _database = Database();
  TextEditingController var1Controller = TextEditingController();
  TextEditingController var2Controller = TextEditingController();
  TextEditingController var3Controller = TextEditingController();
  TextEditingController var4Controller = TextEditingController();
  bool loading = true;
  @override
  void initState() {
    ekFiyatlariAl();
    super.initState();
  }

  ekFiyatlariAl() async {
    loading = true;
    if (this.mounted) {
      setState(() {});
    }
    ekFiyatlar = await _database.ekFiyatlariCek();
    loading = false;
    if (this.mounted) {
      setState(() {});
    }
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
        hintStyle: TextStyle(fontSize: 12),
      ),
      controller: controller,
      textInputAction: action,
      onSubmitted: (String s) {
        FocusScope.of(context).requestFocus(tofocus);
        if (this.mounted) {
          setState(() {});
        }
      },
      style: TextStyle(
          fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Builder(
      builder: (context) {
        if (!loading) {
          return GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "10-30 KM",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Her taşımada + " +
                                ekFiyatlar.var1.toString() +
                                " TL")),
                        Row(
                          children: <Widget>[
                            AutoSizeText("yeni fiyat :"),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customTextBox(
                                    TextInputType.number,
                                    "Yeni Fiyat",
                                    var1Controller,
                                    TextInputAction.done,
                                    null,
                                    null,
                                    false),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("Güncelle",
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () async {
                              if (var1Controller.text.isNotEmpty)
                                await _database.ekFiyatGuncelle(
                                    var1Controller.text,
                                    ekFiyatlar.var2.toString(),
                                    ekFiyatlar.var3.toString(),
                                    ekFiyatlar.var4.toString());
                              ekFiyatlariAl();
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "30-50 KM",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Her taşımada + " +
                                ekFiyatlar.var2.toString() +
                                " TL")),
                        Row(
                          children: <Widget>[
                            AutoSizeText("yeni fiyat :"),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customTextBox(
                                    TextInputType.number,
                                    "Yeni Fiyat",
                                    var2Controller,
                                    TextInputAction.done,
                                    null,
                                    null,
                                    false),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("Güncelle",
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () async {
                              if (var2Controller.text.isNotEmpty)
                                await _database.ekFiyatGuncelle(
                                    ekFiyatlar.var1.toString(),
                                    var2Controller.text,
                                    ekFiyatlar.var3.toString(),
                                    ekFiyatlar.var4.toString());
                              ekFiyatlariAl();
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "50-120 KM",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Her taşımada + " +
                                ekFiyatlar.var3.toString() +
                                " TL")),
                        Row(
                          children: <Widget>[
                            AutoSizeText("yeni fiyat :"),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customTextBox(
                                    TextInputType.number,
                                    "Yeni Fiyat",
                                    var3Controller,
                                    TextInputAction.done,
                                    null,
                                    null,
                                    false),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("Güncelle",
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () async {
                              if (var3Controller.text.isNotEmpty)
                                await _database.ekFiyatGuncelle(
                                    ekFiyatlar.var1.toString(),
                                    ekFiyatlar.var2.toString(),
                                    var3Controller.text,
                                    ekFiyatlar.var4.toString());
                              ekFiyatlariAl();
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "120-250 KM",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Her taşımada + " +
                                ekFiyatlar.var4.toString() +
                                " TL")),
                        Row(
                          children: <Widget>[
                            AutoSizeText("yeni fiyat :"),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customTextBox(
                                    TextInputType.number,
                                    "Yeni Fiyat",
                                    var4Controller,
                                    TextInputAction.done,
                                    null,
                                    null,
                                    false),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text("Güncelle",
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () async {
                              if (var4Controller.text.isNotEmpty)
                                await _database.ekFiyatGuncelle(
                                    ekFiyatlar.var1.toString(),
                                    ekFiyatlar.var2.toString(),
                                    ekFiyatlar.var3.toString(),
                                    var4Controller.text);
                              ekFiyatlariAl();
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        } else {
          return Center(
              child: Container(
                  height: 80, width: 80, child: CircularProgressIndicator()));
        }
      },
    ));
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Database _database = Database();
  List<SehirIciFiyat> sehirIciFiyatlar = List<SehirIciFiyat>();
  TextEditingController teklicontroller = TextEditingController();
  TextEditingController yakitcontroller = TextEditingController();
  TextEditingController iscilikcontroller = TextEditingController();
  TextEditingController asansorcontroller = TextEditingController();
  TextEditingController karcontroller = TextEditingController();
  TextEditingController ilcecontroller = TextEditingController();

  FocusNode yakitNode = FocusNode();
  FocusNode iscilikNode = FocusNode();
  FocusNode karNode = FocusNode();
  FocusNode asansorNode = FocusNode();
  int toplamFiya = 0;
  int itemCount = 1;

  void initState() {
    fiyatListesiDoldur();
    super.initState();
  }

  fiyatListesiDoldur() async {
    sehirIciFiyatlar =
        SehirIciFiyat.fromArray(await _database.sehiIcifiyatlariCek());
    itemCount = sehirIciFiyatlar.length;
    if (this.mounted) {
      setState(() {});
    }
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
        toplamFiya = int.tryParse(yakitcontroller.text) ?? 0;
        toplamFiya += int.tryParse(iscilikcontroller.text) ?? 0;
        toplamFiya += int.tryParse(asansorcontroller.text) ?? 0;
        toplamFiya += int.tryParse(karcontroller.text) ?? 0;
        FocusScope.of(context).requestFocus(tofocus);
        if (this.mounted) {
          setState(() {});
        }
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

  _showDialogSehirIciSilme(SehirIciFiyat f) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Fiyat Silme"),
          content: new Text("Bu fiyatı silmek istediğinizden emin misiniz ?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Evet"),
              onPressed: () async {
                await _database.fiyatsil(
                    f.varisIl, f.evTipi, f.tasimaUcretiTam);
                Navigator.of(context).pop();
                await fiyatListesiDoldur();
                return true;
              },
            ),
            new FlatButton(
              child: new Text("hayır"),
              onPressed: () {
                Navigator.of(context).pop();
                return false;
              },
            ),
          ],
        );
      },
    );
  }

  _showDialogTekliSehirIciFiyat(SehirIciFiyat f) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Rota için yeni fiyatı giriniz"),
          content: ListView(
            shrinkWrap: true,
            children: <Widget>[
              customTextBox(
                  TextInputType.number,
                  "Yakit Masrafi " + f.yakitMasrafi,
                  yakitcontroller,
                  TextInputAction.done,
                  yakitNode,
                  iscilikNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "İşcilik Ücreti " + f.iscilikUcreti,
                  iscilikcontroller,
                  TextInputAction.done,
                  iscilikNode,
                  asansorNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "Asansör Bedeli " + f.asansorBedeli,
                  asansorcontroller,
                  TextInputAction.done,
                  asansorNode,
                  karNode,
                  false),
              customTextBox(
                  TextInputType.number,
                  "Firma Kârı " + f.firmaKari,
                  karcontroller,
                  TextInputAction.done,
                  karNode,
                  new FocusNode(),
                  false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text("ToplamFiyat :",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(toplamFiya.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("İptal"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Güncelle"),
              onPressed: () async {
                await _database.tekliSehirIciFiyatGuncelle(
                    yakitcontroller.text,
                    iscilikcontroller.text,
                    asansorcontroller.text,
                    karcontroller.text,
                    toplamFiya.toString(),
                    f.varisIlce,
                    f.evTipi);
                Navigator.of(context).pop();
                await fiyatListesiDoldur();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (sehirIciFiyatlar.length != 0) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          children: <Widget>[
                            Text("Varış İlçe",
                                style: TextStyle(
                                    color: Colors.grey[1000], fontSize: 14)),
                            Text(sehirIciFiyatlar[index].varisIlce,
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12)),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text("Ev Tipi",
                              style: TextStyle(
                                  color: Colors.grey[1000], fontSize: 14)),
                          Text(sehirIciFiyatlar[index].evTipi.split('.')[0]+"+1",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("Fiyat",
                              style: TextStyle(
                                  color: Colors.grey[1000], fontSize: 14)),
                          Text(sehirIciFiyatlar[index].tasimaUcretiTam,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                      FlatButton(
                        highlightColor: Colors.blue[100],
                        child: Text("Fiyat Güncelle",style: TextStyle(color: Colors.blue,fontSize: 12)),
                        onPressed: () {
                          _showDialogTekliSehirIciFiyat(
                              sehirIciFiyatlar[index]);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: FlatButton(
                          highlightColor: Colors.blue[100],
                          child: Text("Sil",style: TextStyle(color: Colors.blue,fontSize: 12)),
                          onPressed: () {
                            _showDialogSehirIciSilme(sehirIciFiyatlar[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                child: Text("Yeni Fiyat"),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () async {
                  //yeni fiyat ekle
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return FiyatDialog(
                          fle: this,
                          isSehirlerArasi: false,
                        );
                      });
                  if (this.mounted) {
                    setState(() {});
                  }
                }),
            RaisedButton(
              child: Text("Toplu Fiyat Güncelle"),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30)),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (_) {
                      return TopluFiyatGuncelle(
                        fle: this,
                        isSehirlerArasi: false,
                      );
                    });
                if (this.mounted) {
                  setState(() {});
                }
                //toplu fiyat Güncelle
              },
            ),
          ],
        )
      ],
    );
  }
}

class TopluFiyatGuncelle extends StatefulWidget {
  var fle;
  final bool isSehirlerArasi;
  TopluFiyatGuncelle({this.fle, this.isSehirlerArasi});
  @override
  _TopluFiyatGuncelleState createState() =>
      _TopluFiyatGuncelleState(fle: fle, isSehirlerArasi: isSehirlerArasi);
}

class _TopluFiyatGuncelleState extends State<TopluFiyatGuncelle> {
  var fle;
  final bool isSehirlerArasi;
  _TopluFiyatGuncelleState({this.fle, this.isSehirlerArasi});
  TextEditingController toplucontroller = TextEditingController();
  Database _database = Database();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Toplu Fiyat Güncelle"),
      content: TextField(
        controller: toplucontroller,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Fiyat",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("İptal"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text("ARTIR"),
          onPressed: () async {
            await _database.topluFiyatGuncelle(
                "0", toplucontroller.text, isSehirlerArasi);
            Navigator.of(context).pop();
            await fle.fiyatListesiDoldur();
          },
        ),
        new FlatButton(
          child: new Text("AZALT"),
          onPressed: () async {
            await _database.topluFiyatGuncelle(
                "1", toplucontroller.text, isSehirlerArasi);
            Navigator.of(context).pop();
            await fle.fiyatListesiDoldur();
          },
        ),
      ],
    );
  }
}

class FiyatDialog extends StatefulWidget {
  var fle;
  final bool isSehirlerArasi;
  FiyatDialog({this.fle, this.isSehirlerArasi});
  FiyatDialogPopup createState() =>
      FiyatDialogPopup(fle: fle, isSehirlerArasi: isSehirlerArasi);
}

class FiyatDialogPopup extends State<FiyatDialog> {
  var fle;
  final bool isSehirlerArasi;
  FiyatDialogPopup({this.fle, this.isSehirlerArasi});
  TextEditingController yakitcontroller = TextEditingController();
  TextEditingController iscilikcontroller = TextEditingController();
  TextEditingController asansorcontroller = TextEditingController();
  TextEditingController karcontroller = TextEditingController();

  FocusNode yakitNode = FocusNode();
  FocusNode iscilikNode = FocusNode();
  FocusNode karNode = FocusNode();
  FocusNode asansorNode = FocusNode();
  int toplamFiya = 0;

  List<String> sehirler = [
    'Adana',
    'Adıyaman',
    'Afyon',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce'
  ];
  List<Ilce> ilceler = List<Ilce>();
  List<DropdownMenuItem> sehirlerDDM = List<DropdownMenuItem>();
  List<DropdownMenuItem> ilcelerDDM = List<DropdownMenuItem>();
  String curItemSehir;
  String curItemIlce;
  bool aracaktifmi = false;

  List<String> evTipleri = ['1+1', '2+1', '3+1', '4+1'];
  List<DropdownMenuItem> evTipleriDDM = List<DropdownMenuItem>();
  String curItemEv;

  Database _database = Database();

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
        toplamFiya = int.tryParse(yakitcontroller.text) ?? 0;
        toplamFiya += int.tryParse(iscilikcontroller.text) ?? 0;
        toplamFiya += int.tryParse(asansorcontroller.text) ?? 0;
        toplamFiya += int.tryParse(karcontroller.text) ?? 0;
        FocusScope.of(context).requestFocus(tofocus);
        if (this.mounted) {
          setState(() {});
        }
      },
      style: TextStyle(
          fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 20),
    );
  }

  @override
  void initState() {
    for (String sehir in sehirler) {
      sehirlerDDM.add(new DropdownMenuItem(
        value: sehir,
        child: new Text(sehir),
      ));
    }
    for (String evtipi in evTipleri) {
      evTipleriDDM.add(new DropdownMenuItem(
        value: evtipi,
        child: new Text(evtipi),
      ));
    }
    curItemSehir = sehirler.first;
    curItemEv = evTipleri.first;
    ilceGetir();
    super.initState();
  }

  ilceGetir() async {
    ilceler = Ilce.fromArray(
        await _database.ilceBilgileriCek(AktifKullaniciBilgileri.firmaIl));
    for (Ilce ilce in ilceler) {
      ilcelerDDM.add(new DropdownMenuItem(
        value: ilce.ilceAdi,
        child: new Text(ilce.ilceAdi),
      ));
    }
    curItemIlce = ilceler.first.ilceAdi;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Yeni Rota ve Fiyat Ekle",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )),
                Visibility(
                  visible: isSehirlerArasi,
                  child: DropdownButton(
                    isExpanded: true,
                    items: sehirlerDDM,
                    value: curItemSehir,
                    onChanged: (dynamic dmi) {
                      curItemSehir = dmi;
                      if (this.mounted) {
                        setState(() {});
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: !isSehirlerArasi,
                  child: DropdownButton(
                    isExpanded: true,
                    items: ilcelerDDM,
                    value: curItemIlce,
                    onChanged: (dynamic dmi) {
                      curItemIlce = dmi;
                      if (this.mounted) {
                        setState(() {});
                      }
                    },
                  ),
                ),
                DropdownButton(
                  items: evTipleriDDM,
                  value: curItemEv,
                  isExpanded: true,
                  onChanged: (dynamic dmi) {
                    curItemEv = dmi;
                    if (this.mounted) {
                      setState(() {});
                    }
                  },
                ),
                customTextBox(
                    TextInputType.number,
                    "Yakit Masrafi",
                    yakitcontroller,
                    TextInputAction.done,
                    yakitNode,
                    iscilikNode,
                    false),
                customTextBox(
                    TextInputType.number,
                    "İşcilik Ücreti",
                    iscilikcontroller,
                    TextInputAction.done,
                    iscilikNode,
                    asansorNode,
                    false),
                customTextBox(
                    TextInputType.number,
                    "Asansör Bedeli",
                    asansorcontroller,
                    TextInputAction.done,
                    asansorNode,
                    karNode,
                    false),
                customTextBox(TextInputType.number, "Firma Kârı", karcontroller,
                    TextInputAction.done, karNode, new FocusNode(), false),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("ToplamFiyat :",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(toplamFiya.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new FlatButton(
                          child: new Text("İptal",
                              style: TextStyle(color: Colors.blue)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      new FlatButton(
                        child: new Text("Fiyatı Kaydet",
                            style: TextStyle(color: Colors.blue)),
                        onPressed: () async {
                          //database den kaydfet
                          String oda = curItemEv
                              .replaceAll('+', '.')
                              .split('')
                              .reversed
                              .join();
                          if (yakitcontroller.text.isEmpty ||
                              iscilikcontroller.text.isEmpty ||
                              asansorcontroller.text.isEmpty ||
                              karcontroller.text.isEmpty)
                            _showDialog("Boş bırakılamaz",
                                "Lütfen tüm alanları doldurun");
                          else {
                            bool sonuc = await _database.fiyatKaydet(
                                curItemSehir,
                                oda,
                                toplamFiya.toString(),
                                isSehirlerArasi,
                                yakitcontroller.text,
                                iscilikcontroller.text,
                                asansorcontroller.text,
                                karcontroller.text,
                                curItemIlce);
                            Navigator.of(context).pop();
                            if (sonuc)
                              _showDialog("Fiyat Ekleme",
                                  "Fiyat Ekleme işlemi başarılı");
                            fle.fiyatListesiDoldur();
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
      ),
    );
  }
}

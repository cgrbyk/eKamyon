import 'package:auto_size_text/auto_size_text.dart';
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
        setState(() {});
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
                await _database.tekliFiyatGuncelle(yakitcontroller.text, iscilikcontroller.text,asansorcontroller.text, karcontroller.text, toplamFiya.toString(), f.varisIl, f.evTipi);
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

  fiyatListesiDoldur() async {
    fiyatlar = Fiyat.fromArray(await _database.fiyatlariCek());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF96beff),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Fiyat Listesi Güncelle'),
          actions: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Image.asset('images/logoson.png'))
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: ListView.builder(
                itemCount: fiyatlar.length,
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
                                        color: Colors.grey[600], fontSize: 12)),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("Ev Tipi",
                                  style: TextStyle(
                                      color: Colors.grey[1000], fontSize: 14)),
                              Text(fiyatlar[index].evTipi,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Fiyat",
                                  style: TextStyle(
                                      color: Colors.grey[1000], fontSize: 14)),
                              Text(fiyatlar[index].tasimaUcretiTam,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              child: Text("Fiyat Güncelle"),
                              onPressed: () {
                                _showDialogTekliFiyat(fiyatlar[index]);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: RaisedButton(
                                child: Text("Sil"),
                                onPressed: () {
                                  _showDialogSilme(fiyatlar[index]);
                                },
                              ),
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
                            );
                          });
                      setState(() {});
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
                          );
                        });
                    setState(() {});
                    //toplu fiyat Güncelle
                  },
                ),
              ],
            )
          ],
        ));
  }
}

class TopluFiyatGuncelle extends StatefulWidget {
  final FiyatListeEkrani fle;
  TopluFiyatGuncelle({this.fle});
  @override
  _TopluFiyatGuncelleState createState() => _TopluFiyatGuncelleState(fle: fle);
}

class _TopluFiyatGuncelleState extends State<TopluFiyatGuncelle> {
  final FiyatListeEkrani fle;
  _TopluFiyatGuncelleState({this.fle});
  TextEditingController toplucontroller = TextEditingController();
  bool sehirlerarasimi = true;
  Database _database = Database();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Toplu Fiyat Güncelle"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AutoSizeText("Şehirler arası mı?"),
                Checkbox(
                  value: sehirlerarasimi,
                  onChanged: (bool value) {
                    sehirlerarasimi = value;
                    setState(() {});
                  },
                )
              ],
            ),
            TextField(
              controller: toplucontroller,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Fiyat",
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
          ],
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
                "0", toplucontroller.text, sehirlerarasimi);
            Navigator.of(context).pop();
            await fle.fiyatListesiDoldur();
          },
        ),
        new FlatButton(
          child: new Text("AZALT"),
          onPressed: () async {
            await _database.topluFiyatGuncelle(
                "1", toplucontroller.text, sehirlerarasimi);
            Navigator.of(context).pop();
            await fle.fiyatListesiDoldur();
          },
        ),
      ],
    );
  }
}

class FiyatDialog extends StatefulWidget {
  final FiyatListeEkrani fle;
  FiyatDialog({this.fle});
  FiyatDialogPopup createState() => FiyatDialogPopup(fle: fle);
}

class FiyatDialogPopup extends State<FiyatDialog> {
  final FiyatListeEkrani fle;
  FiyatDialogPopup({this.fle});
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
  List<DropdownMenuItem> sehirlerDDM = List<DropdownMenuItem>();
  String curItemSehir;
  bool aracaktifmi = false;

  List<String> evTipleri = ['1+1', '1+2', '1+3', '1+4'];
  List<DropdownMenuItem> evTipleriDDM = List<DropdownMenuItem>();
  String curItemEv;

  Database _database = Database();
  bool isSehirlerArasi = true;

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
        setState(() {});
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
    super.initState();
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
                Row(
                  children: <Widget>[
                    Text("Şehirler Arası"),
                    Checkbox(
                      value: isSehirlerArasi,
                      onChanged: (bool value) {
                        isSehirlerArasi = value;
                        setState(() {});
                      },
                    )
                  ],
                ),
                Visibility(
                  visible: isSehirlerArasi,
                  child: DropdownButton(
                    isExpanded: true,
                    items: sehirlerDDM,
                    value: curItemSehir,
                    onChanged: (dynamic dmi) {
                      curItemSehir = dmi;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                  visible: !isSehirlerArasi,
                  child: customTextBox(
                      TextInputType.text,
                      "İlçe Adı",
                      ilcecontroller,
                      TextInputAction.done,
                      null,
                      new FocusNode(),
                      false),
                ),
                DropdownButton(
                  items: evTipleriDDM,
                  value: curItemEv,
                  isExpanded: true,
                  onChanged: (dynamic dmi) {
                    curItemEv = dmi;
                    setState(() {});
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
                                ilcecontroller.text);
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

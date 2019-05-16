import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ekamyon/Modeller/aktifKullaniciBilgileri.dart';
import 'package:ekamyon/database.dart';
import 'package:ekamyon/Modeller/Fiyat.dart';
import 'package:flutter/semantics.dart';

class FiyatListe extends StatefulWidget {
  @override
  FiyatListeEkrani createState() => FiyatListeEkrani();
}

class FiyatListeEkrani extends State<FiyatListe> {
  Database _database = Database();
  List<Fiyat> fiyatlar = new List<Fiyat>();
  TextEditingController toplucontroller = TextEditingController();
  TextEditingController teklicontroller = TextEditingController();

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
          content: TextField(
            controller: teklicontroller,
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
              onPressed: () async{
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Güncelle"),
              onPressed: () async{
                await _database.tekliFiyatGuncelle(teklicontroller.text, f.varisIl, f.evTipi);
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
                await _database.fiyatsil(f.varisIl, f.evTipi, f.tasimaUcretiTam);
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

  void _showDialogTopluFiyat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
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
                await _database.topluFiyatGuncelle("0", toplucontroller.text);
                Navigator.of(context).pop();
                await fiyatListesiDoldur();                
              },
            ),
            new FlatButton(
              child: new Text("AZALT"),
              onPressed: () async {
                await _database.topluFiyatGuncelle("1", toplucontroller.text);
                Navigator.of(context).pop();
                await fiyatListesiDoldur();              
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
                              onPressed: ()  {
                                 _showDialogTekliFiyat(fiyatlar[index]);                              
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: RaisedButton(
                              child: Text("Sil"),
                              onPressed: () {
                                _showDialogSilme(fiyatlar[index]);
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
                            return FiyatDialog(fle: this,);
                          });
                      setState(() {});
                    }),
                RaisedButton(
                  child: Text("Toplu Fiyat Güncelle"),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  onPressed: () {
                    _showDialogTopluFiyat();
                    //toplu fiyat Güncelle
                  },
                ),
              ],
            )
          ],
        ));
  }
}

class FiyatDialog extends StatefulWidget {
  final FiyatListeEkrani fle;
  FiyatDialog({this.fle});
  FiyatDialogPopup createState() => FiyatDialogPopup(fle:fle);
}

class FiyatDialogPopup extends State<FiyatDialog> {
  final FiyatListeEkrani fle;
  FiyatDialogPopup({this.fle});
  TextEditingController fiyatcontroller = TextEditingController();

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

  List<String> evTipleri = ['1+0', '1+1', '1+2', '1+3', '1+4'];
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
        FocusScope.of(context).requestFocus(tofocus);
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        child: AlertDialog(
          title: new Text("Yeni Rota ve Fiyat Ekle"),
          content: Column(
            children: <Widget>[
              DropdownButton(
                isExpanded: true,
                items: sehirlerDDM,
                value: curItemSehir,
                onChanged: (dynamic dmi) {
                  curItemSehir = dmi;
                  setState(() {});
                },
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
              customTextBox(TextInputType.number, "Fiyat", fiyatcontroller,
                  TextInputAction.done, null, null, false),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: new Text("İptal"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            new FlatButton(
              child: new Text("Fiyatı Kaydet"),
              onPressed: () async {
                //database den kaydfet
                String oda =
                    curItemEv.replaceAll('+', '.').split('').reversed.join();
                bool sonuc = await _database.fiyatKaydet(
                    curItemSehir, oda, fiyatcontroller.text);
                Navigator.of(context).pop();
                if (sonuc)
                  _showDialog("Fiyat Ekleme", "Fiyat Ekleme işlemi başarılı");
                fle.fiyatListesiDoldur();
              },
            ),
          ],
        ),
      ),
    );
  }
}

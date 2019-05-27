import 'package:ekamyon/Modeller/EkFiyatlar.dart';
import 'package:ekamyon/Modeller/Ilce.dart';
import 'package:ekamyon/Modeller/teklifFirma.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OfisTasimaEkrani extends StatefulWidget {
  @override
  _OfisTasimaEkraniState createState() => _OfisTasimaEkraniState();
}

class _OfisTasimaEkraniState extends State<OfisTasimaEkrani> {
  bool showSigorta = false;
  bool sigorta = true;
  int sigortaHeight = 0;
  Database _database = Database();
  DateTime secilenTarih = DateTime.now();
  String ofisOdaSayisi = "1+1";
  TextEditingController ofisMevcutKat = TextEditingController();
  TextEditingController ofisGelecekKat = TextEditingController();
  TextEditingController binayaYakinlik = TextEditingController();

  TextEditingController mevcutAdres = TextEditingController();
  TextEditingController yeniAdres = TextEditingController();

  FocusNode ofisMevcutKatNode = FocusNode();
  FocusNode ofisGelecekKatNode = FocusNode();

  String esyaPaketSecim = " Bütün eşyalar nakliyeciler tarafından paketlensin";
  String esyaTasimaSecim = " Bina merdiveni kullanılacak";

  bool ortaklik = true;

  List<DropdownMenuItem> mevcutilcelerDDM = List<DropdownMenuItem>();
  List<DropdownMenuItem> varisilcelerDDM = List<DropdownMenuItem>();
  List<Ilce> mevcutIlceler = List<Ilce>();
  List<Ilce> varisIlceler = List<Ilce>();
  String curItemIlcemevcut;
  String curItemIlcevaris;
  EkFiyatlar _ekfiyat;
  int sigortaFiyati = 0;

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
  String newItemSehir;

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

  void _showDetay(TeklifFirma firma) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text(firma.firmaUnvan)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Firma İli :", style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaIl),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma İlçe :", style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaIlce),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Adres :", style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaAdresi),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Cep NO :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.cepTel),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Sabit Tel :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.sabitTel),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Faaliyet süresi :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaKacYildirFaaliyette),
                  ],
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
          ],
        );
      },
    );
  }

  _showTeklifListe(List<TeklifFirma> gelenTeklifler) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text("Uygun Teklifler")),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              itemCount: gelenTeklifler.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            gelenTeklifler[index].firmaUnvan,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Teklif Fiyatı",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ucretHesapla(gelenTeklifler[index]
                                            .tasimaUcretiTam)
                                        .toString() +
                                    " ₺",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.lightGreen),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "Detay",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              _showDetay(gelenTeklifler[index]);
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Seç",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () async {
                              if (mevcutAdres.text.isNotEmpty &&
                                  ofisOdaSayisi.isNotEmpty &&
                                  ofisMevcutKat.text.isNotEmpty &&
                                  binayaYakinlik.text.isNotEmpty &&
                                  yeniAdres.text.isNotEmpty &&
                                  ofisGelecekKat.text.isNotEmpty) {
                                bool sonuc =
                                    await _database.ofisTasimaTeklifKabul(
                                        ofisOdaSayisi,
                                        secilenTarih,
                                        curItemSehir,
                                        curItemIlcemevcut,
                                        mevcutAdres.text,
                                        ofisMevcutKat.text,
                                        binayaYakinlik.text,
                                        esyaTasimaSecim,
                                        esyaPaketSecim,
                                        newItemSehir,
                                        curItemIlcevaris,
                                        yeniAdres.text,
                                        ofisGelecekKat.text,
                                        sigorta,
                                        ortaklik,
                                        gelenTeklifler[index].firmaID,
                                        ucretHesapla(gelenTeklifler[index]
                                                .tasimaUcretiTam)
                                            .toString());
                                sonuc
                                    ? _showDialog("Başarılı",
                                        "Talebiniz firmaya iletilmiştir. Firma sizinle en kısa zamanda iletişime geçecektir.")
                                    : _showDialog("Hata",
                                        "Talep oluştururken bir hata meydana geldi");
                              } else {
                                _showDialog("Boş alan",
                                    "Lütfen adres bilgileri gibi önemli alanları boş bırakmayınız.");
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Vazgeç"),
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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: TextField(
        obscureText: password,
        focusNode: ownFocus,
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
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (String sehir in sehirler) {
      sehirlerDDM.add(new DropdownMenuItem(
        value: sehir,
        child: new Text(sehir),
      ));
    }
    curItemSehir = sehirler.first;
    newItemSehir = sehirler.first;
    ilceGetirMevcut(curItemSehir);
    ilceGetirVaris(newItemSehir);
    sigortaFiyatiAl();
    ekFiyatGetir();
  }

  ekFiyatGetir() async {
    _ekfiyat = await _database.ekFiyatlariCek();
  }

  sigortaFiyatiAl() async {
    var json = await _database.sigortaFiyatiAl();
    sigortaFiyati = int.parse(json[0]['Value'].toString());
  }

  ilceGetirMevcut(String aranansehir) async {
    mevcutIlceler.clear();
    mevcutilcelerDDM.clear();
    mevcutIlceler =
        Ilce.fromArray(await _database.ilceBilgileriCek(aranansehir));
    for (Ilce ilce in mevcutIlceler) {
      mevcutilcelerDDM.add(new DropdownMenuItem(
        value: ilce.ilceAdi,
        child: new Text(ilce.ilceAdi),
      ));
    }
    curItemIlcemevcut = mevcutIlceler.first.ilceAdi;
    if (this.mounted) {
      setState(() {});
    }
  }

  ilceGetirVaris(String arananSehir) async {
    varisIlceler.clear();
    varisilcelerDDM.clear();
    varisIlceler =
        Ilce.fromArray(await _database.ilceBilgileriCek(arananSehir));
    for (Ilce ilce in varisIlceler) {
      varisilcelerDDM.add(new DropdownMenuItem(
        value: ilce.ilceAdi,
        child: new Text(ilce.ilceAdi),
      ));
    }
    curItemIlcevaris = varisIlceler.first.ilceAdi;
    if (this.mounted) {
      setState(() {});
    }
  }

  ucretHesapla(String tamUCret) {
    double tam = double.parse(tamUCret);
    tam = tam + ((tam / 100) * 5); //komisyon
    tam += sigorta ? sigortaFiyati : 0; //sigorta ekleme
    tam += int.tryParse((mevcutIlceler
            .singleWhere((ilce) => ilce.ilceAdi == curItemIlcemevcut)
            .merkezeuzaklik) ??
        0); //mevcut ilçe ek fiyat
    tam += int.tryParse((varisIlceler
            .singleWhere((ilce) => ilce.ilceAdi == curItemIlcevaris)
            .merkezeuzaklik) ??
        0); //variş ilçe ek fiyat
    return tam.round();
  }

  ekFiyatHesapla(int uzaklik) {
    if (uzaklik >= 0 && uzaklik <= 30)
      return _ekfiyat.var1;
    else if (uzaklik > 30 && uzaklik <= 50)
      return _ekfiyat.var2;
    else if (uzaklik > 50 && uzaklik <= 120)
      return _ekfiyat.var3;
    else if (uzaklik > 120) return _ekfiyat.var4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ofis Taşıma'),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Ofis taşımacılığı için",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Birkaç sorum olucak",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(" Taşınacağınız tarih :"),
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime:
                                        DateTime.now().add(Duration(days: 365)),
                                    onConfirm: (date) {
                                  print('confirm $date');
                                  secilenTarih = date;
                                  if (this.mounted) {
                                    setState(() {});
                                  }
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.tr);
                              },
                              child: Text(
                                'Tarih Seç ' +
                                    secilenTarih.day.toString() +
                                    ":" +
                                    secilenTarih.month.toString() +
                                    ":" +
                                    secilenTarih.year.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Ofisinizin oda sayisi :"),
                            Expanded(
                              child: DropdownButton(
                                value: ofisOdaSayisi,
                                items: [
                                  DropdownMenuItem(
                                    value: "1+1",
                                    child: Center(child: Text("1+1")),
                                  ),
                                  DropdownMenuItem(
                                    value: "2+1",
                                    child: Center(child: Text("2+1")),
                                  ),
                                  DropdownMenuItem(
                                    value: "3+1",
                                    child: Center(child: Text("3+1")),
                                  ),
                                  DropdownMenuItem(
                                    value: "4+1",
                                    child: Center(child: Text("4+1")),
                                  ),
                                ],
                                onChanged: (String s) {
                                  ofisOdaSayisi = s;
                                  if (this.mounted) {
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      customTextBox(
                          TextInputType.number,
                          "Ofisinizin şuan bulunduğu kat",
                          ofisMevcutKat,
                          TextInputAction.next,
                          null,
                          ofisGelecekKatNode,
                          false),
                      customTextBox(
                          TextInputType.number,
                          "Yeni ofinizin katı",
                          ofisGelecekKat,
                          TextInputAction.next,
                          null,
                          new FocusNode(),
                          false),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Eşyaların paketlemesi kim tarafıdan yapılsın ?",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButton(
                      isExpanded: true,
                      value: esyaPaketSecim,
                      items: [
                        DropdownMenuItem(
                          value:
                              ' Bütün eşyalar nakliyeciler tarafından paketlensin',
                          child: Text(
                            " Bütün eşyalar nakliyeciler tarafından paketlensin",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              ' Sadece kendi eşyalarımı kendim paketleyeceğim',
                          child: Text(
                            " Sadece kendi eşyalarımı kendim paketleyeceğim",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              ' sadece mutfak eşyalarımı kendim paketleyeceğim',
                          child: Text(
                            " sadece mutfak eşyalarımı kendim paketleyeceğim",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value: ' Bütün eşyalarımı kendim paketleyeceğim',
                          child: Text(
                            " Bütün eşyalarımı kendim paketleyeceğim",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                      onChanged: (String s) {
                        esyaPaketSecim = s;
                        if (this.mounted) {
                          setState(() {});
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Eşyalar yeni binaya nasıl taşınacak ?",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButton(
                      isExpanded: true,
                      value: esyaTasimaSecim,
                      items: [
                        DropdownMenuItem(
                          value: ' Bina merdiveni kullanılacak',
                          child: Text(
                            " Bina merdiveni kullanılacak",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value: ' Bina asansörü kullanılacak',
                          child: Text(
                            " Bina asansörü kullanılacak",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value: ' Bina dışına asansör kurulacak',
                          child: Text(
                            " Bina dışına asansör kurulacak",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                      onChanged: (String s) {
                        esyaTasimaSecim = s;
                        if (this.mounted) {
                          setState(() {});
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customTextBox(
                          TextInputType.number,
                          "Nakliye aracı binaya ne kadar yaklaşabilir ? (Metre)",
                          binayaYakinlik,
                          TextInputAction.done,
                          null,
                          new FocusNode(),
                          false),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              " Mevcut Ev adresiniz ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800]),
                            )),
                      ),
                      Row(
                        children: <Widget>[
                          DropdownButton(
                            items: sehirlerDDM,
                            value: curItemSehir,
                            onChanged: (dynamic dmi) {
                              curItemSehir = dmi;
                              newItemSehir == curItemSehir
                                  ? showSigorta = false
                                  : showSigorta = true;
                              ilceGetirMevcut(curItemSehir);
                              if (this.mounted) {
                                setState(() {});
                              }
                            },
                          ),
                          Expanded(
                              child: DropdownButton(
                            isExpanded: true,
                            items: mevcutilcelerDDM,
                            value: curItemIlcemevcut,
                            onChanged: (dynamic dmi) {
                              curItemIlcemevcut = dmi;
                              if (this.mounted) {
                                setState(() {});
                              }
                            },
                          )),
                        ],
                      ),
                      customTextBox(
                          TextInputType.text,
                          "Mahalle/Cadde/Sokak/DaireNo/KapıNo",
                          mevcutAdres,
                          TextInputAction.done,
                          null,
                          new FocusNode(),
                          false),
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              " Yeni Ev adresiniz ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800]),
                            )),
                      ),
                      Row(
                        children: <Widget>[
                          DropdownButton(
                            items: sehirlerDDM,
                            value: newItemSehir,
                            onChanged: (dynamic dmi) {
                              newItemSehir = dmi;
                              newItemSehir == curItemSehir
                                  ? showSigorta = false
                                  : showSigorta = true;
                              ilceGetirVaris(newItemSehir);
                              if (this.mounted) {
                                setState(() {});
                              }
                            },
                          ),
                          Expanded(
                              child: DropdownButton(
                            isExpanded: true,
                            items: varisilcelerDDM,
                            value: curItemIlcevaris,
                            onChanged: (dynamic dmi) {
                              curItemIlcevaris = dmi;
                              if (this.mounted) {
                                setState(() {});
                              }
                            },
                          )),
                        ],
                      ),
                      customTextBox(
                          TextInputType.text,
                          "Mahalle/Cadde/Sokak/DaireNo/KapıNo",
                          yeniAdres,
                          TextInputAction.done,
                          null,
                          new FocusNode(),
                          false),
                      Visibility(
                        visible: showSigorta,
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              "Eşyalarınız için sigorta istermisiniz ?",
                              style: TextStyle(color: Colors.blue[900]),
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: CheckboxListTile(
                                      value: sigorta,
                                      title: Text("Evet"),
                                      onChanged: (bool s) {
                                        sigorta = true;
                                        if (this.mounted) {
                                          setState(() {});
                                        }
                                      }),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                      value: !sigorta,
                                      title: AutoSizeText("İstemiyorum",
                                          maxLines: 1),
                                      onChanged: (bool s) {
                                        sigorta = false;
                                        if (this.mounted) {
                                          setState(() {});
                                        }
                                      }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          "Yükünüzün başka yükler ile beraber taşınmasını ister misiniz ?",
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Yükünüzü taşıyacak olan araç eğer sizin eşyalarınızla tamamen dolmazsa başka bir müşterinin eşyaları da araca yüklüyoruz ve beraber taşıyoruz böylece sizin için maliyet yüzde 20'ye varan oranda düşebiliyor bu özellikten faydalanmak istiyorsanız evet seçeneğini seçiniz.",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 11),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: CheckboxListTile(
                                value: ortaklik,
                                title: Text("Evet"),
                                onChanged: (bool s) {
                                  ortaklik = true;
                                  if (this.mounted) {
                                    setState(() {});
                                  }
                                }),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                                value: !ortaklik,
                                title: AutoSizeText(
                                  "İstemiyorum",
                                  maxLines: 1,
                                ),
                                onChanged: (bool s) {
                                  ortaklik = false;
                                  if (this.mounted) {
                                    setState(() {});
                                  }
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
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
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text("Tamamla",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    onPressed: () async {
                      List<TeklifFirma> gelenTeklifler =
                          await _database.evdenEveTasimaTeklifleriAl(
                              secilenTarih,
                              curItemSehir,
                              newItemSehir,
                              ofisOdaSayisi);
                      if (gelenTeklifler != null) {
                        _showTeklifListe(gelenTeklifler);
                      } else {
                        _showDialog("Uygun teklif bulunamadı",
                            "Şuan sizin için uygun bir araç bulamadık en kısa sürede bu eksiği gidereceğiz.");
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

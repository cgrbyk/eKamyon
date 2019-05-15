import 'package:ekamyon/Modeller/teklifFirma.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EvdenEveTasima extends StatefulWidget {
  @override
  _EvdenEveTasimaState createState() => _EvdenEveTasimaState();
}

class _EvdenEveTasimaState extends State<EvdenEveTasima> {
  Database _database = Database();
  PageController _pageController = PageController();
  DateTime secilenTarih = DateTime.now();
  String ofisOdaSayisi = "1+1";
  TextEditingController ofisMevcutKat = TextEditingController();
  TextEditingController ofisGelecekKat = TextEditingController();
  TextEditingController binayaYakinlik = TextEditingController();

  TextEditingController mevcutIlce = TextEditingController();
  TextEditingController mevcutAdres = TextEditingController();
  TextEditingController yeniIlce = TextEditingController();
  TextEditingController yeniAdres = TextEditingController();

  FocusNode ofisOdaSayisiNode = FocusNode();
  FocusNode ofisMevcutKatNode = FocusNode();
  FocusNode ofisGelecekKatNode = FocusNode();

  String esyaPaketSecim = " Bütün eşyalar nakliyeciler tarafından paketlensin";
  String esyaTasimaSecim = " Bina merdiveni kullanılacak";

  bool ortaklik = true;
  bool showSigorta = false;
  bool sigorta = true;

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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          gelenTeklifler[index].firmaUnvan,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          gelenTeklifler[index].firmaIl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        "Detay",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        _showDetay(gelenTeklifler[index]);
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Teklif Fiyatı",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          gelenTeklifler[index].tasimaUcretiTam,
                          style:
                              TextStyle(fontSize: 18, color: Colors.lightGreen),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        "Seç",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () async {
                        //indexdeki teklif seçilecek
                      },
                    ),
                  ],
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

  Widget customTextBox2(
      TextInputType type,
      String placeholder,
      TextEditingController controller,
      TextInputAction action,
      FocusNode ownFocus,
      FocusNode tofocus,
      bool password) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
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

  TextEditingController ucluKoltuk = TextEditingController();
  FocusNode ucluKoltukNode = FocusNode();
  TextEditingController ikiliKoltuk = TextEditingController();
  FocusNode ikiliKoltukNode = FocusNode();
  TextEditingController tekliKoltuk = TextEditingController();
  FocusNode tekliKoltukNode = FocusNode();
  TextEditingController tvSehba = TextEditingController();
  FocusNode tvSehbaNode = FocusNode();
  TextEditingController ortaSehba = TextEditingController();
  FocusNode ortaSehbaNode = FocusNode();
  TextEditingController televizyon = TextEditingController();
  FocusNode televizyonNode = FocusNode();
  TextEditingController zigonSehba = TextEditingController();
  FocusNode zigonSehbaNode = FocusNode();
  TextEditingController portre = TextEditingController();
  FocusNode portreNode = FocusNode();
  TextEditingController kitaplik = TextEditingController();
  FocusNode kitaplikNode = FocusNode();
  TextEditingController yemekMasasi = TextEditingController();
  FocusNode yemekMasasiNode = FocusNode();
  TextEditingController sandalye = TextEditingController();
  FocusNode sandalyeNode = FocusNode();
  TextEditingController gumusluk = TextEditingController();
  FocusNode gumuslukNode = FocusNode();
  TextEditingController avize = TextEditingController();
  FocusNode avizeNode = FocusNode();
  TextEditingController altiKapiGardrop = TextEditingController();
  FocusNode altiKapiGardropNode = FocusNode();
  TextEditingController ikiliYatak = TextEditingController();
  FocusNode ikiliYatakNode = FocusNode();
  TextEditingController sifonyer = TextEditingController();
  FocusNode sifonyerNode = FocusNode();
  TextEditingController komidin = TextEditingController();
  FocusNode komidinNode = FocusNode();
  TextEditingController tuvaletAyna = TextEditingController();
  FocusNode tuvaletAynaNode = FocusNode();
  TextEditingController abajur = TextEditingController();
  FocusNode abajurNode = FocusNode();
  TextEditingController ucKapiliGardrop = TextEditingController();
  FocusNode ucKapiliGardropNode = FocusNode();
  TextEditingController tekKisilikYatak = TextEditingController();
  FocusNode tekKisilikYatakNode = FocusNode();
  TextEditingController bilgisayarMasasi = TextEditingController();
  FocusNode bilgisayarMasasiNode = FocusNode();
  TextEditingController bilgisayar = TextEditingController();
  FocusNode bilgisayarNode = FocusNode();
  TextEditingController sandalyeGenc = TextEditingController();
  FocusNode sandalyeGencNode = FocusNode();
  TextEditingController camasirMakinasi = TextEditingController();
  FocusNode camasirMakinasiNode = FocusNode();
  TextEditingController sofBen = TextEditingController();
  FocusNode sofBenNode = FocusNode();
  TextEditingController camasirSepet = TextEditingController();
  FocusNode camasirSepetNode = FocusNode();
  TextEditingController buzdolabi = TextEditingController();
  FocusNode buzdolabiNode = FocusNode();
  TextEditingController bulasikMakinesi = TextEditingController();
  FocusNode bulasikMakinesiNode = FocusNode();
  TextEditingController firin = TextEditingController();
  FocusNode firinNode = FocusNode();
  TextEditingController mikroFirin = TextEditingController();
  FocusNode mikroFirinNode = FocusNode();
  TextEditingController setOcak = TextEditingController();
  FocusNode setOcakNode = FocusNode();
  TextEditingController mutfakMasasi = TextEditingController();
  FocusNode mutfakMasasiNode = FocusNode();
  TextEditingController mutfakSandalye = TextEditingController();
  FocusNode mutfakSandalyeNode = FocusNode();
  TextEditingController derinDondurucu = TextEditingController();
  FocusNode derinDondurucuNode = FocusNode();
  TextEditingController kosuBandi = TextEditingController();
  FocusNode kosuBandiNode = FocusNode();
  TextEditingController bisiklet = TextEditingController();
  FocusNode bisikletNode = FocusNode();
  TextEditingController bilgisayarMasasiDiger = TextEditingController();
  FocusNode bilgisayarMasasiDigerNode = FocusNode();
  TextEditingController mBilgisayar = TextEditingController();
  FocusNode mBilgisayarNode = FocusNode();
  TextEditingController utuMasasi = TextEditingController();
  FocusNode utuMasasiNode = FocusNode();
  TextEditingController klima = TextEditingController();
  FocusNode klimaNode = FocusNode();
  TextEditingController portManto = TextEditingController();
  FocusNode portMantoNode = FocusNode();
  TextEditingController elektrikliSupurge = TextEditingController();
  FocusNode elektrikliSupurgeNode = FocusNode();
  TextEditingController resim = TextEditingController();
  FocusNode resimNode = FocusNode();
  TextEditingController canliCicek = TextEditingController();
  FocusNode canliCicekNode = FocusNode();
  TextEditingController hali = TextEditingController();
  FocusNode haliNode = FocusNode();
  TextEditingController koli = TextEditingController();
  FocusNode koliNode = FocusNode();
  TextEditingController hurc = TextEditingController();
  FocusNode hurcNode = FocusNode();

  int esyaSayisiHesaplama() {
    int toplamEsyaSayisi = 0;
    toplamEsyaSayisi += int.tryParse(ucluKoltuk.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(ikiliKoltuk.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(tekliKoltuk.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(tvSehba.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(ortaSehba.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(televizyon.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(zigonSehba.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(portre.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(kitaplik.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(yemekMasasi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(sandalye.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(gumusluk.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(avize.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(altiKapiGardrop.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(ikiliYatak.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(sifonyer.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(komidin.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(tuvaletAyna.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(abajur.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(ucKapiliGardrop.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(tekKisilikYatak.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(bilgisayarMasasi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(bilgisayar.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(sandalyeGenc.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(camasirMakinasi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(sofBen.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(camasirSepet.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(buzdolabi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(bulasikMakinesi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(firin.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(mikroFirin.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(setOcak.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(mutfakMasasi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(mutfakSandalye.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(derinDondurucu.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(kosuBandi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(bisiklet.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(bilgisayarMasasiDiger.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(mBilgisayar.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(utuMasasi.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(klima.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(portManto.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(elektrikliSupurge.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(resim.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(canliCicek.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(hali.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(koli.text) ?? 0;
    toplamEsyaSayisi += int.tryParse(hurc.text) ?? 0;
    return toplamEsyaSayisi;
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
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: Text('Evden Eve Taşıma'),
            actions: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Image.asset('images/logoson.png'))
            ],
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    "Evden eve taşıma için",
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
                                      maxTime: DateTime.now()
                                          .add(Duration(days: 365)),
                                      onConfirm: (date) {
                                    print('confirm $date');
                                    secilenTarih = date;
                                    setState(() {});
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
                            Text("Evinizin oda sayisi :"),
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
                                  setState(() {});
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
                            ofisMevcutKatNode,
                            ofisGelecekKatNode,
                            false),
                        customTextBox(
                            TextInputType.number,
                            "Yeni ofinizin katı",
                            ofisGelecekKat,
                            TextInputAction.next,
                            ofisGelecekKatNode,
                            new FocusNode(),
                            false),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Eşyaların paketlemesi kim tarafıdan yapılsın ?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
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
                            setState(() {});
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Eşyalar yeni binaya nasıl taşınacak ?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
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
                            setState(() {});
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
                        Center(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Colors.blue,
                            child: Text(
                              "Devam",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            },
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: Text('Evden Eve Taşıma'),
            actions: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Image.asset('images/logoson.png'))
            ],
          ),
          body: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                      child: Text(
                    "Eşya listesi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Oturma Odası",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          customTextBox2(
                              TextInputType.number,
                              "Üçlü koltuk",
                              ucluKoltuk,
                              TextInputAction.next,
                              ucluKoltukNode,
                              ikiliKoltukNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "İkili koltuk",
                              ikiliKoltuk,
                              TextInputAction.next,
                              ikiliKoltukNode,
                              tekliKoltukNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Tekli koltuk",
                              tekliKoltuk,
                              TextInputAction.next,
                              tekliKoltukNode,
                              tvSehbaNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Tv Sehbası",
                              tvSehba,
                              TextInputAction.next,
                              tvSehbaNode,
                              ortaSehbaNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Orta Sehbası",
                              ortaSehba,
                              TextInputAction.next,
                              ortaSehbaNode,
                              televizyonNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Televizyon",
                              televizyon,
                              TextInputAction.next,
                              televizyonNode,
                              zigonSehbaNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Zigon sehba",
                              zigonSehba,
                              TextInputAction.next,
                              zigonSehbaNode,
                              kitaplikNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Kitaplık",
                              kitaplik,
                              TextInputAction.done,
                              kitaplikNode,
                              new FocusNode(),
                              false),
                          Text("data", style: TextStyle(color: Colors.white)),
                          Text("data", style: TextStyle(color: Colors.white)),
                          RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              "Devam",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            },
                          ),
                          Text("data",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Misafir Odası",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          customTextBox2(
                              TextInputType.number,
                              "Yemak Masası",
                              yemekMasasi,
                              TextInputAction.next,
                              yemekMasasiNode,
                              sandalyeNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Sandalye",
                              sandalye,
                              TextInputAction.next,
                              sandalyeNode,
                              gumuslukNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Gümüşlük",
                              gumusluk,
                              TextInputAction.next,
                              gumuslukNode,
                              avizeNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Avize",
                              avize,
                              TextInputAction.next,
                              avizeNode,
                              altiKapiGardropNode,
                              false),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Text(
                                "Yatak Odası",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          customTextBox2(
                              TextInputType.number,
                              "6 Kapılı Gardrop",
                              altiKapiGardrop,
                              TextInputAction.next,
                              altiKapiGardropNode,
                              ikiliYatakNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Çift Kişilik Yatak",
                              ikiliYatak,
                              TextInputAction.next,
                              ikiliYatakNode,
                              sifonyerNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Şifonyer",
                              sifonyer,
                              TextInputAction.next,
                              sifonyerNode,
                              komidinNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Komidin",
                              komidin,
                              TextInputAction.done,
                              komidinNode,
                              tuvaletAynaNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Tuvalet Aynası",
                              tuvaletAyna,
                              TextInputAction.next,
                              tuvaletAynaNode,
                              abajurNode,
                              false),
                          customTextBox2(
                              TextInputType.number,
                              "Abajur",
                              abajur,
                              TextInputAction.next,
                              abajurNode,
                              new FocusNode(),
                              false),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: Text('Evden Eve Taşıma'),
            actions: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Image.asset('images/logoson.png'))
            ],
          ),
          body: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: ListView(
              children: <Widget>[
                Center(
                    child: Text(
                  "Eşya Listesi",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                          "Genç Odası",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                        customTextBox2(
                            TextInputType.number,
                            "3 Kapılı gardrop",
                            ucKapiliGardrop,
                            TextInputAction.next,
                            ucKapiliGardropNode,
                            tekKisilikYatakNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Tek kişilik yatak",
                            tekKisilikYatak,
                            TextInputAction.next,
                            tekKisilikYatakNode,
                            bilgisayarMasasiNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Bilgisayar masası",
                            bilgisayarMasasi,
                            TextInputAction.next,
                            bilgisayarMasasiNode,
                            bilgisayarNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Bilgisayar",
                            bilgisayar,
                            TextInputAction.next,
                            bilgisayarNode,
                            sandalyeGencNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Sandalye",
                            sandalyeGenc,
                            TextInputAction.next,
                            sandalyeGencNode,
                            new FocusNode(),
                            false),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Banyo",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )),
                        customTextBox2(
                            TextInputType.number,
                            "Çamaşır makinası",
                            camasirMakinasi,
                            TextInputAction.next,
                            camasirMakinasiNode,
                            sofBenNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Şofben",
                            sofBen,
                            TextInputAction.next,
                            sofBenNode,
                            camasirSepetNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Çamaşır sepeti",
                            camasirSepet,
                            TextInputAction.next,
                            camasirSepetNode,
                            new FocusNode(),
                            false),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                            child: Text(
                          "Mutfak",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                        customTextBox2(
                            TextInputType.number,
                            "Buzdolabı",
                            buzdolabi,
                            TextInputAction.next,
                            buzdolabiNode,
                            bulasikMakinesiNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Bulaşık makinesi",
                            bulasikMakinesi,
                            TextInputAction.next,
                            bulasikMakinesiNode,
                            firinNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Fırın",
                            firin,
                            TextInputAction.next,
                            firinNode,
                            mikroFirinNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Mikrodalga fırın",
                            mikroFirin,
                            TextInputAction.next,
                            mikroFirinNode,
                            setOcakNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Set üstü ocak",
                            setOcak,
                            TextInputAction.next,
                            setOcakNode,
                            mutfakMasasiNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Yemek Masasi",
                            mutfakMasasi,
                            TextInputAction.next,
                            mutfakMasasiNode,
                            mutfakSandalyeNode,
                            false),
                        customTextBox2(
                            TextInputType.number,
                            "Sandalye",
                            mutfakSandalye,
                            TextInputAction.next,
                            mutfakSandalyeNode,
                            new FocusNode(),
                            false),
                        Text("Data", style: TextStyle(color: Colors.white)),
                        Text("Data", style: TextStyle(color: Colors.white)),
                        Text("Data", style: TextStyle(color: Colors.white)),
                        Text("Data", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.1),
                    child: RaisedButton(
                      child: Text(
                        "Devam",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              title: Text('Evden Eve Taşıma'),
              actions: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Image.asset('images/logoson.png'))
              ],
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Center(
                            child: Text(
                          "Eşya Listesi",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  "Diğer Eşyalar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                                customTextBox2(
                                    TextInputType.number,
                                    "Derin dondurucu",
                                    derinDondurucu,
                                    TextInputAction.next,
                                    derinDondurucuNode,
                                    kosuBandiNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Koşu bandı",
                                    kosuBandi,
                                    TextInputAction.next,
                                    kosuBandiNode,
                                    bisikletNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Bisiklet",
                                    bisiklet,
                                    TextInputAction.next,
                                    bisikletNode,
                                    bilgisayarMasasiDigerNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Bilgisayar masası",
                                    bilgisayarMasasiDiger,
                                    TextInputAction.next,
                                    bilgisayarMasasiDigerNode,
                                    mBilgisayarNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Masa üstü bilgisayar",
                                    mBilgisayar,
                                    TextInputAction.next,
                                    mBilgisayarNode,
                                    utuMasasiNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Ütü masasi",
                                    utuMasasi,
                                    TextInputAction.next,
                                    utuMasasiNode,
                                    klimaNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Klima",
                                    klima,
                                    TextInputAction.next,
                                    klimaNode,
                                    new FocusNode(),
                                    false),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  "Diğer Eşyalar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                                customTextBox2(
                                    TextInputType.number,
                                    "Portmanto",
                                    portManto,
                                    TextInputAction.next,
                                    portMantoNode,
                                    elektrikliSupurgeNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Elektrikli süpürge",
                                    elektrikliSupurge,
                                    TextInputAction.next,
                                    elektrikliSupurgeNode,
                                    resimNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Resim",
                                    resim,
                                    TextInputAction.next,
                                    resimNode,
                                    canliCicekNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Canlı çicek",
                                    canliCicek,
                                    TextInputAction.next,
                                    canliCicekNode,
                                    haliNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Halı",
                                    hali,
                                    TextInputAction.next,
                                    haliNode,
                                    koliNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Koli",
                                    koli,
                                    TextInputAction.next,
                                    koliNode,
                                    hurcNode,
                                    false),
                                customTextBox2(
                                    TextInputType.number,
                                    "Hurç",
                                    hurc,
                                    TextInputAction.next,
                                    hurcNode,
                                    new FocusNode(),
                                    false),
                              ],
                            ),
                          ],
                        ),
                        Center(
                            child: Text("data",
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Mevcut ofis adresiniz ?",
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
                                setState(() {});
                              },
                            ),
                            Expanded(
                                child: customTextBox(
                                    TextInputType.text,
                                    "İlçe Adı",
                                    mevcutIlce,
                                    TextInputAction.done,
                                    new FocusNode(),
                                    new FocusNode(),
                                    false)),
                          ],
                        ),
                        customTextBox(
                            TextInputType.text,
                            "Mahalle/Cadde/Sokak/DaireNo/KapıNo",
                            mevcutAdres,
                            TextInputAction.done,
                            new FocusNode(),
                            new FocusNode(),
                            false),
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Yeni ofis adresiniz ?",
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
                                setState(() {});
                              },
                            ),
                            Expanded(
                                child: customTextBox(
                                    TextInputType.text,
                                    "İlçe Adı",
                                    yeniIlce,
                                    TextInputAction.done,
                                    new FocusNode(),
                                    new FocusNode(),
                                    false)),
                          ],
                        ),
                        customTextBox(
                            TextInputType.text,
                            "Mahalle/Cadde/Sokak/DaireNo/KapıNo",
                            yeniAdres,
                            TextInputAction.done,
                            new FocusNode(),
                            new FocusNode(),
                            false),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
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
                                        setState(() {});
                                      }),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                      value: !sigorta,
                                      title: AutoSizeText("İstemiyorum",maxLines: 1),
                                      onChanged: (bool s) {
                                        sigorta = false;
                                        setState(() {});
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: CheckboxListTile(
                                  value: ortaklik,
                                  title: Text("Evet"),
                                  onChanged: (bool s) {
                                    ortaklik = true;
                                    setState(() {});
                                  }),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: CheckboxListTile(
                                  value: !ortaklik,
                                  title: Text("İstemiyorum"),
                                  onChanged: (bool s) {
                                    ortaklik = false;
                                    setState(() {});
                                  }),
                            ),
                          ],
                        )
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
                          int odasayisi = esyaSayisiHesaplama();
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
                          if (odasayisi < 40 && ofisOdaSayisi != "1+1") {
                            _showDialog("Oda sayısı hesaplandı",
                                "Girdiğiniz Eşyalar 1+1 için uygundur.Oda tipi değiştilimiştir.");
                            ofisOdaSayisi = "1+1";
                          } else if (odasayisi > 40 &&
                              odasayisi <= 50 &&
                              ofisOdaSayisi != "2+1") {
                            _showDialog("Oda sayısı hesaplandı",
                                "Girdiğiniz Eşyalar 2+1 için uygundur.Oda tipi değiştilimiştir.");
                            ofisOdaSayisi = "2+1";
                          } else if (odasayisi > 50 &&
                              odasayisi <= 70 &&
                              ofisOdaSayisi != "3+1") {
                            _showDialog("Oda sayısı hesaplandı",
                                "Girdiğiniz Eşyalar 3+1 için uygundur.Oda tipi değiştilimiştir.");
                            ofisOdaSayisi = "3+1";
                          } else if (ofisOdaSayisi == "4+1") {
                            _showDialog("Oda sayısı hesaplandı",
                                "Girdiğiniz Eşyalar 4+1 için uygundur.Oda tipi değiştilimiştir.");
                            ofisOdaSayisi = "4+1";
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}

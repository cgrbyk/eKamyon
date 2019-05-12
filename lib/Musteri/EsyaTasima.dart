import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EsyaTasima extends StatefulWidget {
  @override
  _EsyaTasimaState createState() => _EsyaTasimaState();
}

class _EsyaTasimaState extends State<EsyaTasima> {
  Database _database=Database();
  DateTime secilenTarih = DateTime.now();
  TextEditingController esyaOdaSayisi = TextEditingController();
  TextEditingController esyaMevcutKat = TextEditingController();
  TextEditingController esyaGelecekKat = TextEditingController();
  TextEditingController binayaYakinlik = TextEditingController();

  TextEditingController mevcutIlce = TextEditingController();
  TextEditingController mevcutAdres = TextEditingController();
  TextEditingController yeniIlce = TextEditingController();
  TextEditingController yeniAdres = TextEditingController();

  FocusNode esyaMevcutKatNode = FocusNode();
  FocusNode esyaGelecekKatNode = FocusNode();

  String esyaPaketSecim = " Paketlemeyi ben yapacağım";
  String esyaTasimaSecim = " Bina merdiveni kullanılacak";
  String esyaCinsi = " Sanayi Malzemesi";

  bool ortaklik = true;

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

  Widget customTextBox(
      TextInputType type,
      String placeholder,
      TextEditingController controller,
      TextInputAction action,
      FocusNode tofocus,
      bool password) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: TextField(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esya Taşıma'),
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
                  "esya taşımacılığı için",
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
                  borderRadius: BorderRadius.circular(20)
                ),
                  child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(" Eşya tipi :"),
                      DropdownButton(
                        value: esyaCinsi,
                        items: [
                          DropdownMenuItem(
                            value: ' Sanayi Malzemesi',
                            child: Text('Sanayi Malzemesi'),
                          ),
                          DropdownMenuItem(
                            value: ' İnşaat Malzemesi',
                            child: Text('İnşaat Malzemesi'),
                          ),
                          DropdownMenuItem(
                            value: ' Gıda Malzemesi',
                            child: Text('Gıda Malzemesi'),
                          ),
                          DropdownMenuItem(
                            value: ' Diğer',
                            child: Text('Diğer'),
                          ),
                        ],
                        onChanged: (String s) {
                          esyaCinsi = s;
                          setState(() {});
                        },
                      )
                    ],
                  )
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
                  borderRadius: BorderRadius.circular(20)
                ),
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
                          value: ' Paketlemeyi ben yapacağım',
                          child: Text(
                            " Paketlemeyi ben yapacağım",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DropdownMenuItem(
                          value: ' Paketleme nakliyeciler tarafından yapılacak',
                          child: Text(
                            " Paketleme nakliyeciler tarafından yapılacak",
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
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " Mevcut esya adresiniz ?",
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
                                false)),
                      ],
                    ),
                    customTextBox(
                        TextInputType.text,
                        "Mahalle/Cadde/Sokak/DaireNo/KapıNo",
                        mevcutAdres,
                        TextInputAction.done,
                        new FocusNode(),
                        false),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " Yeni esya adresiniz ?",
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
                                false)),
                      ],
                    ),
                    customTextBox(
                        TextInputType.text,
                        "Mahalle/Cadde/Sokak/DaireNo/KapıNo",
                        yeniAdres,
                        TextInputAction.done,
                        new FocusNode(),
                        false),
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
                        style: TextStyle(color: Colors.blueGrey, fontSize: 11),
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
                    onPressed: () {
                      //kaydeyme vs
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

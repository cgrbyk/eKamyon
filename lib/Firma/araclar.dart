import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/Modeller/aracmusaitlik.dart';
import 'package:flutter/material.dart';
import 'package:ekamyon/database.dart';
import 'package:ekamyon/Modeller/arac.dart';
import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';

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
    if (this.mounted) {           setState(() {});         }
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
                          showDialog(
                              context: context,
                              builder: (_) {
                                return ShowCalender(arac: araclar[index]);
                              });
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
                      child: new Text("İptal",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (this.mounted) {           setState(() {});         }
                      },
                    ),
                    new FlatButton(
                      child: new Text("Ekle",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
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
                          if (this.mounted) {           setState(() {});         }
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
    arac.aracAktifmi == "Evet" ? aracaktifmi = true : aracaktifmi = false;
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
                  if (this.mounted) {           setState(() {});         }
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
                              if (this.mounted) {           setState(() {});         }
                            } else {
                              _showDialog("Boş bırakılamaz",
                                  "Bütün alanları doldurmalısınız");
                            }
                            ale.aracListesiDoldur();
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
                            ale.aracListesiDoldur();
                          },
                        ),
                        new GestureDetector(
                          child: new Text("Kapat",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.of(context).pop();
                            if (this.mounted) {           setState(() {});         }
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

class ShowCalender extends StatefulWidget {
  final Arac arac;
  ShowCalender({this.arac});
  @override
  _ShowCalenderState createState() => _ShowCalenderState(arac: arac);
}

class _ShowCalenderState extends State<ShowCalender> {
  final Arac arac;
  _ShowCalenderState({this.arac});
  List<String> aylar = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık'
  ];
  DateTime takvimzamani = DateTime.now();
  Database _database = Database();
  List<DateTime> musaitTarihler = List<DateTime>();
  List<DateTime> tarihler = List<DateTime>();
  bool tarihCekim = false;

  DateTime getFirstDayOfMonth(DateTime zaman) {
    var dateTime = zaman;
    dateTime = DateUtils.getFirstDayOfMonth(dateTime.month);
    return dateTime;
  }

  DateTime getFirstDayOfNextMonth(DateTime zaman) {
    var dateTime = getFirstDayOfMonth(zaman);
    dateTime = DateUtils.addDaysToDate(dateTime, 31);
    dateTime = DateTime(dateTime.year, dateTime.month, 1);
    return dateTime;
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

  @override
  void initState() {
    super.initState();
    tarihleriDoldur();
  }

  tarihleriDoldur() async {
    List<AracMusaitlik> aractarihler =
        await _database.aracMusaitlikTarihleriCek(arac.aracPlakasi);
    for (var tarih in aractarihler) {
      tarihler.add(tarih.musaitOlduguTarih);
      musaitTarihler.add(tarih.musaitOlduguTarih);
    }
    tarihCekim = true;
    if (this.mounted) {           setState(() {});         }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00000000),
        body: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  if (takvimzamani.month != DateTime.now().month &&
                      takvimzamani.year == DateTime.now().year) {
                    takvimzamani =
                        DateTime(takvimzamani.year, takvimzamani.month - 1, 1);
                    takvimzamani.month == DateTime.now().month
                        ? takvimzamani = DateTime(takvimzamani.year,
                            takvimzamani.month, DateTime.now().day)
                        : DateTime.now();
                    if (this.mounted) {           setState(() {});         }
                  }
                },
              ),
              Text(aylar[takvimzamani.month.toInt() - 1] +
                  " " +
                  takvimzamani.year.toString()),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  takvimzamani = getFirstDayOfNextMonth(takvimzamani);
                  if (this.mounted) {           setState(() {});         }
                },
              ),
            ],
          ),
          content: Builder(
            builder: (context) {
              if (tarihCekim) {
                return GestureDetector(
                  child: Calendarro(
                    weekdayLabelsRow: Row(
                      children: <Widget>[
                        Expanded(
                            child: AutoSizeText("Pzt",
                                maxLines: 1, textAlign: TextAlign.center)),
                        Expanded(
                            child: AutoSizeText("Sal",
                                maxLines: 1, textAlign: TextAlign.center)),
                        Expanded(
                            child: AutoSizeText("Çar",
                                maxLines: 1, textAlign: TextAlign.center)),
                        Expanded(
                            child: AutoSizeText("Per",
                                maxLines: 1, textAlign: TextAlign.center)),
                        Expanded(
                            child: AutoSizeText("Cum",
                                maxLines: 1, textAlign: TextAlign.center)),
                        Expanded(
                            child: AutoSizeText("Cmt",
                                maxLines: 1, textAlign: TextAlign.center)),
                        Expanded(
                            child: AutoSizeText("Paz",
                                maxLines: 1, textAlign: TextAlign.center)),
                      ],
                    ),
                    selectedDates: tarihler,
                    startDate: takvimzamani,
                    endDate: getFirstDayOfNextMonth(takvimzamani)
                        .subtract(Duration(days: 1)),
                    selectionMode: SelectionMode.MULTI,
                    displayMode: DisplayMode.MONTHS,
                    onTap: (DateTime date) {
                      bool sahipmi = musaitTarihler.contains(date);
                      sahipmi
                          ? musaitTarihler.remove(date)
                          : musaitTarihler.add(date);
                    },
                  ),
                  onHorizontalDragEnd: (DragEndDetails e) {
                    print(e.velocity.pixelsPerSecond.dx);
                    if (e.velocity.pixelsPerSecond.dx < -1000) {
                      takvimzamani = getFirstDayOfNextMonth(takvimzamani);
                      if (this.mounted) {           setState(() {});         }
                    } else if (e.velocity.pixelsPerSecond.dx > 1000) {
                      if (takvimzamani.month != DateTime.now().month &&
                          takvimzamani.year == DateTime.now().year) {
                        takvimzamani = DateTime(
                            takvimzamani.year, takvimzamani.month - 1, 1);
                        takvimzamani.month == DateTime.now().month
                            ? takvimzamani = DateTime(takvimzamani.year,
                                takvimzamani.month, DateTime.now().day)
                            : DateTime.now();
                        if (this.mounted) {           setState(() {});         }
                      }
                    }
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Kaydet"),
              onPressed: () async {
                await _database.aracMusaitlikSil(arac.aracPlakasi);
                for (var tarih in musaitTarihler) {
                  _database.aracMusaitlikKaydet(arac.aracPlakasi, tarih);
                }
                _showDialog(
                    "Tarihler Kaydedildi", "Tarihler başarıyla kaydedildi");
                //Kapat
              },
            )
          ],
        ));
  }
}

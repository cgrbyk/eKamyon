import 'package:auto_size_text/auto_size_text.dart';
import 'package:ekamyon/Modeller/firma.dart';
import 'package:ekamyon/database.dart';
import 'package:flutter/material.dart';

class Firmalar extends StatefulWidget {
  @override
  _FirmalarState createState() => _FirmalarState();
}

class _FirmalarState extends State<Firmalar> {
  Database _database=Database();
    List<Firma> firmalar = List<Firma>();
  int itemcount = 1;
  @override
  void initState() {
    super.initState();
    getFirmalar();
  }
  getFirmalar()async{
    firmalar=await _database.getFirmalar();
    itemcount=firmalar.length;
    setState((){});
  }

  void _showDetay(Firma firma) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text(firma.firmaUnvani)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView(
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
                    Text(firma.firmaAdres),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Cep NO :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaCepTel),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Sabit Tel :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaSabitTel),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Faaliyet süresi :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaKacYildirFaaliyette),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Araç sayısı :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaAracSayisi),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma Personel Sayısı :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaPersonelSayisi),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Firma web sitesi :",
                        style: TextStyle(color: Colors.grey)),
                    Text(firma.firmaWebSitesi),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Firmalar',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        color: Color(0xFF96beff),
        child: ListView.builder(
          itemCount: itemcount,
          itemBuilder: (context,index){
            if (firmalar.length != 0) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AutoSizeText("Firma unvan",
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1),
                          AutoSizeText(
                              firmalar[index].firmaUnvani,
                              style: TextStyle(color: Colors.grey[600]),
                              maxLines: 1),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          AutoSizeText("Şehir",
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1),
                          AutoSizeText(
                              firmalar[index].firmaIl +
                                  "/" +
                                  firmalar[index].firmaIlce,
                              style: TextStyle(color: Colors.grey[600]),
                              maxLines: 1),
                        ],
                      ),
                      OutlineButton(
                        color: Colors.blue,
                        splashColor: Colors.blue[600],
                        highlightColor: Colors.blue[300],
                        child: AutoSizeText(
                          "Detay",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          _showDetay(firmalar[index]);
                        }, 
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

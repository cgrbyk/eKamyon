import 'dart:async';
import 'package:flutter/material.dart';

class KayitKullanici extends StatefulWidget {
  @override
  KayitKullaniciEkrani createState() => KayitKullaniciEkrani();
}

class KayitKullaniciEkrani extends State<KayitKullanici> {

  TextEditingController adController= new TextEditingController();
  TextEditingController soyadController= new TextEditingController();
  TextEditingController tcNoController= new TextEditingController();
  TextEditingController telNoController= new TextEditingController();
  TextEditingController evAdresController= new TextEditingController();
  TextEditingController ePostaAdresController= new TextEditingController();
  TextEditingController kullaniciAdiController= new TextEditingController();
  TextEditingController sifre1Controller= new TextEditingController();
  TextEditingController sifre2Controller= new TextEditingController();

  FocusNode soyadFocus=new FocusNode();
  FocusNode tcNoFocus=new FocusNode();
  FocusNode telNoFocus=new FocusNode();
  FocusNode evAdresFocus=new FocusNode();
  FocusNode ePostaAdresFocus=new FocusNode();
  FocusNode kullaniciAdiFocus=new FocusNode();
  FocusNode sifre1Focus=new FocusNode();
  FocusNode sifre2Focus=new FocusNode();

  bool ischecked=false;

  Widget customTextBox(TextInputType type,String placeholder,TextEditingController controller,TextInputAction action,FocusNode ownFocus,FocusNode tofocus)
  {
    return TextField(
                      focusNode: ownFocus,
                      keyboardType: type,
                      autofocus: false,
                      decoration: InputDecoration(                       
                        hintText: placeholder,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),                       
                      ),
                      controller: controller,
                      textInputAction: action,
                      onSubmitted: (String s) {
                        FocusScope.of(context).requestFocus(tofocus);
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 20),
                    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
        appBar: AppBar(
          title:Text('Yeni Kullanıcı Kayıt'),
          actions: <Widget>[
            SizedBox(
              width:  MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
          ],
        ),
        body: ListView(
            children: <Widget>[
              customTextBox(TextInputType.text,"Adınız",adController,TextInputAction.next,null,soyadFocus),
              customTextBox(TextInputType.text,"Soyadınız",soyadController,TextInputAction.next,soyadFocus,tcNoFocus),
              customTextBox(TextInputType.number,"Tc kimlik numaranız",tcNoController,TextInputAction.next,tcNoFocus,telNoFocus),
              customTextBox(TextInputType.number,"Telefon numaranızı giriniz",telNoController,TextInputAction.next,telNoFocus,evAdresFocus),
              customTextBox(TextInputType.text,"Ev adresiniz",evAdresController,TextInputAction.next,evAdresFocus,ePostaAdresFocus),
              customTextBox(TextInputType.emailAddress,"E-posta adresiniz",ePostaAdresController,TextInputAction.next,ePostaAdresFocus,kullaniciAdiFocus),
              customTextBox(TextInputType.text,"Kullanıcı adınız",kullaniciAdiController,TextInputAction.next,kullaniciAdiFocus,sifre1Focus),
              customTextBox(TextInputType.text,"Bir şifre girin",sifre1Controller,TextInputAction.next,sifre1Focus,sifre2Focus),
              customTextBox(TextInputType.text,"Şifreyi tekrar girin",sifre2Controller,TextInputAction.next,sifre2Focus,null),
              FlatButton(
                child:Text("Kullanıcı sözleşmesini buradan okuyabilirsiniz",style:TextStyle(color:Colors.red,fontWeight: FontWeight.bold)),
                onPressed: (){
                  //tarayıcıdan sözleşme açılacak
                },
              ),
              CheckboxListTile(
                value: ischecked,
                onChanged: (bool changestate){setState(){ischecked=changestate;}},
                title: Text("Gizlilik sözleşmesini okudum ve kabul ediyorum"),
              )
            ],
        ),
      );
  }
}


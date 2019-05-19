import 'package:ekamyon/Modeller/metadata.dart';

class Musteri {
  final String userid;
  final String musteriiletisimtel;
  final String musteripostakodu;
  final String musteritckimlikno;
  final String musteriadres;
  final String musteriil;
  final String musteriilce;
  final String lastname;
  final String nickname;
  final String firstname;

  Musteri(
      {this.userid,
      this.musteriiletisimtel,
      this.musteripostakodu,
      this.musteritckimlikno,
      this.musteriadres,
      this.musteriilce,
      this.lastname,
      this.nickname,
      this.firstname,
      this.musteriil});

  factory Musteri.fromJson(List<dynamic> json) {
    List<Metadata> bilgiler = Metadata.fromArray(json);
    return Musteri(
      userid: bilgiler[0].id.toString(),
      musteriiletisimtel: getMetaValue('musteri-iletisim-tel', bilgiler),
      musteripostakodu: getMetaValue('musteri-posta-kodu', bilgiler),
      musteritckimlikno: getMetaValue('musteri-tc-kimlik-no', bilgiler),
      musteriadres: getMetaValue('musteri-adres', bilgiler),
      musteriil: getMetaValue('musteri-il', bilgiler),
      musteriilce: getMetaValue('musteri-ilce', bilgiler),
      lastname: getMetaValue('last_name', bilgiler),
      nickname: getMetaValue('nickname', bilgiler),
      firstname: getMetaValue('first_name', bilgiler),
    );
  }

  static List<Musteri> fromArray(Map jsonArray) {
    List<Musteri> musteriler = List<Musteri>();
    if (jsonArray != null) {
      jsonArray.forEach((key, value) => musteriler.add(Musteri.fromJson(value)));
    }
    return musteriler;
  }

  static getMetaValue(String metaKey, List<Metadata> gelenveri) {
    try {
      Metadata tempdata =
          gelenveri.singleWhere((mdata) => mdata.metakey == metaKey);
      return tempdata.metavalue;
    } catch (e) {
      print(e);
      return "Girilmemiş";
    }
  }
}

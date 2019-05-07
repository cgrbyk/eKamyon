import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Modeller/metadata.dart';
import 'Modeller/aktifKullaniciBilgileri.dart';

class Database {
  giris(String kulEmail, String kulSifre) async {
    final response =
        await http.post("https://www.ekamyon.com/wp-app/login2.php", body: {
      'Email': kulEmail,
      'KullaniciSifresi': kulSifre,
    });
    if (response.body != "hata") {
      var json = jsonDecode(response.body);
      List<Metadata> gelenveri = Metadata.fromArray(json);
      String tur =
          AktifKullaniciBilgileri.aktifKullaniciVerisiDoldur(gelenveri);
      return tur;
    } else
      return "basarisiz";
  }

  araclar() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Araclarim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu.toString());
    var json = jsonDecode(response.body);
    return json;
  }

  yeniAracKayit(String aracPlaka, String aracMarka, String aracModel,
      bool aracaktifmi) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/insert_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55",
        body: {
          'InsertTuru': 'InsertArac',
          'FirmaID': AktifKullaniciBilgileri.firmaKodu.toString(),
          'AracPlakasi': aracPlaka,
          'AracMarka': aracMarka,
          'AracModel': aracModel,
          'AracAktifmi': aracaktifmi.toString(),
        });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  aracBilgiGuncelle(String aracPlaka, String aracMarka, String aracModel,
      bool aracaktifmi) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/update_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&UpdateTuru=UpdateAraclarim",
        body: {
          'FirmaID': AktifKullaniciBilgileri.firmaKodu.toString(),
          'AracPlakasi': aracPlaka,
          'AracMarka': aracMarka,
          'AracModel': aracModel,
          'AracAktifmi': aracaktifmi.toString(),
        });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  aracSil(String aracPlaka) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/update_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&UpdateTuru=UpdateAraclarim",
        body: {
          'DeleteTuru': 'DeleteAraclarim',
          'FirmaID': AktifKullaniciBilgileri.firmaKodu.toString(),
          'AracPlakasi': aracPlaka,
        });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  fiyatlariCek() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Fiyatlarim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu.toString());
    var json = jsonDecode(response.body);
    return json;
  }
}

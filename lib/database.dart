import 'package:http/http.dart';
import 'dart:convert';
import 'metadata.dart';
import 'aktifKullaniciBilgileri.dart';

class Database {
  giris(String kulEmail, String kulSifre) async {
    final response =
        await post("https://www.ekamyon.com/wp-app/login2.php", body: {
      'Email': kulEmail,
      'KullaniciSifresi': kulSifre,
    });
    if (response.body != "hata") {
      var json = jsonDecode(response.body);
      List<Metadata> gelenveri = Metadata.fromArray(json);
      String tur =
          AktifKullaniciBilgileri.aktifKullaniciVerisiDoldur(gelenveri);
      return tur;
    }
    else return "basarisiz";
  }
}

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
        "http://www.ekamyon.com/wp-app/delete_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55",
        body: {
          'DeleteTuru': 'DeleteAraclarim',
          'FirmaID': AktifKullaniciBilgileri.firmaKodu,
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

  fiyatKaydet(String varisil, String oda, String tasimaUcreti) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/insert_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55",
        body: {
          'InsertTuru': 'InsertFiyat',
          'FirmaID': AktifKullaniciBilgileri.firmaKodu,
          'varisIL': varisil,
          'OdaTipi': oda,
          'tasimaUcreti': tasimaUcreti
        });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  fiyatsil(String varisil, String oda, String tasimaUcreti) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/delete_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55",
        body: {
          'DeleteTuru': 'DeleteFiyatlarim',
          'FirmaID': AktifKullaniciBilgileri.firmaKodu,
          'VarisIl': varisil,
          'EvTipi': oda,
          'TasimaUcretiTam': tasimaUcreti
        });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  topluFiyatGuncelle(String artisYonu, String tutar) async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/update_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&UpdateTuru=UpdateTopluFiyatlarim&Tur=" +
            artisYonu +
            "&Tutar=" +
            tutar +
            "&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu);
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  tekliFiyatGuncelle(
      String tasimaUcreti, String paramVarisIl, String paramEvTipi) async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/update_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&UpdateTuru=UpdateFiyatlarim&TasimaUcretiTam=" + tasimaUcreti + "&FirmaID=" + AktifKullaniciBilgileri.firmaKodu + "&VarisIl=" + paramVarisIl + "&EvTipi=" + paramEvTipi);
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  kullaniciBilgileriGuncelle(
      String telefon, String evAdresi, String ePosta) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/update_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&UpdateTuru=UpdateMusteriBilgilerim",
        body: {
          'MusteriID': AktifKullaniciBilgileri.musteriKodu,
          'Telefonu': telefon,
          'EvAdresi': evAdresi,
          'Eposta': ePosta,
        });
    if (response.statusCode == 200) {
      AktifKullaniciBilgileri.musteriTelNo = telefon;
      AktifKullaniciBilgileri.musteriAdresi = evAdresi;
      AktifKullaniciBilgileri.musteriEposta = ePosta;
      return true;
    } else
      return false;
  }

  firmaBilgileriGuncelle(
      String firmaUnvan,
      String firmaIl,
      String firmaIlce,
      String firmaAdres,
      String vergiDairesi,
      String vergiNo,
      String firmaAracSayisi,
      String firmaPersonelSayisi,
      String firmaBelgeler,
      String firmaKacYildirFaaliyette,
      String firmaWebSitesi,
      String sabitTel,
      String cepTel,
      String bankaAdiBir,
      String bankaIbanBir,
      String bankaAdiIki,
      String bankaIbanIki,
      String bankaAdiUc,
      String bankaIbanUc) async {
    final response = await http.post(
        "http://www.ekamyon.com/wp-app/update_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&UpdateTuru=UpdateFirmaBilgilerim",
        body: {
          'FirmaID': AktifKullaniciBilgileri.firmaKodu,
          'FirmaUnvan': firmaUnvan,
          'FirmaIl': firmaIl,
          'FirmaIlce': firmaIlce,
          'FirmaAdres': firmaAdres,
          'VergiDairesi': vergiDairesi,
          'VergiNo': vergiNo,
          'FirmaAracSayisi': firmaAracSayisi,
          'FirmaPersonelSayisi': firmaPersonelSayisi,
          'FirmaBelgeler': firmaBelgeler,
          'FirmaKacYildirFaaliyette': firmaKacYildirFaaliyette,
          'FirmaWebSitesi': firmaWebSitesi,
          'SabitTel': sabitTel,
          'CepTel': cepTel,
          'BankaAdiBir': bankaAdiBir,
          'BankaIbanBir': bankaIbanBir,
          'BankaAdiIki': bankaAdiIki,
          'BankaIbanIki': bankaIbanIki,
          'BankaAdiUc': bankaAdiUc,
          'BankaIbanUc': bankaIbanUc,
        });
    if (response.statusCode == 200) {
      AktifKullaniciBilgileri.firmaAdi=firmaUnvan;
      AktifKullaniciBilgileri.firmaUnvani = firmaUnvan;
      AktifKullaniciBilgileri.firmaIl = firmaIl;
      AktifKullaniciBilgileri.firmaIlce = firmaIlce;
      AktifKullaniciBilgileri.firmaAdres = firmaAdres;
      AktifKullaniciBilgileri.firmaVergiDairesi = vergiDairesi;
      AktifKullaniciBilgileri.firmaVergiNo = vergiNo;
      AktifKullaniciBilgileri.firmaAracSayisi = firmaAracSayisi;
      AktifKullaniciBilgileri.firmaPersonelSayisi = firmaPersonelSayisi;
      AktifKullaniciBilgileri.firmaBelgeler = firmaBelgeler;
      AktifKullaniciBilgileri.firmaKacYildirFaaliyette =
          firmaKacYildirFaaliyette;
      AktifKullaniciBilgileri.firmaWebSitesi = firmaWebSitesi;
      AktifKullaniciBilgileri.firmaSabitTel = sabitTel;
      AktifKullaniciBilgileri.firmaCepTel = cepTel;
      AktifKullaniciBilgileri.firmaBankaBir = bankaAdiBir;
      AktifKullaniciBilgileri.firmaIbanBir = bankaIbanBir;
      AktifKullaniciBilgileri.firmaBankaIki = bankaAdiIki;
      AktifKullaniciBilgileri.firmaIbanIki = bankaIbanIki;
      AktifKullaniciBilgileri.firmaBankaUc = bankaAdiUc;
      AktifKullaniciBilgileri.firmaIbanUc = bankaIbanUc;
      return true;
    } else
      return false;
  }

  yeniFirmaEkle(
    String telefon,
    String firmaAdi,
    String firmaIl,
    String firmaIlce,
    String firmaAdresBir,
    String kullaniciAdi,
    String kullaniciSifresi,
    String eposta,
    String firmaWebSitesi,
    String ad,
    String soyad,
    String tcNo,
    String vergiDairesi,
    String vergiNo,
    String bankaAdiBir,
    String bankaIbanBir,
    String postaKodu,
  ) async {
    final response =
        await http.post("https://www.ekamyon.com/wp-app/register.php", body: {
      'KullaniciTuru': 'Firma',
      'Telefonu': telefon,
      'FirmaAdi': firmaAdi,
      'FirmaIl': firmaIl,
      'FirmaIlce': firmaIlce,
      'FirmaAdresBir': firmaAdresBir,
      'KullaniciAdi': kullaniciAdi,
      'KullaniciSifresi': kullaniciSifresi,
      'Eposta': eposta,
      'FirmaWebSitesi': firmaWebSitesi,
      'Ad': ad,
      'Soyad': soyad,
      'TcNo': tcNo,
      'VergiDairesi': vergiDairesi,
      'VergiNo': vergiNo,
      'BankaAdiBir': bankaAdiBir,
      'BankaIbanBir': bankaIbanBir,
      'PostaKodu': postaKodu,
      'KayitTarihi': DateTime.now().toString(),
      'SozlesmeKabulTarihi': DateTime.now().toString(),
      'token': '', //Onesignal Token
    });
    if (response.body == "Kaydedildi")
      return true;
    else
      return false;
  }

  yeniKullaniciEkle(
    String kullaniciAdi,
    String kullaniciSifresi,
    String musteriAdi,
    String musteriSoyadi,
    String tcNo,
    String telefonu,
    String evAdresi,
    String eposta,
  ) async {
    final response =
        await http.post("https://www.ekamyon.com/wp-app/register.php", body: {
      'KullaniciTuru': 'Musteri',
      'KullaniciAdi': kullaniciAdi,
      'KullaniciSifresi': kullaniciSifresi,
      'MusteriAdi': musteriAdi,
      'MusteriSoyadi': musteriSoyadi,
      'TcNo': tcNo,
      'Telefonu': telefonu,
      'EvAdresi': evAdresi,
      'Eposta': eposta,
      'KayitTarihi': DateTime.now().toString(),
      'SozlesmeKabulTarihi': DateTime.now().toString(),
      'token': '' //One Signal TOken
    });
    if (response.body == "Kaydedildi")
      return true;
    else
      return false;
  }
}

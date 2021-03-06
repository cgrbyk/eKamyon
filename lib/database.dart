/*
ÇAĞRI BIYIK 2019
*/

import 'package:ekamyon/Modeller/EkFiyatlar.dart';
import 'package:ekamyon/Modeller/Nakliye.dart';
import 'package:ekamyon/Modeller/aracmusaitlik.dart';
import 'package:ekamyon/Modeller/firma.dart';
import 'package:ekamyon/Modeller/musteri.dart';
import 'package:ekamyon/Modeller/teklifFirma.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Modeller/metadata.dart';
import 'Modeller/aktifKullaniciBilgileri.dart';
import "package:collection/collection.dart";

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

  sigortaFiyatiAl() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=SigortaFiyati");
    var json = jsonDecode(response.body);
    return json;
  }

  yeniAracKayit(String aracPlaka, String aracMarka, String aracModel,
      bool aracaktifmi) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/insert_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'InsertTuru': 'InsertArac',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu.toString(),
      'AracPlakasi': aracPlaka,
      'AracMarka': aracMarka,
      'AracModel': aracModel,
      'AracAktifmi': aracaktifmi ? 'Evet' : 'Hayır',
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  aracBilgiGuncelle(String aracPlaka, String aracMarka, String aracModel,
      bool aracaktifmi) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/update_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'UpdateTuru': 'UpdateAraclarim',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu.toString(),
      'AracPlakasi': aracPlaka,
      'AracMarka': aracMarka,
      'AracModel': aracModel,
      'AracAktifmi': aracaktifmi ? 'Evet' : 'Hayır',
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  aracSil(String aracPlaka) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/delete_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'DeleteTuru': 'DeleteAraclarim',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'AracPlakasi': aracPlaka,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  aracMusaitlikTarihleriCek(String plaka) async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=MusaitAraclarim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu +
            "&AracPlakasi=" +
            plaka);
    if (response.statusCode == 200 &&
        response.body != null &&
        response.body != "null") {
      print(response.body);
      var json = jsonDecode(response.body);
      return AracMusaitlik.fromArray(json);
    } else
      return List<AracMusaitlik>();
  }

  aracMusaitlikKaydet(String aracPlakasi, DateTime musaitOlduguTarih) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/insert_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'InsertTuru': 'InsertMusaitAraclar',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'AracPlakasi': aracPlakasi,
      'MusaitOlduguTarih': musaitOlduguTarih.toString(),
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  aracMusaitlikSil(String plaka) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/delete_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'DeleteTuru': 'DeleteMusaitlik',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'AracPlakasi': plaka,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  fiyatlariCek() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Fiyatlarim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu.toString());
    var json = jsonDecode(response.body);
    return json;
  }

  ekFiyatlariCek() async {
    EkFiyatlar fiyatlar = EkFiyatlar();
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=EkUcretler&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu.toString());
    if (response.body != "null")
      fiyatlar = EkFiyatlar.fromArray(jsonDecode(response.body))[0];
    return fiyatlar;
  }

  ilceBilgileriCek(String il) async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=IlceBilgileri&Il=" +
            il);
    var json = jsonDecode(response.body);
    return json;
  }

  sehiIcifiyatlariCek() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=SehirIciFiyatlarim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu.toString());
    var json = jsonDecode(response.body);
    return json;
  }

  fiyatKaydet(
      String varisil,
      String oda,
      String tasimaUcreti,
      bool isSehirlerArasi,
      String yakitMasrafi,
      String iscilikUcreti,
      String asansorBedeli,
      String firmaKari,
      String ilce) async {
    String updateTuru;
    if (isSehirlerArasi)
      updateTuru = 'InsertFiyatSehirDisi';
    else
      updateTuru = 'InsertFiyatSehirIci';
    final response =
        await http.post("http://www.ekamyon.com/wp-app/insert_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'InsertTuru': updateTuru,
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'VarisIl': isSehirlerArasi ? varisil : AktifKullaniciBilgileri.firmaIl,
      'EvTipi': oda,
      'YakitMasrafi': yakitMasrafi,
      'IscilikUcreti': iscilikUcreti,
      'AsansorBedeli': asansorBedeli,
      'FirmaKari': firmaKari,
      'TasimaUcreti': tasimaUcreti,
      'VarisIlce': ilce,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  fiyatsil(String varisil, String oda, String tasimaUcreti) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/delete_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
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

  topluFiyatGuncelle(
      String artisYonu, String tutar, bool sehirlerArasiMi) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/update_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'UpdateTuru':
          sehirlerArasiMi ? 'UpdateTopluSehirDisi' : 'UpdateTopluSehirIci',
      'Tutar': tutar,
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'Tur': artisYonu,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  ekFiyatGuncelle(String var1, String var2, String var3, String var4) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/update_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'UpdateTuru': 'UpdateEkUcretler',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'Var1': var1,
      'Var2': var2,
      'Var3': var3,
      'Var4': var4,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  tekliFiyatGuncelle(String yakit, String iscilik, String asansor, String firma,
      String toplamucret, String paramVarisIl, String paramEvTipi) async {
    final response =
        await http.post('http://www.ekamyon.com/wp-app/update_data.php', body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'UpdateTuru': 'UpdateFiyatSehirDisi',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'EvTipi': paramEvTipi,
      'VarisIl': paramVarisIl,
      'YakitMasrafi': yakit,
      'IscilikUcreti': iscilik,
      'AsansorBedeli': asansor,
      'FirmaKari': firma,
      'TasimaUcreti': toplamucret,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  tekliSehirIciFiyatGuncelle(
      String yakit,
      String iscilik,
      String asansor,
      String firma,
      String toplamucret,
      String paramVarisIlce,
      String paramEvTipi) async {
    final response =
        await http.post('http://www.ekamyon.com/wp-app/update_data.php', body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'UpdateTuru': 'UpdateFiyatSehirIci',
      'FirmaID': AktifKullaniciBilgileri.firmaKodu,
      'EvTipi': paramEvTipi,
      'VarisIl': paramVarisIlce,
      'YakitMasrafi': yakit,
      'IscilikUcreti': iscilik,
      'AsansorBedeli': asansor,
      'FirmaKari': firma,
      'TasimaUcreti': toplamucret,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  kullaniciBilgileriGuncelle(
      String telefon, String evAdresi, String ePosta) async {
    final response =
        await http.post("http://www.ekamyon.com/wp-app/update_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'UpdateTuru': 'UpdateMusteri',
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

  evdenEveTasimaTeklifleriAl(DateTime tasinmaTarih, String mevcutIl,
      String varisIl, String odaSayisi) async {
    odaSayisi = odaSayisi.split('+')[0];
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Teklifler&TasinmaTarihi=" +
            tasinmaTarih.toString() +
            "&MevcutIl=" +
            mevcutIl +
            "&VarisIl=" +
            varisIl +
            "&EvTipi=" +
            odaSayisi +
            ".1");
    if (response.statusCode == 200) {
      if (response.body != "null") {
        List<TeklifFirma> gelenteklifler =
            TeklifFirma.fromArray(json.decode(response.body));
        return gelenteklifler;
      }
    } else
      return null;
  }

  ofisTasimaTeklifleriAl(DateTime tarih, String mevcutSehir,
      String gelecekSehir, String odaSayisi) async {
    odaSayisi = odaSayisi.split('+')[0];
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Teklifler&TasinmaTarihi=" +
            tarih.toString() +
            "&MevcutIl=" +
            mevcutSehir +
            "&VarisIl=" +
            gelecekSehir +
            "&EvTipi=" +
            odaSayisi +
            ".1");
    if (response.statusCode == 200) {
      if (response.body != "null") {
        var jsonArray = jsonDecode(response.body);
        List<TeklifFirma> gelenTeklifler = TeklifFirma.fromArray(jsonArray);
        return gelenTeklifler;
      } else
        return null;
    } else
      return null;
  }

  getMusteriler() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Musteriler");
    var json = jsonDecode(response.body);
    Map map = groupBy(json, (obj) => obj['user_id']);
    List<Musteri> musteriler = Musteri.fromArray(map);
    return musteriler;
  }

  getTalepler(String musteriID, String firmaUnvan) async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Talepler&MusteriID=" +
            musteriID +
            "&firma_unvan=" +
            firmaUnvan);
    var json = jsonDecode(response.body);
    return json;
  }

  getFirmalar() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=Firmalar");
    var json = jsonDecode(response.body);
    Map map = groupBy(json, (obj) => obj['user_id']);
    List<Firma> firmalar = Firma.fromArray(map);
    return firmalar;
  }

  getBekleyenNakliyeler() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=FirmaBekleyenNakliyelerim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu);
    List<Nakliye> nakliyeler = Nakliye.fromArray(jsonDecode(response.body));
    return nakliyeler;
  }

  getMusteriBekleyenNakliyelerAdmin(String kulNo) async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=MusteriGecmisNakliyelerim&MusteriID=" +
            kulNo);
    List<Nakliye> nakliyeler = Nakliye.fromArray(jsonDecode(response.body));
    return nakliyeler;
  }

  getFirmaNakliyelerAdmin(String firmaNo) async {
    List<Nakliye> nakliyeler = List<Nakliye>();
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=BekleyenNakliyelerim&FirmaID=" +
            firmaNo);
    if (response.body.isNotEmpty)
      nakliyeler = Nakliye.fromArray(jsonDecode(response.body));
    return nakliyeler;
  }

  getTamamlananNakliyeler() async {
    final response = await http.get(
        "http://www.ekamyon.com/wp-app/select_data.php?Token=a15f5r1e514r1s5dw15w111w5we5qqa1hy55&SelectTuru=FirmaTamamlananNakliyelerim&FirmaID=" +
            AktifKullaniciBilgileri.firmaKodu);
    List<Nakliye> nakliyeler = Nakliye.fromArray(jsonDecode(response.body));
    return nakliyeler;
  }

  esyaTasimaTeklifiSec(
      DateTime tasimaTarihi,
      String mevcutIl,
      String mevcutIlce,
      String mevcutAdres,
      String esyaCinsi,
      String yukeYaklasma,
      String nasilTasinacak,
      String nasilPaketlenecek,
      String varisIl,
      String varisIlce,
      String varisAdres,
      bool sigorta,
      bool coklutasima,
      String firmaID,
      String anlasilanFiyat) async {
    final response =
        await http.post('http://www.ekamyon.com/wp-app/insert_data.php', body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'InsertTuru': 'Esya',
      'MusteriID': AktifKullaniciBilgileri.musteriKodu,
      'MusteriAdi': AktifKullaniciBilgileri.musteriAdi,
      'Eposta': AktifKullaniciBilgileri.musteriEposta,
      'TasinmaTuru': 'Eşya Taşıma',
      'TasinmaTarihi': tasimaTarihi.toString(),
      'MevcutIl': mevcutIl,
      'MevcutIlce': mevcutIlce,
      'MevcutAdres': mevcutAdres,
      'EsyaCinsi': esyaCinsi,
      'YukeYaklasma': yukeYaklasma,
      'NasilTasinacak': nasilTasinacak,
      'NasilPaketlenecek': nasilPaketlenecek,
      'VarisIl': varisIl,
      'VarisIlce': varisIlce,
      'VarisAdres': varisAdres,
      'Sigorta': sigorta ? "Evet İstiyorum" : "Hayır İstemiyorum",
      'TekAracCiftYuk': coklutasima ? "Evet" : "Hayır Yüküm Tek Taşınsın",
      'AnlasilanFirmaID': firmaID,
      'AnlasilanFiyat': anlasilanFiyat,
      'AnlasilanTarih': DateTime.now().toString(),
      'OlusturmaTarihi': DateTime.now().toString(),
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  tasimateklifiSec(
      DateTime tasimaTarihi,
      String mevcutIl,
      String mevcutIlce,
      String mevcutAdres,
      String mevcutOda,
      String mevcutKat,
      String yukeYaklasma,
      String nasilTasinacak,
      String nasilPaketlenecek,
      String varisIl,
      String varisIlce,
      String varisAdres,
      String varisKat,
      bool sigorta,
      bool coklutasima,
      String firmaID,
      String anlasilanFiyat,
      String esyaListesi) async {
    mevcutOda = mevcutOda.replaceAll('+', '.');
    final response =
        await http.post('http://www.ekamyon.com/wp-app/insert_data.php', body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'InsertTuru': 'EvdenEve',
      'MusteriID': AktifKullaniciBilgileri.musteriKodu,
      'MusteriAdi': AktifKullaniciBilgileri.musteriAdi,
      'Eposta': AktifKullaniciBilgileri.musteriEposta,
      'TasinmaTuru': 'Evden Eve Taşınma',
      'TasinmaTarihi': tasimaTarihi.toString(),
      'MevcutIl': mevcutIl,
      'MevcutIlce': mevcutIlce,
      'MevcutAdres': mevcutAdres,
      'MevcutOda': mevcutOda,
      'MevcutKat': mevcutKat,
      'YukeYaklasma': yukeYaklasma,
      'NasilTasinacak': nasilTasinacak,
      'NasilPaketlenecek': nasilPaketlenecek,
      'VarisIl': varisIl,
      'VarisIlce': varisIlce,
      'VarisAdres': varisAdres,
      'VarisKat': varisKat,
      'Sigorta': sigorta ? "Evet İstiyorum" : "Hayır İstemiyorum",
      'TekAracCiftYuk': coklutasima ? "Evet" : "Hayır Yüküm Tek Taşınsın",
      'AnlasilanFirmaID': firmaID,
      'AnlasilanFiyat': anlasilanFiyat,
      'AnlasilanTarih': DateTime.now().toString(),
      'OlusturmaTarihi': DateTime.now().toString(),
      'EsyaListesi': esyaListesi,
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  ofisTasimaTeklifKabul(
    String odaSayisi,
    DateTime tasinmaTarih,
    String mevcutIl,
    String mevcutIlce,
    String mevcutAdres,
    String mevcutKat,
    String yakinlik,
    String nasilTasinacak,
    String nasilPaketlenecek,
    String varisIl,
    String varisIlce,
    String varisAdres,
    String varisKat,
    bool sigorta,
    bool ortaklik,
    String anlasilanFirmaID,
    String anlasilanFiyat,
  ) async {
    String sigortadurum = "";
    sigorta
        ? sigortadurum = "Evet İstiyorum"
        : sigortadurum = "Hayır İstemiyorum";
    odaSayisi = odaSayisi.replaceAll('+', '.');
    final response =
        await http.post("http://www.ekamyon.com/wp-app/insert_data.php", body: {
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
      'InsertTuru': 'Ofis',
      'MusteriID': AktifKullaniciBilgileri.musteriKodu,
      'MusteriAdi': AktifKullaniciBilgileri.musteriAdi +
          " " +
          AktifKullaniciBilgileri.musteriSoyadi,
      'Eposta': AktifKullaniciBilgileri.musteriEposta,
      'MevcutOda': odaSayisi,
      'TasinmaTuru': 'Ofis Taşıma',
      'TasinmaTarihi': tasinmaTarih.toString(),
      'MevcutIl': mevcutIl,
      'MevcutIlce': mevcutIlce,
      'MevcutAdres': mevcutAdres,
      'MevcutKat': mevcutKat,
      'YukeYaklasma': yakinlik,
      'NasilTasinacak': nasilTasinacak,
      'NasilPaketlenecek': nasilPaketlenecek,
      'VarisIl': varisIl,
      'VarisIlce': varisIlce,
      'VarisAdres': varisAdres,
      'VarisKat': varisKat,
      'Sigorta': sigortadurum,
      'TekAracCiftYuk': ortaklik ? "Evet" : "Hayır Yüküm Tek Taşınsın",
      'AnlasilanFirmaID': anlasilanFirmaID,
      'AnlasilanFiyat': anlasilanFiyat,
      'AnlasilanTarih': DateTime.now().toString(),
      'OlusturmaTarihi': DateTime.now().toString(),
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
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
    final response =
        await http.post("http://www.ekamyon.com/wp-app/update_data.php", body: {
      'UpdateTuru': 'UpdateFirma',
      'Token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
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
      AktifKullaniciBilgileri.firmaAdi = firmaUnvan;
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
      'token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
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
      'token': 'a15f5r1e514r1s5dw15w111w5we5qqa1hy55',
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
    });
    if (response.body == "Kaydedildi")
      return true;
    else
      return false;
  }
}

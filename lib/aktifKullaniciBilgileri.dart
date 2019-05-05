import 'metadata.dart';

class AktifKullaniciBilgileri {
  static String _firmaKodu;
  static String _firmaAdi;
  static String _firmaEposta;
  static String _firmaSifresi;
  static String _firmaTitresim;
  static String _firmaSesli;
  static String _firmaWebSitesi;
  static String _firmaUnvani;
  static String _firmaIl;
  static String _firmaIlce;
  static String _firmaAdres;
  static String _firmaVergiDairesi;
  static String _firmaVergiNo;
  static String _firmaAracSayisi;
  static String _firmaPersonelSayisi;
  static String _firmaBelgeler;
  static String _firmaKacYildirFaaliyette;
  static String _firmaSabitTel;
  static String _firmaCepTel;
  static String _firmaBankaBir;
  static String _firmaIbanBir;
  static String _firmaBankaIki;
  static String _firmaIbanIki;
  static String _firmaBankaUc;
  static String _firmaIbanUc;

  static String _musteriKodu;
  static String _musteriKullaniciAdi;
  static String _musteriAdi;
  static String _musteriSoyadi;
  static String _musteriTcNo;
  static String _musteriTelNo;
  static String _musteriAdresi;
  static String _musteriEposta;
  static String _musteriSifresi;
  static String _musteriTitresim;
  static String _musteriSesli;

  static String _adminKodu;
  static String _adminAdi;
  static String _adminAdresi;
  static String _adminSifresi;
  static String _adminTitresim;
  static String _adminSesli;
  static String _adminEposta;

  static String aktifKullaniciVerisiDoldur(List<Metadata> gelenveri) {
    String tur;
    for (Metadata md in gelenveri)
      if (md.metakey == "wp_capabilities") {
        if (md.metavalue.lastIndexOf("firma") != -1) {
          tur = "firma";
          break;
        } else if (md.metavalue.lastIndexOf("musteri") != -1) {
          tur = "musteri";
          break;
        } else {
          tur = "admin";
          break;
        }
      }
    if (tur == "musteri") {
      _musteriKullaniciAdi = getMetaValue("nickname", gelenveri);
      _musteriAdi = getMetaValue("first_name", gelenveri);
      _musteriAdresi = getMetaValue("musteri-adres", gelenveri);
      _musteriSoyadi = getMetaValue("last_name", gelenveri);
      _musteriTcNo = getMetaValue("musteri-tc-kimlik-no", gelenveri);
      _musteriTelNo = getMetaValue("musteri-iletisim-tel", gelenveri);
    } else if (tur == "firma") {
      _firmaAdi = getMetaValue("firma_unvan", gelenveri);
      _firmaAdres = getMetaValue("firma_adres", gelenveri);
      _firmaUnvani = getMetaValue("firma_unvan", gelenveri);
      _firmaIl = getMetaValue("firma_il", gelenveri);
      _firmaIlce = getMetaValue("firma_ilce", gelenveri);
      _firmaVergiDairesi = getMetaValue("firma_vergi_dairesi", gelenveri);
      _firmaVergiNo = getMetaValue("firma_vergi_no", gelenveri);
      _firmaAracSayisi = getMetaValue("firma_arac_sayisi", gelenveri);
      _firmaPersonelSayisi = getMetaValue("firma_personel_sayisi", gelenveri);
      _firmaKacYildirFaaliyette =
          getMetaValue("firma_kac_yildir_faliyette", gelenveri);
      _firmaSabitTel = getMetaValue("firma_sabit_tel", gelenveri);
      _firmaCepTel = getMetaValue("firma_cep_telefonu", gelenveri);
      _firmaBankaBir = getMetaValue("firma_banka_adi_bir", gelenveri);
      _firmaBankaIki = getMetaValue("firma_banka_adi_iki", gelenveri);
      _firmaBankaUc = getMetaValue("firma_banka_adi_uc", gelenveri);
      _firmaWebSitesi = getMetaValue("firma_web_sitesi", gelenveri);
      _firmaIbanBir = getMetaValue("firma_banka_iban_bir", gelenveri);
      _firmaIbanIki = getMetaValue("firma_banka_iban_iki", gelenveri);
      _firmaIbanUc = getMetaValue("firma_banka_iban_uc", gelenveri);
    } else {
      _adminAdi = getMetaValue("first_name", gelenveri);
      _adminKodu = getMetaValue("ID", gelenveri);
    }
    return tur;
  }

  static getMetaValue(String metaKey, List<Metadata> gelenveri) {
    Metadata tempdata =
        gelenveri.singleWhere((mdata) => mdata.metakey == metaKey);
    return tempdata.metavalue;
  }
}

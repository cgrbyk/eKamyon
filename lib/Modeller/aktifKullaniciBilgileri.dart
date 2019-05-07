import 'metadata.dart';

class AktifKullaniciBilgileri {
 static String firmaKodu;
  static String firmaAdi;
  static String firmaEposta;
  static String firmaSifresi;
  static String firmaTitresim;
  static String firmaSesli;
  static String firmaWebSitesi;
  static String firmaUnvani;
  static String firmaIl;
  static String firmaIlce;
  static String firmaAdres;
  static String firmaVergiDairesi;
  static String firmaVergiNo;
  static String firmaAracSayisi;
  static String firmaPersonelSayisi;
  static String firmaBelgeler;
  static String firmaKacYildirFaaliyette;
  static String firmaSabitTel;
  static String firmaCepTel;
  static String firmaBankaBir;
  static String firmaIbanBir;
  static String firmaBankaIki;
  static String firmaIbanIki;
  static String firmaBankaUc;
  static String firmaIbanUc;

  static String musteriKodu;
  static String musteriKullaniciAdi;
  static String musteriAdi;
  static String musteriSoyadi;
  static String musteriTcNo;
  static String musteriTelNo;
  static String musteriAdresi;
  static String musteriEposta;
  static String musteriSifresi;
  static String musteriTitresim;
  static String musteriSesli;

  static String adminKodu;
  static String adminAdi;
  static String adminAdresi;
  static String adminSifresi;
  static String adminTitresim;
  static String adminSesli;
  static String adminEposta;

  static String aktifKullaniciVerisiDoldur(List<Metadata> gelenveri) {
    String tur;
    for (Metadata md in gelenveri)
      if (md.metakey == "wp_capabilities") {
        if (md.metavalue.lastIndexOf("firma") != -1) {
          firmaKodu=md.id.toString();
          tur = "firma";
          break;
        } else if (md.metavalue.lastIndexOf("musteri") != -1) {
          tur = "musteri";
          musteriKodu=md.id.toString();
          break;
        } else {
          tur = "admin";
          adminKodu=md.id.toString();
          break;
        }
      }
    if (tur == "musteri") {
      musteriKullaniciAdi = getMetaValue("nickname", gelenveri);
      musteriAdi = getMetaValue("first_name", gelenveri);
      musteriAdresi = getMetaValue("musteri-adres", gelenveri);
      musteriSoyadi = getMetaValue("last_name", gelenveri);
      musteriTcNo = getMetaValue("musteri-tc-kimlik-no", gelenveri);
      musteriTelNo = getMetaValue("musteri-iletisim-tel", gelenveri);
    } else if (tur == "firma") {
      firmaAdi = getMetaValue("firma_unvan", gelenveri);
      firmaAdres = getMetaValue("firma_adres", gelenveri);
      firmaUnvani = getMetaValue("firma_unvan", gelenveri);
      firmaIl = getMetaValue("firma_il", gelenveri);
      firmaIlce = getMetaValue("firma_ilce", gelenveri);
      firmaVergiDairesi = getMetaValue("firma_vergi_dairesi", gelenveri);
      firmaVergiNo = getMetaValue("firma_vergi_no", gelenveri);
      firmaAracSayisi = getMetaValue("firma_arac_sayisi", gelenveri);
      firmaPersonelSayisi = getMetaValue("firma_personel_sayisi", gelenveri);
      firmaKacYildirFaaliyette =
          getMetaValue("firma_kac_yildir_faliyette", gelenveri);
      firmaSabitTel = getMetaValue("firma_sabit_tel", gelenveri);
      firmaCepTel = getMetaValue("firma_cep_telefonu", gelenveri);
      firmaBankaBir = getMetaValue("firma_banka_adi_bir", gelenveri);
      firmaBankaIki = getMetaValue("firma_banka_adi_iki", gelenveri);
      firmaBankaUc = getMetaValue("firma_banka_adi_uc", gelenveri);
      firmaWebSitesi = getMetaValue("firma_web_sitesi", gelenveri);
      firmaIbanBir = getMetaValue("firma_banka_iban_bir", gelenveri);
      firmaIbanIki = getMetaValue("firma_banka_iban_iki", gelenveri);
      firmaIbanUc = getMetaValue("firma_banka_iban_uc", gelenveri);
    } else {
      adminAdi = getMetaValue("first_name", gelenveri);
      adminKodu = getMetaValue("ID", gelenveri);
    }
    return tur;
  }

  static getMetaValue(String metaKey, List<Metadata> gelenveri) {
    Metadata tempdata =
        gelenveri.singleWhere((mdata) => mdata.metakey == metaKey);
    return tempdata.metavalue;
  }
}

import 'package:ekamyon/Modeller/metadata.dart';

class Firma {
  final String userid;
  final String firmaAdi;
  final String firmaAdres;
  final String firmaUnvani;
  final String firmaIl;
  final String firmaIlce;
  final String firmaVergiDairesi;
  final String firmaVergiNo;
  final String firmaAracSayisi;
  final String firmaPersonelSayisi;
  final String firmaKacYildirFaaliyette;
  final String firmaSabitTel;
  final String firmaCepTel;
  final String firmaBankaBir;
  final String firmaBankaIki;
  final String firmaBankaUc;
  final String firmaWebSitesi;
  final String firmaIbanBir;
  final String firmaIbanIki;
  final String firmaIbanUc;

  Firma({
    this.userid,
    this.firmaAdi,
    this.firmaAdres,
    this.firmaUnvani,
    this.firmaIl,
    this.firmaIlce,
    this.firmaVergiDairesi,
    this.firmaVergiNo,
    this.firmaAracSayisi,
    this.firmaPersonelSayisi,
    this.firmaKacYildirFaaliyette,
    this.firmaSabitTel,
    this.firmaCepTel,
    this.firmaBankaBir,
    this.firmaBankaIki,
    this.firmaBankaUc,
    this.firmaWebSitesi,
    this.firmaIbanBir,
    this.firmaIbanIki,
    this.firmaIbanUc,
  });

  factory Firma.fromJson(List<dynamic> json) {
    List<Metadata> gelenveri = Metadata.fromArray(json);
    return Firma(
      userid: gelenveri[0].id.toString(),
      firmaAdi: getMetaValue("firma_unvan", gelenveri),
      firmaAdres: getMetaValue("firma_adres", gelenveri),
      firmaUnvani: getMetaValue("firma_unvan", gelenveri),
      firmaIl: getMetaValue("firma_il", gelenveri),
      firmaIlce: getMetaValue("firma_ilce", gelenveri),
      firmaVergiDairesi: getMetaValue("firma_vergi_dairesi", gelenveri),
      firmaVergiNo: getMetaValue("firma_vergi_no", gelenveri),
      firmaAracSayisi: getMetaValue("firma_arac_sayisi", gelenveri),
      firmaPersonelSayisi: getMetaValue("firma_personel_sayisi", gelenveri),
      firmaKacYildirFaaliyette:
          getMetaValue("firma_kac_yildir_faliyette", gelenveri),
      firmaSabitTel: getMetaValue("firma_sabit_tel", gelenveri),
      firmaCepTel: getMetaValue("firma_cep_telefonu", gelenveri),
      firmaBankaBir: getMetaValue("firma_banka_adi_bir", gelenveri),
      firmaBankaIki: getMetaValue("firma_banka_adi_iki", gelenveri),
      firmaBankaUc: getMetaValue("firma_banka_adi_uc", gelenveri),
      firmaWebSitesi: getMetaValue("firma_web_sitesi", gelenveri),
      firmaIbanBir: getMetaValue("firma_banka_iban_bir", gelenveri),
      firmaIbanIki: getMetaValue("firma_banka_iban_iki", gelenveri),
      firmaIbanUc: getMetaValue("firma_banka_iban_uc", gelenveri),
    );
  }

  static List<Firma> fromArray(Map jsonArray) {
    List<Firma> musteriler = List<Firma>();
    if (jsonArray != null) {
      jsonArray.forEach((key, value) => musteriler.add(Firma.fromJson(value)));
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

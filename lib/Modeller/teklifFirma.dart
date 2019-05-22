class TeklifFirma {
  final String firmaID;
  final String firmaUnvan;
  final String firmaIl;
  final String firmaIlce;
  final String tasimaUcretiTam;
  final String firmaAdresi;
  final String firmaPersonelSayisi;
  final String firmaAracSayisi;
  final String firmaKacYildirFaaliyette;
  final String sabitTel;
  final String cepTel;
  final String firmaBelgeler;

  TeklifFirma(
      {this.firmaID,
      this.firmaUnvan,
      this.firmaIl,
      this.firmaIlce,
      this.tasimaUcretiTam,
      this.firmaAdresi,
      this.firmaPersonelSayisi,
      this.firmaAracSayisi,
      this.firmaKacYildirFaaliyette,
      this.sabitTel,
      this.cepTel,
      this.firmaBelgeler});
  factory TeklifFirma.fromJson(Map<String, dynamic> json) {
    return TeklifFirma(
      firmaID: json['FirmaID'],
      firmaUnvan: json['FirmaUnvan'],
      firmaIl: json['FirmaIl'],
      firmaIlce: json['FirmaIlce'],
      tasimaUcretiTam: json['TasimaUcretiTam'],
      firmaAdresi: json['FirmaAdres'],
      firmaPersonelSayisi: json['FirmaPersonelSayisi'],
      firmaAracSayisi: json['FirmaAracSayisi'],
      firmaKacYildirFaaliyette: json['FirmaKacYildirFaaliyette'],
      sabitTel: json['SabitTel'],
      cepTel: json['CepTel'],
      firmaBelgeler: json['FirmaBelgeler'],
    );
  }

  static List<TeklifFirma> fromArray(var jsonArray) {
    List<TeklifFirma> gelenmesajlar = List<TeklifFirma>();
    if (jsonArray != null)
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(TeklifFirma.fromJson(json));
      }
    return gelenmesajlar;
  }
}

class SehirIciFiyat {
  final String id;
  final String firmaID;
  final String evTipi;
  final String varisIl;
  final String varisIlce;
  final String yakitMasrafi;
  final String iscilikUcreti;
  final String asansorBedeli;
  final String firmaKari;
  final String tasimaUcretiTam;

  SehirIciFiyat({this.id, this.evTipi, 
  this.firmaID,
  this.varisIl,
  this.varisIlce,
  this.yakitMasrafi,
  this.iscilikUcreti,
  this.asansorBedeli,
  this.firmaKari,
  this.tasimaUcretiTam,
  });

  factory SehirIciFiyat.fromJson(Map<String, dynamic> json) {
    return SehirIciFiyat(
      id: json['id'],
      firmaID: json['FirmaID'],
      evTipi: json['EvTipi'],
      varisIl: json['VarisIl'],
      varisIlce: json['VarisIlce'],
      yakitMasrafi: json['YakitMasrafi'],
      iscilikUcreti: json['IscilikUcreti'],
      asansorBedeli: json['AsansorBedeli'],
      firmaKari: json['FirmaKari'],
      tasimaUcretiTam: json['TasimaUcretiTam'],
    );
  }

  static List<SehirIciFiyat> fromArray(var jsonArray) {
    List<SehirIciFiyat> gelenmesajlar = List<SehirIciFiyat>();
    if (jsonArray != null) {
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(SehirIciFiyat.fromJson(json));
      }
    }
    return gelenmesajlar;
  }
}

class Arac {
  final String id;
  final String firmaId;
  final String aracModel;
  final String aracAktifmi;
  final String aracPlakasi;
  final String aracMarkasi;

  Arac(
      {this.id,
      this.firmaId,
      this.aracPlakasi,
      this.aracModel,
      this.aracMarkasi,
      this.aracAktifmi});

  factory Arac.fromJson(Map<String, dynamic> json) {
    return Arac(
      id: json['id'],
      firmaId: json['FirmaID'],
      aracPlakasi: json['AracPlakasi'],
      aracModel: json['AracModel'],
      aracMarkasi: json['AracMarka'],
      aracAktifmi: json['AracAktifmi'],
    );
  }

  static List<Arac> fromArray(var jsonArray) {
    List<Arac> gelenmesajlar = List<Arac>();
    if (jsonArray != null) {
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(Arac.fromJson(json));
      }
    }
    return gelenmesajlar;
  }
}

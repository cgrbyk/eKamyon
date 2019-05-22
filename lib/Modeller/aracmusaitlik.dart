class AracMusaitlik {
  final String plaka;
  final String aracAktifmi;
  final DateTime musaitOlduguTarih;

  AracMusaitlik({this.plaka, this.aracAktifmi, this.musaitOlduguTarih});

  factory AracMusaitlik.fromJson(Map<String, dynamic> json) {
    return AracMusaitlik(
      plaka: json['AracPlakasi'],
      aracAktifmi: json['AracAktifmi'],
      musaitOlduguTarih: DateTime.parse(json['MusaitOlduguTarih']),
    );
  }

  static List<AracMusaitlik> fromArray(var jsonArray) {
    List<AracMusaitlik> gelenmesajlar = List<AracMusaitlik>();
    if (jsonArray != null)
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(AracMusaitlik.fromJson(json));
      }
    return gelenmesajlar;
  }
}

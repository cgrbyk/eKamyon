class Fiyat {
  final String varisIl;
  final String evTipi;
  final String tasimaUcretiTam;

  Fiyat({this.evTipi, this.tasimaUcretiTam, this.varisIl});

  factory Fiyat.fromJson(Map<String, dynamic> json) {
    return Fiyat(
      varisIl: json['VarisIl'],
      evTipi: json['EvTipi'],
      tasimaUcretiTam: json['TasimaUcretiTam'],
    );
  }

  static List<Fiyat> fromArray(var jsonArray) {
    List<Fiyat> gelenmesajlar = List<Fiyat>();
    if (jsonArray != null) {
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(Fiyat.fromJson(json));
      }
    }
    return gelenmesajlar;
  }
}

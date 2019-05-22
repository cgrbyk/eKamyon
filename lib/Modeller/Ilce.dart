class Ilce {
  final String ilceAdi;
  final String merkezeuzaklik;

  Ilce({this.ilceAdi, this.merkezeuzaklik});

  factory Ilce.fromJson(Map<String, dynamic> json) {
    return Ilce(
      ilceAdi: json['ilce_adi'],
      merkezeuzaklik: json['MerkezeOlanUzaklik'] ?? "0",
    );
  }

  static List<Ilce> fromArray(var jsonArray) {
    List<Ilce> gelenmesajlar = List<Ilce>();
    if (jsonArray != null)
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(Ilce.fromJson(json));
      }
    return gelenmesajlar;
  }
}

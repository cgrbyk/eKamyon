class Metadata {
  final int id;
  final String metakey;
  final String metavalue;

  Metadata({this.id, this.metakey, this.metavalue});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      id: int.parse(json['ID']),
      metakey: json['meta_key'],
      metavalue: json['meta_value'],
    );
  }

  static List<Metadata> fromArray(var jsonArray) {
    List<Metadata> gelenmesajlar = List<Metadata>();
    for (Map<String, dynamic> json in jsonArray) {
      gelenmesajlar.add(Metadata.fromJson(json));
    }
    return gelenmesajlar;
  }
}

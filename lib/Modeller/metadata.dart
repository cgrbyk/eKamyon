class Metadata {
  final int id;
  final String metakey;
  final String metavalue;

  Metadata({this.id, this.metakey, this.metavalue});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    int uid = 0;
    if (json['ID'] == null) {
      uid = int.parse(json['user_id']);
    } else {
      uid = int.parse(json['ID']);
    }
    return Metadata(
      id: uid,
      metakey: json['meta_key'],
      metavalue: json['meta_value'],
    );
  }

  static List<Metadata> fromArray(var jsonArray) {
    List<Metadata> gelenmesajlar = List<Metadata>();
    if (jsonArray != null)
      for (Map<String, dynamic> json in jsonArray) {
        gelenmesajlar.add(Metadata.fromJson(json));
      }
    return gelenmesajlar;
  }
}

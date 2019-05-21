class EkFiyatlar {
  final int var1;
  final int var2;
  final int var3;
  final int var4;

  EkFiyatlar({this.var1, this.var2, this.var3,this.var4});

  factory EkFiyatlar.fromJson(Map<String, dynamic> json) {
    return EkFiyatlar(
      var1: int.tryParse(json['Var1'].toString()) ?? 0,
      var2: int.tryParse(json['Var2'].toString()) ?? 0,
      var3: int.tryParse(json['Var3'].toString()) ?? 0,
      var4: int.tryParse(json['Var4'].toString()) ?? 0,
    );
  }

  static List<EkFiyatlar> fromArray(var jsonArray) {
    List<EkFiyatlar> gelenmesajlar = List<EkFiyatlar>();
    for (Map<String, dynamic> json in jsonArray) {
      gelenmesajlar.add(EkFiyatlar.fromJson(json));
    }
    return gelenmesajlar;
  }
}

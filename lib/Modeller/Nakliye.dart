class Nakliye {
  final String id;
  final String esyaListesi;
  final String musteriID;
  final String musteriAdi;
  final String eposta;
  final String tasinmaTuru;
  final String tasinmaTarihi;
  final String mevcutIl;
  final String mevcutIlce;
  final String mevcutAdres;
  final String mevcutOda;
  final String mevcutKat;
  final String yukeYaklasma;
  final String nasilTasinacak;
  final String nasilPaketlenecek;
  final String varisIl;
  final String esyaCinsi;
  final String varisIlce;
  final String varisAdres;
  final String varisKat;
  final String sigorta;
  final String tekAracCiftYuk;
  final String olusturmaTarihi;
  final String anlasilanFirmaID;
  final String anlasilanFiyat;
  final String anlasilanTarih;
  final String odemeDurumu;

  Nakliye({
    this.id,
    this.esyaListesi,
    this.musteriID,
    this.musteriAdi,
    this.eposta,
    this.tasinmaTuru,
    this.tasinmaTarihi,
    this.mevcutIl,
    this.mevcutIlce,
    this.mevcutAdres,
    this.mevcutOda,
    this.mevcutKat,
    this.yukeYaklasma,
    this.nasilTasinacak,
    this.nasilPaketlenecek,
    this.varisIl,
    this.esyaCinsi,
    this.varisIlce,
    this.varisAdres,
    this.varisKat,
    this.sigorta,
    this.tekAracCiftYuk,
    this.olusturmaTarihi,
    this.anlasilanFirmaID,
    this.anlasilanFiyat,
    this.anlasilanTarih,
    this.odemeDurumu,
  });

  factory Nakliye.fromJson(Map<String, dynamic> json) {
    return Nakliye(
      id: json['id'],
      esyaListesi: json['EsyaListesi'],
      musteriID: json['MusteriID'],
      musteriAdi: json['MusteriAdi'],
      eposta: json['Eposta'],
      tasinmaTuru: json['TasinmaTuru'],
      tasinmaTarihi: json['TasinmaTarihi'],
      mevcutIl: json['MevcutIl'],
      mevcutIlce: json['MevcutIlce'],
      mevcutAdres: json['MevcutAdres'],
      mevcutOda: json['MevcutOda'],
      mevcutKat: json['MevcutKat'],
      yukeYaklasma: json['YukeYaklasma'],
      nasilTasinacak: json['NasilTasinacak'],
      nasilPaketlenecek: json['NasilPaketlenecek'],
      varisIl: json['VarisIl'],
      esyaCinsi: json['EsyaCinsi'],
      varisIlce: json['VarisIlce'],
      varisAdres: json['VarisAdres'],
      varisKat: json['VarisKat'],
      sigorta: json['Sigorta'],
      tekAracCiftYuk: json['TekAracCiftYuk'],
      olusturmaTarihi: json['OlusturmaTarihi'],
      anlasilanFirmaID: json['AnlasilanFirmaID'],
      anlasilanFiyat: json['AnlasilanFiyat'],
      anlasilanTarih: json['AnlasilanTarih'],
      odemeDurumu: json['OdemeDurumu'] ?? 'Ödenmemiş',
    );
  }

  static List<Nakliye> fromArray(var jsonArray) {
    List<Nakliye> nakliyeler = List<Nakliye>();
    if (jsonArray != null)
      for (Map<String, dynamic> json in jsonArray) {
        nakliyeler.add(Nakliye.fromJson(json));
      }
    return nakliyeler;
  }
}

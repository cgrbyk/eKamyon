import 'package:flutter/material.dart';
import 'database.dart';


class KayitFirma extends StatefulWidget {
  @override
  KayitFirmaEkrani createState() => KayitFirmaEkrani();
}

class KayitFirmaEkrani extends State<KayitFirma> {
  TextEditingController firmayetkiliadController = new TextEditingController();
  TextEditingController firmayetkilisoyadController =
      new TextEditingController();
  TextEditingController tcNoController = new TextEditingController();
  TextEditingController vergiDaireController = new TextEditingController();
  TextEditingController vergiNumaraController = new TextEditingController();
  TextEditingController telNoController = new TextEditingController();
  TextEditingController bankaAdiController = new TextEditingController();
  TextEditingController bankaIbanNoController = new TextEditingController();
  TextEditingController firmaUnvaniController = new TextEditingController();
  TextEditingController firmaIlController = new TextEditingController();
  TextEditingController firmaIlceController = new TextEditingController();
  TextEditingController firmaAdresiController = new TextEditingController();
  TextEditingController postaKoduController = new TextEditingController();
  TextEditingController ePostaAdresController = new TextEditingController();
  TextEditingController firmaWebSitesiController = new TextEditingController();
  TextEditingController kullaniciAdiController = new TextEditingController();
  TextEditingController sifre1Controller = new TextEditingController();
  TextEditingController sifre2Controller = new TextEditingController();

  FocusNode firmayetkiliadFocusNode = new FocusNode();
  FocusNode firmayetkilisoyadFocusNode = new FocusNode();
  FocusNode tcNoFocusNode = new FocusNode();
  FocusNode vergiDaireFocusNode = new FocusNode();
  FocusNode vergiNumaraFocusNode = new FocusNode();
  FocusNode telNoFocusNode = new FocusNode();
  FocusNode bankaAdiFocusNode = new FocusNode();
  FocusNode bankaIbanNoFocusNode = new FocusNode();
  FocusNode firmaUnvaniFocusNode = new FocusNode();
  FocusNode firmaIlFocusNode = new FocusNode();
  FocusNode firmaIlceFocusNode = new FocusNode();
  FocusNode firmaAdresiFocusNode = new FocusNode();
  FocusNode postaKoduFocusNode = new FocusNode();
  FocusNode ePostaAdresFocusNode = new FocusNode();
  FocusNode firmaWebSitesiFocusNode = new FocusNode();
  FocusNode kullaniciAdiFocusNode = new FocusNode();
  FocusNode sifre1FocusNode = new FocusNode();
  FocusNode sifre2FocusNode = new FocusNode();

  bool ischecked = false;
  Database _database = new Database();



void _showPriDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: ListView(
            children: <Widget>[
              new Text(message),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget customTextBox(
      TextInputType type,
      String placeholder,
      TextEditingController controller,
      TextInputAction action,
      FocusNode ownFocus,
      FocusNode tofocus,
      bool password) {
    return TextField(
      focusNode: ownFocus,
      obscureText: password,
      keyboardType: type,
      autofocus: false,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      controller: controller,
      textInputAction: action,
      onSubmitted: (String s) {
        FocusScope.of(context).requestFocus(tofocus);
      },
      style: TextStyle(
          fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Kullanıcı Kayıt'),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Image.asset('images/logoson.png'))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF96beff)),
        child: ListView(
          children: <Widget>[
            customTextBox(
                TextInputType.text,
                "Firma yetkilisi adı",
                firmayetkiliadController,
                TextInputAction.next,
                null,
                firmayetkilisoyadFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma yetkilisi soyadı",
                firmayetkilisoyadController,
                TextInputAction.next,
                firmayetkilisoyadFocusNode,
                tcNoFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Tc numaranız",
                tcNoController,
                TextInputAction.next,
                tcNoFocusNode,
                vergiDaireFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Vergi daire",
                vergiDaireController,
                TextInputAction.next,
                vergiDaireFocusNode,
                vergiNumaraFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Vergi numaranız",
                vergiNumaraController,
                TextInputAction.next,
                vergiNumaraFocusNode,
                telNoFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Telefon numaranız",
                telNoController,
                TextInputAction.next,
                telNoFocusNode,
                bankaAdiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Banka adı",
                bankaAdiController,
                TextInputAction.next,
                bankaAdiFocusNode,
                bankaIbanNoFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Banka Iban numaranız",
                bankaIbanNoController,
                TextInputAction.next,
                bankaIbanNoFocusNode,
                firmaUnvaniFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma Ünvanı",
                firmaUnvaniController,
                TextInputAction.next,
                firmaUnvaniFocusNode,
                firmaIlFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma İl",
                firmaIlController,
                TextInputAction.next,
                firmaIlFocusNode,
                firmaIlceFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma İlçe",
                firmaIlceController,
                TextInputAction.next,
                firmaIlceFocusNode,
                firmaAdresiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma Adresi",
                firmaAdresiController,
                TextInputAction.next,
                firmaAdresiFocusNode,
                postaKoduFocusNode,
                false),
            customTextBox(
                TextInputType.number,
                "Firma posta kodu",
                postaKoduController,
                TextInputAction.next,
                postaKoduFocusNode,
                ePostaAdresFocusNode,
                false),
            customTextBox(
                TextInputType.emailAddress,
                "Firma email adresi",
                ePostaAdresController,
                TextInputAction.next,
                ePostaAdresFocusNode,
                firmaWebSitesiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Firma web sitesi",
                firmaWebSitesiController,
                TextInputAction.next,
                firmaWebSitesiFocusNode,
                kullaniciAdiFocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Kullanıcı Adı oluşturunuz",
                kullaniciAdiController,
                TextInputAction.next,
                kullaniciAdiFocusNode,
                sifre1FocusNode,
                false),
            customTextBox(
                TextInputType.text,
                "Bir şifre oluşturunuz",
                sifre1Controller,
                TextInputAction.next,
                sifre1FocusNode,
                sifre2FocusNode,
                true),
            customTextBox(
                TextInputType.text,
                "Tekrar şifrenizi giriniz",
                sifre2Controller,
                TextInputAction.next,
                sifre2FocusNode,
                new FocusNode(),
                true),
            Center(
              child: FlatButton(
                child: Text("Kullanıcı sözleşmesini buradan okuyabilirsiniz",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                onPressed: () {

                  _showPriDialog("Gizlilik sözleşmesi", "GENEL ŞARTLAR \n" +
                        "\n" +
                        "1-) SÖZLEŞMENİN TARAFLARI : \n" +
                        "\n" +
                        "Taraflardan www.ekamyon.com web sitesi, evden eve eşya taşıma, parça eşya taşıma, ofis taşıma hizmetlerini hızlı, ekonomik ve kaliteli bir şekilde siteye üye olan evden eve nakliyat firmaları ve bireysel nakliyatçılar tarafından sunulan lojistik hizmetlerini bu hizmeti talep eden müşterileri ile online olarak belli ücret (komisyon) karşılığında buluşturan bir internet platformudur. www.ekamyon.com sunduğu yük bulma hizmetinden yararlanmak için ekamyon.com sitesi nakliyeci üyeliği bölümündeki üyelik formunu doldurarak üye olan Nakliyeci, Evden Eve Taşıma vb. sıfatlara sahibi nakliyeciler ‘Taşıyıcı’ olarak anılacaktır, hizmet sağlayıcı ise Taşıyıcılara yük bulmaya yardımcı olan müşteri tarafından web sitesi üzerinden ihale teklifi alan ve bu teklifleri yine www.ekamyon.com web sitesinde yayınlayarak gelen teklifleri müşterinin onaylamasına müteakip ihalesi onaylanan nakliyeyi,evden eve taşımayı vb.hizmetleri ücret (komisyon) karşılığında Taşıyıcıya bildirmekle mükellef olan www.ekamyon.com  ‘ hizmet saglayıcı’ olarak anılacaktır. www.ekamyon.com online web platformu ile nakliyat firmaları ve hizmet talep eden müşteri arasındaki hukuki ilişkiyi düzenlemektedir. Hizmet sunan nakliye ve evden eve taşıma firmaları ile hizmet talep eden kullanıcılar, Başvuru/Kayıt esnasında ilgili bölümleri doldurmak suretiyle işbu sözleşmeyi okuduğunu, kabul ettiğini ve sözleşmeye uymayı taahhüt ettiğini kabul eder. Ekamyon aracılık hizmetlerinin sürekliliğini sağlama ileride doğabilecek teknik zaruret halinde yapılacak sözleşmeyi Taşıyıcının aleyhine olmamak kaydıyla tek taraflı olarak değiştirme veya tadil etme hakkına sahiptir. Sözleşmenin tarafları www.ekamyon.com ve taşıma hizmetleri sunan evden Eve Nakliyat firmaları ve bireysel nakliye işleri yapan nakliyecilerdir.  \n" +
                        "\n" +
                        "2-) SÖZLEŞMENİN KONUSU: \n" +
                        "\n" +
                        "2.a-) Sözleşmenin konusu Taşıyıcı’nın kendisine ait araç/araçlarla www.ekamyon.com web sitesinde müşteri tarafından istenen nakliye isteğini ekamyon’un talimatları doğrultusunda karayolu ile taşınması hususunda tarafların karşılıklı hak ve mükellefiyetlerin belirlenmesidir. \n" +
                        "2.b-) Taşıyıcı, 3. Kişilere ait nakliyat emtiaları ekamyon tarafından bildirilen yükleme adresinden alarak, Ekamyon tarafından bildirilen yere objektif özen yükümlülüğü çerçevesinde taşıyarak teslim edecektir. \n" +
                        "2.c-) Taşıyıcı veya Taşıyıcı firması ve Ekamyon hukuken bağımsız taraflardır. Aralarında ortaklık, temsilcilik veya işçi-işveren ilişkisi yoktur. İşbu Sözleşme'nin onaylanması ve uygulanması sonucunda, ortaklık, temsilcilik veya işçi-işveren ilişkisi doğmamaktadır. \n" +
                        "\n" +
                        "3-) SÖZLEŞMENİN GEÇERLİLİK SÜRESİ:\n" +
                        "\n" +
                        "Taşıma sözleşmesi, Ekamyon ile Taşıyıcı arasında, Taşıyıcının, Ekamyon’a ait web sitesi üzerinde sözleşmeye elektronik ortamda onay vermesi üzerine ve/veya sözleşmeyi imzaladığı tarihten itibaren geçerlilik kazanacaktır. Ancak taşıma sözleşmesi Taşıyıcı yada Ekamyon tarafından feshedilene kadar yürürlükte kalacaktır. \n" +
                        "\n" +
                        "4-) TAŞIYICININ YÜKÜMLÜLÜĞÜ : \n" +
                        "\n" +
                        "4.a-) Ekamyon,  Taşıyıcı’ya taşınacak eşya, mal, ev eşyası taşımasının süresi, hangi şartlarla yapılacağı ve ücret gibi konularda gerekli bilgilendirmeyi taşıma öncesinde Taşıyıcı’nın ekamyon web sitesine kayıt aşamasında bildirdiği telefon, mail, faks ve mesaj yolu ile yapabilir. \n" +
                        "\n" +
                        "4.b-) Ekamyon ve Taşıyıcı arasında ki tüm görüşmelerde Taşıyıcı’nın kendisine ait verdiği bilgiler esas alınacaktır. Taşıyıcı taşıma süresi boyunca telefon ve internet hattını devamlı olarak açık ve çalışır durumda bulundurmayı kabul ve beyan eder. Taşıyıcı bilgilerinde değişikli meydana gelmesi neticesinde bu değişikliği Ekamyon web sitesine giriş yaparak bilgilerini güncellemek zorundadır. Aksi halde taşıma işi ile ilgili taşıma öncesinde kendisine Ekamyon tarafından bilgilendirme yapılmadığı iddiasında bulunamaz\n" +
                        "\n" +
                        "4.c-) Taşıyıcı’nın kendisine web sitesi kaydına ait verdiği bilgilerin değişmesi sonucunda EKAMYON’nun Taşıyıcı’ya ulaşamaması nedeniyle taşıma işinin gecikmesi veya hiç yapılamaması halinde Ekamyon’nun kendisinin ve 3. Kişiler nezdinde uğradığı ve uğrayacağı tüm zararlardan Taşıyıcı’nın sorumluluğundadır.\n" +
                        "\n" +
                        "4.ç-) Ekamyon ve Taşıyıcı aralarında yapılan yazılı sözleşme hükümlerinde belirlenen standartlara uygun araçları tedarik edecektir, tedarik edilen araç yük taşımaya elverişli olmak zorundadır. Taşıyıcı nakliye hizmetini gerçekleştirdiği aracın yük taşımaya elverişsiz olması nedeniyle taşıdığı Ev eşyası, her türlü yüke gelebilecek tüm hasar, kayıp olma ve değiştirilmeden ayrıca Ekamyonun taşınan yük tarafından uğradığı tüm zarardan sorumludur. \n" +
                        "\n" +
                        "4.d-) Ekamyon web sitesine üye olarak hizmet sunmayı taahhüt eden Taşıyıcılar sözleşme ile belirlenen hizmeti vermeye yetkili olduğunu, yasal mevzuatın aradığı tüm belge ve sertifikalara, yetki belgesine ve yasal merciiler tarafından talep edilecek tüm belgelere sahip olduğunu, beyan eder.\n" +
                        "\n" +
                        "4.e-) Firma'nın Ekamyon tarafından sunulan Hizmet'lerden yararlanabilmek amacıyla kullandıkları sisteme erişim araçlarının (Firma ismi, email, şifre v.b.) güvenliği, saklanması, üçüncü kişilerin bilgisinden uzak tutulması ve kullanılması durumlarıyla ilgili hususlar tamamen Taşıyıcı ve firmasının sorumluluğundadır\n" +
                        "4.f-) Taşıyıcı veya Taşıyıcı firması Müşterinin yükü taşıtmaktan vazgeçmesi halinde, bu durumdan ötürü Ekamyon’un hiçbir sorumluluğu ve yükümlülüğü olmayacağını, buradan hareketle herhangi bir tazminat ödenmesini talep etmeyeceğini, beyan ve taahhüt eder. \n" +
                        "\n" +
                        "4.g-) Taşıyıcı Ekamyonun taşıma talimatında belirtmiş olduğu süre içerisinde, belirtilen koşullarda ve zamanda taşımayı gerçekleştirmekle yükümlüdür. Taşıyıcı tarafından taşınan yük, eşya talimatla belirlenen varış yerinde oluşabilecek aksaklıklar nedeniyle yükün indirilememesi halinde Taşıyıcı derhal Ekamyona durumu en ivedi iletişim araçları Telefon, Bilgisayar veya yazılı olarak mümkün olmaması halinde sözlü olarak bildirecek ve Ekamyon’un talimatları doğrultusunda hareket edecektir. \n" +
                        "\n" +
                        "4.ğ-) Taşıyıcı, Ekamyon ile , sözleşmenin imzalanmasından önce sahip olduğu nakliyat araçlarına ait mevzuata uygun olarak Ulaştırma Bakanlığı, Ulaştırması Genel Müdürlüğü tarafından yayımlanan, Karayolu Taşıma Kanunu ve Yönetmeliği’ne uygun yetki belgelerinin birer suretlerini Ekamyon ile onaylanacak sözleşmenin yürürlüğe girmesinden sonra posta yoluyla EKAMYON merkezi olan AŞİTİ MAHALLESİ 9130 Sokak No: 3/B KIZILTEPE MARDİN adresine göndermek zorundadır. \n" +
                        "\n" +
                        "4.h-) Taşıyıcı, sözleşme ile Ekamyon’nun belli bir sayıda taşıma işi garantisinde bulunmadığını kabul eder. EKAMYON, sözleşmenin fesih edilmediği sürece Taşıyıcı’ya istediği sayıda ihale katılmasını için gerekli şartları sağlamayı kabul eder.\n" +
                        "\n" +
                        "4.g-) Taşıyıcı kendi aracı olması durumunda bizzat kendisinin, işletmeye ait araçların olması halinde ise şoförlerinin taşıma işine hâkim, tecrübeli ve 5237 sayılı T.C.K. hükümleri uyarınca herhangi bir suçtan hükümlü olmaması ve Türk yasal mevzuatı uyarınca istenilen vasıflara uygun olması gerekir. \n" +
                        "\n" +
                        "4.ğ-) Taşıyıcı, teslim aldığı yükü sözleşme hükümleri ve Ekamyon’un taşıma talimatıyla belirtilen miktarlarda, belirlenen varma yerlerine ve taşıma süre içerisinde aynen ve bizzat taşımak ve teslim ile mükelleftir. Taşıma süreleri taşıma talimatında belirlenir \n" +
                        "\n" +
                        "4.ı-) Taşıyıcı Ekamyon’nu temsilen yükleme, istifleme ve boşaltma işlemlerinde gördüğü aksaklıkları Ekamyon’a derhal önce sözlü sonra yazılı olarak bildirecektir. Ayrıca Taşıyıcı, ambalajlama/paketlemeye ilişkin tespit ettiği tüm hata ve eksiklikleri Ekamyon’a bildirmekle yükümlüdür. Aksi takdirde Taşıyıcı kendisine oluşabilecek zararın rücu edildiğinde hasarın yükleme, boşaltma, istifleme ve ambalajlama hatasından kaynaklandığı iddiasında bulunamaz. \n" +
                        "\n" +
                        "4.i-) Taşıyıcı taşıma işinin gerçekleşmesinden önce nakliye işini gerçekleştirecek aracın plakasını ve araç şoförünün ismini yazılı olarak Ekamyon’a bildirecektir. Bildirilen araç bilgilerinin veya şoförün bilgilerinde değişiklik olması durumunda yeni aracın bilgilerini de Ekamyon’a yazılı olarak ivedi bildirecektir. Bildirilen araç ve şoförü ihalede belirtilen hususlara riayet ederek talimatlara uymakla yükümlüdür ve Yükün taşınacağı gün ve saatinde yükün yükleneceği adreste bulunacaktır. Aksi halde başka bir firmadan araç ve şoför temin etmek durumunda kalınması halinde Ekamyon’un temin ettiği yeni araç için ödeyeceği ücret, gider, Ekamyon’un uğradığı zararları Taşıyıcıya rucü etme hakkına sahiptir. Taşıyıcı taşıma işinin başlamasından bitişine kadar geçen süre içerisinde taşıma işinden birinci derece sorumludur.  \n" +
                        "\n" +
                        "4.j-) Taşıyıcı taşıma işi için tedarik ettiği aracın, taşımayı işini herhangi bir sebeple tamamlayamaması halinde Taşıyıcı taşıma işinin tamamlanması için derhal yerine aynı kalitede ve özellikte araç tahsis ederek taraflarca belirlenen süre içerisinde taşımayı tamamlayacaktır. Aracın taşıma işini tamamlayamaması halinde Ekamyon taşıyana hiçbir şekilde taşıma ücreti ödenmeyecektir.\n" +
                        "\n" +
                        "4.k-)  Taşıyıcı taşıma işinin birden çok araç ile yapılacak olması halinde Ekamyon’un Taşıyıcıdan talep ettiği sayı ve özelliklerde aracı talep edilen süre içerisinde hazır bulundurmaması halinde, taşıma işinin yapılamaması, taşınacak yükün teslim edilecek adrese tesliminde gecikme olması durumunda Ekamyon Taşıyıcıdan uğradığı tüm zararları tazmin edecektir.\n" +
                        "\n" +
                        "4.l-) Taşıyıcı müşteri tarafından talep edilen taşıma işinin Ekamyon tarafından belirlenen standartlarda yapmaması veya Türkiye Cumhuriyeti Kanunlarında yazılı hususlara aykırı taşıma işi yapması ve Kamu kurum ve kuruluşları tarafından cezai işlem uygulanması halinde Ekamyon’un uğradığı ve uğrayacağı zararlardan Taşıyıcı sorumludur.   \n" +
                        "\n" +
                        "4.m-)  Taşıyıcı üstlendiği taşıma işine başlamadan bütün güvenlik tedbirlerini aldıkta sonra işe başlamalıdır. Taşıma işi esnasında müşteriye ait olan bütün eşyaların araca yüklenmesi sırasında azami özen göstermek zorundadır. Müşteri ile saygılı konuşmalı asla tartışma ya girmemeli her türlü sorun ve sıkıntı halinde ivedi Ekamyon müşteri hizmetlerine bilgi verilerek gerekli önlemlerin alınması sağlayacaktır.\n" +
                        "\n" +
                        "4.n-)  Taşıyıcı sözleşme ile garanti alına alınan yükü hiçbir şekilde 3.Kişi veya kişilere devredemez, ancak zorunlu sebeplerle (Aracın arıza yapması, şoförün rahatsızlanması )  Ekamyon’na taşıma işinden en az 12 saat önce yazlı olarak bildirmesi ve ekamyon müşteri temsilcilerinin uygun bulması halinde taşıma işini devredebilir aksi halde yükümlülüklerini yerine getirmemesi halinde cezai yaptırıma maruz kalacağını kabul eder.\n" +
                        "\n" +
                        "4.o-) Taşıyıcı kullanmış olduğu araçtan veya sürücüden kaynaklanacak her türlü uygun olmayan davranışlardan tamamen kendisi sorumludur. Taşıyıcı tarafından trafik kazaları ve risk içeren her türlü durumu ivedi Ekamyon müşteri hizmetlerine bilgi verecek, ve kazaya karışan aracı ile aracın taşıdığı yükün uğradığı zarar  fotoğraflanarak müşteri temsilcisine gönderilecektir\n" +
                        "\n" +
                        "5- CEZAİ MÜEYİDELER :\n" +
                        "\n" +
                        "5.1-) Taşıyıcı üstlendiği ve taşıyacağını yüke ilişkin olarak  www.ekamyon.com web sitesi üzerinden taşıma işini kabul ettiğini beyan etmesinden sonra taşıma işine en az 24 saat kala vazgeçmesi halinde Taşıyıcı Ekamyon’a taşıma bedelinin %10’u oranında cayma bedeli ödeyecektir.  Taşıyıcı taşınacak yük almak için yola çıktıktan sonra veya yükün bulunduğu adrese geldikten sonra taşıma işinden vazgeçmesi halinde taşıma bedelinin %20’u oranında cayma bedeli ödeyecektir. Ayrıca Taşıyıcıya yükü taşımaması nedeniyle hiçbir şekilde taşıma ücreti ödenmeyecek olup Ekamyon’un uğradığı veya uğrayacağı tüm zararlar yasal mevzuattaki en yüksek faiz oranı üzerinden Taşıyıcı tarafından nakden ve defaten tazmin edilecektir. \n" +
                        "\n" +
                        "5.2-) Taşıyıcı sözleşmede belirlenen yükümlülüklerle bağlı kalacağını taahhüt etmekte olup sözleşmenin herhangi bir maddesini ihlal etmesi halinde Ekamyon’un uğradığı veya uğrayacağı zarar ziyanın tazmini haricinde Ekamyon’a Taşıma işine ait bedelin  %10’nu miktarına karşılık gelecek tutarda nakden ve defaten cezai şart olarak ödemeyi kabul, beyan ve taahhüt eder. \n" +
                        "\n" +
                        "6- ÜCRETLENDİRME :\n" +
                        "\n" +
                        "Ekamyon web sitesi ve mobil app uygulamaları kanalıyla yükün taşınmasına aracılık ettiği işlemlerden Hizmet Bedeli adı altında bir ücret alır. Bu sözleşmenin yapıldığı tarihte Hizmet Bedeli Şehirler arası nakliyat ve Evden Eve Nakliyat, Ofis taşımacılığı ve parça Eşya taşıma İhale Bedelinin %10 (Yüzde on) Şehiriçi ise %5 olarak belirlenmiştir. Taraflar sözleşmeyi imzalamaları halinde bu bedeli kabul ettiğini beyan eder. \n" +
                        "Ekamyon, Taşıyıcı tarafından taşınacak yükün sözleşmedeki şartlarına ve Ekamyon’un talimatlarına uygun şekilde süresinde, tam ve eksiksiz olarak indirileceği adrese ulaştırılması için yükün Taşıyıcının aracına yüklenmesi ve aracın yükü ulaştıracağı adrese hareket etmesi halinde taşıma işine ait sözleşmede yazı tutarın % 20’si aynı gün içerisinde Taşıyıcının hesabına Havale veya EFT yapılarak ödenecektir. Yükün indirileceği adrese ulaşması ve indirilme işleminin sorunsuz ve eşyaların hasarsız bir şekilde indirildiği müşterinin beyanından sonra taşıma işine ait bedelin geriye kalan kısmı yani %80’i Taşıyıcının Ekamyon web sitesine üye olurken yazdığı İBAN ve Hesap numarasına Ekamyon tarafından aynı gün Havale/EFT yapılarak hizmete ait bedel ödenecektir. \n" +
                        "Taşıyıcı, sözleşme kapsamında gerçekleştirdiği taşıma hizmeti karşılığında Ekamyon tarafından belirlenen tutarlar üzerinden fatura tanzim edilecektir. Söz konusu faturalar Ekamyon’un belirlediği kıstaslar çerçevesinde tanzim edilecek ve Taşıyıcının Ekamyon adresine gönderilecek olup bunun dışında fatura talep edilmeyecek ve gönderilmeyecektir\n" +
                        "\n" +
                        "\n" +
                        "SÖZLEŞMENİN FESHİ : \n" +
                        "\n" +
                        "7.1-) Ekamyon sözleşme süresi içerisinde herhangi bir zamanda EKAMYON web sitesi üzerinden ya da Email, SMS ve  diğer yollarla yapacağı yazılı bildirimle sözleşmeyi herhangi bir tazminat ödemeksizin feshedebilecektir. Sözleşmenin bu şekilde feshedilmesi durumunda Taşıyıcı ve Taşıyıcı firması doğrudan veya dolaylı yoldan herhangi bir zarar veya her ne ad altında olursa olsun herhangi bir talepte bulunmayacağını kabul ve beyan eder. \n" +
                        "\n" +
                        "7.2-) Taşıyıcı yasal mevzuattan, teamüllerden kaynaklanan yükümlülüklerini ve/veya sözleşmenin herhangi bir hükmünü kısmen veya tamamen ihlal etmesi veya sözleşmede belirtilen hususları yerine getirmemesi ya da yerine getiremeyecek durumda olması halinde, Ekamyon sözleşmeyi derhal feshetme hakkına sahiptir. Ekamyon sözleşmenin fesih edilmesi halinde uğradığı tüm zararları Taşıcıdan ve firmasından tazmin etmekle yükümlü olacaktır. \n" +
                        "\n" +
                        "Taşıyıcı sözleşme içeriğinde bulunan maddeleri tek tek okuyup anladığını ve sözleşmede yazılı hususlara riayet edeceğini, sözleşmede yazılı hususlara uymaması halinde hakkından cezai yaptırım uygulanacağını kabul eder.\n" +
                        "\n" +
                        "İşbu Sözleşme'nin uygulanmasında, yorumlanmasında ve hükümleri dahilinde doğan hukuki ilişkilerin yönetiminde Türk Hukuku uygulanacaktır. Bu sözleşmeden doğabilecek her türlü ihtilafta Ekamyon internet sitesi üzerinden yapılan email ve tüm yazışmalar, telefon görüşme kayıtları ve cep telefonuna gönderilen SMS bilgilendirme ve kayıtları delil niteliğinde olup, ayrıca Ekamyon defter ve kayıtları kesin delil olarak kabul edilir\n" +
                        " Sözleşmenin ifasından kaynaklanan uyuşmazlıkların çözümünde Mardin Mahkemeleri ve İcra Daireleri münhasıran yetkilidir.");
                

                },
              ),
            ),
            CheckboxListTile(
              value: ischecked,
              onChanged: (bool changestate) {
                setState(() {
                  ischecked = changestate;
                });
              },
              title: Text(
                "Gizlilik sözleşmesini okudum ve kabul ediyorum",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                "Üye olabilmek için gizlilik sözleşmesini kabul etmelisiniz",
                style: TextStyle(fontSize: 10),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.08,
              child: RaisedButton(
                  child: new Text(
                    "Kayıt",
                    textScaleFactor: 2,
                  ),
                  onPressed: () async {
                    //Kullanıcı Kayıt kodu
                    if (tcNoController.text.isEmpty ||
                        vergiDaireController.text.isEmpty ||
                        vergiNumaraController.text.isEmpty ||
                        telNoController.text.isEmpty ||
                        bankaAdiController.text.isEmpty ||
                        bankaIbanNoController.text.isEmpty ||
                        firmaUnvaniController.text.isEmpty ||
                        firmaIlController.text.isEmpty ||
                        firmaIlceController.text.isEmpty ||
                        firmaAdresiController.text.isEmpty ||
                        postaKoduController.text.isEmpty ||
                        ePostaAdresController.text.isEmpty ||
                        firmaWebSitesiController.text.isEmpty ||
                        kullaniciAdiController.text.isEmpty ||
                        sifre1Controller.text.isEmpty ||
                        sifre2Controller.text.isEmpty)
                      _showDialog("Boş alan var",
                          "Kullanıcı kaydı yapabilmek için bütün alanları doldurmanız gerekmektedir.");
                    else {
                      if (sifre1Controller.text != sifre2Controller.text) {
                        _showDialog("Şifreler aynı olmalıdır",
                            "Girmiş olduğunuz şifreler birbiri ile aynı değil lütfen kontrol edin");
                      } else {
                        if (!ischecked)
                          _showDialog("Gizlilik sözleşmesi",
                              "kayıt olmak için gizlilik sözleşmesini kabul etmek zorundasınız");
                        else {
                          bool sonuc = await _database.yeniFirmaEkle(
                              telNoController.text,
                              firmaUnvaniController.text,
                              firmaIlController.text,
                              firmaIlceController.text,
                              firmaAdresiController.text,
                              kullaniciAdiController.text,
                              sifre1Controller.text,
                              ePostaAdresController.text,
                              firmaWebSitesiController.text,
                              firmayetkiliadController.text,
                              firmayetkilisoyadController.text,
                              tcNoController.text,
                              vergiDaireController.text,
                              vergiNumaraController.text,
                              bankaAdiController.text,
                              bankaIbanNoController.text,
                              postaKoduController.text);
                          if (sonuc)
                            _showDialog(
                                "Kayıt Başarılı", "Firma başarıyla kaydedildi");
                          else
                            _showDialog("Kayıt işlemi başarısız",
                                "Zaten böyle bir kullanıcı olabilir");
                        }
                      }
                    }
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            ),
          ],
        ),
      ),
    );
  }
}

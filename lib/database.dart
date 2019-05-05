import 'package:http/http.dart';
import 'dart:convert';

class Database {
   giris(String kulEmail, String kulSifre) async {
    final response = await post("https://www.ekamyon.com/wp-app/login2.php", body: {
      'Email': kulEmail,
      'KullaniciSifresi': kulSifre,
    });    
    var json=jsonDecode(response.body);
    return json;
  }
}
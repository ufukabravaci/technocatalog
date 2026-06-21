import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _url = 'https://fakestoreapi.com/products';

  static Future<List<Product>> fetchProducts() async {
    debugPrint("----- DEBUG: 1. API ISTEGI BASLATILIYOR -----");
    try {
      debugPrint("----- DEBUG: 2. $_url ADRESINE GIDILIYOR -----");
      final response = await http.get(Uri.parse(_url));
      
      debugPrint("----- DEBUG: 3. API'DEN CEVAP GELDİ! Status Kodu: ${response.statusCode} -----");
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        debugPrint("----- DEBUG: 4. BASARILI! TAM ${productsJson.length} ADET URUN CEKILDI -----");
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        debugPrint("----- DEBUG: HATA! Status Code 200 Degil. Body: ${response.body} -----");
        return [];
      }
    } catch (e) {
      debugPrint("----- DEBUG: SISTEMSEL HATA VEYA INTERNET YOK! -----");
      debugPrint("----- HATA DETAYI: $e -----");
      return []; 
    }
  }
}
import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/cart_view.dart';
import 'views/detail_view.dart';
import 'models/product.dart';

void main() {
  runApp(const TechnoCatalogApp());
}

class TechnoCatalogApp extends StatelessWidget {
  const TechnoCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechnoCatalog',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/cart': (context) => const CartView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(builder: (context) => DetailView(product: product));
        }
        return null;
      },
    );
  }
}
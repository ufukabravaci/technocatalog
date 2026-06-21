import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state.dart';

class DetailView extends StatelessWidget {
  final Product product;
  const DetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('Back', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 350, width: double.infinity, color: Colors.grey[50],
                    padding: const EdgeInsets.all(32.0),
                    child: Image.network(product.imageUrl, fit: BoxFit.contain),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(product.category, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text(product.description, style: const TextStyle(color: Colors.black87, height: 1.6, fontSize: 15)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${product.price}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    AppState.cartItems.add(product);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));
                  },
                  child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
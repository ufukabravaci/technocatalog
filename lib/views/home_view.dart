import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../components/product_cart.dart';
import '../state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final products = await ApiService.fetchProducts();
    setState(() {
      allProducts = products;
      filteredProducts = products;
      isLoading = false;
    });
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = allProducts.where((item) => 
        item.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('TechCatalog', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 28),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart').then((_) => setState(() {}));
                  },
                ),
                if (AppState.cartItems.isNotEmpty)
                  Positioned(
                    right: 4, top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text('${AppState.cartItems.length}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Find your perfect device.", style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 16),
                TextField(
                  onChanged: filterProducts,
                  decoration: InputDecoration(
                    hintText: "Search products",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                // PDF'te belirtilen Network Banner [file:5]
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://wantapi.com/assets/banner.png',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 100, color: Colors.blue[50], 
                      alignment: Alignment.center, 
                      child: const Text('GIFT STORE', style: TextStyle(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold))
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.75,
                      crossAxisSpacing: 16, mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: filteredProducts[index]).then((_) => setState(() {}));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
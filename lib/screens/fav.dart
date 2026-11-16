import 'package:donut_app/screens/cart.dart';
import 'package:donut_app/utils/cart_provider.dart';
import 'package:donut_app/utils/cloud_image.dart';
import 'package:donut_app/utils/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fav extends StatelessWidget {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      //Barra del carrito: aparece sola cuando el carrito tiene productos
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.totalItems == 0) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cart.totalItems} items | \$${cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Text(
                          "Delivery charges included",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Cart()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                    ),
                    child: const Text(
                      'View cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: Consumer<FavProvider>(
        builder: (context, fav, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Titulo
                const Text(
                  'Favorites',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                //Lista de favoritos
                Expanded(
                  child: fav.items.isEmpty
                      ? Center(
                          child: Text(
                            'Aún no tienes favoritos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: fav.items.length,
                          itemBuilder: (context, index) {
                            final item = fav.items[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  //Imagen del producto
                                  Container(
                                    width: 72,
                                    height: 72,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.pink[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: CloudImage(item.imagePath),
                                  ),
                                  const SizedBox(width: 12),
                                  //Nombre y precio
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Agregar al carrito
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.grey[700],
                                    ),
                                    onPressed: () {
                                      context.read<CartProvider>().addItem(
                                        name: item.name,
                                        imagePath: item.imagePath,
                                        price: item.price,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${item.name} agregado al carrito',
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                  //Quitar de favoritos
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.pink[400],
                                    ),
                                    onPressed: () => fav.removeItem(item),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:donut_app/utils/cart_provider.dart';
import 'package:donut_app/utils/cloud_image.dart';
import 'package:donut_app/utils/fav_provider.dart';
import 'package:provider/provider.dart';

class BurgerTile extends StatelessWidget {
  final String burgerFlavor;
  final String burgerPrice;
  final dynamic burgerColor;
  final String burgerImagePath;
  final String burgerProvider;

  const BurgerTile({
    super.key,
    required this.burgerFlavor,
    required this.burgerPrice,
    this.burgerColor,
    required this.burgerImagePath,
    required this.burgerProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: burgerColor[100],
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          children: [
            //Etiqueta de precio
            Row(
              //Alinear a la derecha
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 18.0,
                  ),
                  decoration: BoxDecoration(
                    color: burgerColor[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                  ),
                  child: Text(
                    '\$$burgerPrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: burgerColor[800],
                    ),
                  ),
                ),
              ],
            ),
            //Imagen de la Dona
            //Expanded: la imagen se ajusta al espacio libre y evita el desbordamiento
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: CloudImage(burgerImagePath),
              ),
            ),
            //Nombre de la Dona
            Text(
              burgerFlavor,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            //Espacio entre textos
            const SizedBox(height: 4),
            //Nombredel proveedor
            Text(burgerProvider, style: TextStyle(color: Colors.grey[1600])),
            //Espacio entre textos
            //Iconos de fav y carrito
            Padding(
              padding: const EdgeInsetsGeometry.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Corazon: lleno si es favorito, vacio si no
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    style: IconButton.styleFrom(
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      context.watch<FavProvider>().isFavorite(burgerFlavor)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.pink[400],
                    ),
                    onPressed: () {
                      context.read<FavProvider>().toggleFavorite(
                        name: burgerFlavor,
                        imagePath: burgerImagePath,
                        price: double.parse(burgerPrice),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CartProvider>().addItem(
                        name: burgerFlavor,
                        imagePath: burgerImagePath,
                        price: double.parse(burgerPrice),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$burgerFlavor agregado al carrito'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    //Sin relleno extra para que quepa igual que el texto
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.black,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

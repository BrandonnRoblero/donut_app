import 'package:donut_app/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class DonutTab extends StatelessWidget {
  DonutTab({super.key});

  final List donutOnSale = [
    // donutFlavor, donutPrice, donutColor, donutImagePath, donutProvider

    [
      'Chocolate',
      '100',
      Colors.brown,
      "assets/images/chocolate_donut.png",
      'Starbucks',
    ],
    [
      'Strawberry',
      '89',
      Colors.red,
      "assets/images/strawberry_donut.png",
      'Krispy Kreme',
    ],
    [
      'Ice Cream',
      '95',
      Colors.blue,
      "assets/images/icecream_donut.png",
      "Dunkin' Donuts",
    ],
    ['Grape', '70', Colors.purple, "assets/images/grape_donut.png", 'Oxxo'],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //Se encarga de acomodar elementros dentro del grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //TAMAÑO DE LACA COLUMNA
        childAspectRatio: 1 / 1.7,
        //CANTIDAD DE COLUMNAS
        crossAxisCount: 2),
        //CANTIDAD DE PRODUCTOS
        itemCount: donutOnSale.length,
        //Lo que se va a construir
        itemBuilder: (context, index) {
          return DonutTile(
            donutFlavor: donutOnSale[index][0],
            donutPrice: donutOnSale[index][1],
            donutColor: donutOnSale[index][2],
            donutImagePath: donutOnSale[index][3],
            donutProvider: donutOnSale[index][4],
          );
        },
      );
  }
}

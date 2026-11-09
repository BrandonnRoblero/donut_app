import 'package:donut_app/utils/pancake_tile.dart';
import 'package:flutter/material.dart';

class PancakeTab extends StatelessWidget {
  PancakeTab({super.key});

  final List pancakeOnSale = [
    //donutFlavor, donutPrice, donutColor, donutImagePath, donutProvider
    [
      'Cherry Pancake',
      '70',
      Colors.brown,
      "assets/images/cherry.png",
      'Donkin Donuts',
    ],
    [
      'Nutella Tower',
      '95',
      Colors.red,
      "assets/images/pancaketower.gif",
      'Krispy Kreme',
    ],
    ['Pancake', '95', Colors.blue, "assets/images/Pancake.png", "Tim Hortons"],
    [
      'Pancake Tower',
      '70',
      Colors.purple,
      "assets/images/pancaketower.png",
      'Oxxo',
    ],
    [
      'Blueberry Stack',
      '85',
      Colors.indigo,
      "assets/images/blueberry_pancake.png",
      'Pancake House',
    ],
    [
      'Banana Honey',
      '80',
      Colors.amber,
      "assets/images/banana_pancake.png",
      'Morning Stack',
    ],
    [
      'Choco Chips',
      '90',
      Colors.orange,
      "assets/images/choco_pancake.png",
      'Choco Café',
    ],
    [
      'Strawberry Cream',
      '92',
      Colors.pink,
      "assets/images/strawberry_pancake.png",
      'Berry Brunch',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //GirdDelegate, se encarga de Acomodar/distribuir elementos dentro del GRID
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //Tamaño de cada columna relacion 1:1.5 , 1 vale la mitad de 1 y medio
        childAspectRatio: 1 / 1.65,
        //Cantidad de Columnas
        crossAxisCount: 2,
      ),
      //Cantidad de productos
      itemCount: pancakeOnSale.length,
      //Lo que se va a construir
      itemBuilder: (context, index) {
        return PancakeTile(
          pancakeFlavor: pancakeOnSale[index][0],
          pancakePrice: pancakeOnSale[index][1],
          pancakeColor: pancakeOnSale[index][2],
          pancakeImagePath: pancakeOnSale[index][3],
          pancakeProvider: pancakeOnSale[index][4],
        );
      },
    );
  }
}

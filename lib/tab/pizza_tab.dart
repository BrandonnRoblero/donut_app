import 'package:donut_app/utils/pizza_tile.dart';
import 'package:flutter/material.dart';

class PizzaTab extends StatelessWidget {
  PizzaTab({super.key});

  final List pizzaOnSale = [
    //donutFlavor, donutPrice, donutColor, donutImagePath, donutProvider
    ['Pizza', '100', Colors.brown, "assets/images/pizzapep.png", 'Dominos'],
    [
      'Pizza Hawaiana',
      '89',
      Colors.red,
      "assets/images/hawaiana.webp",
      'Pizza Hut',
    ],
    [
      'Pizza Italiana',
      '95',
      Colors.blue,
      "assets/images/Italiana.webp",
      "Don Queso",
    ],
    ['Champizza', '70', Colors.purple, "assets/images/champ.png", 'Messinas'],
    [
      'Pizza Veggie',
      '95',
      Colors.green,
      "assets/images/veggie_pizza.png",
      'Pizza Garden',
    ],
    [
      'Pizza BBQ',
      '110',
      Colors.orange,
      "assets/images/bbq_pizza.png",
      'Smoky Oven',
    ],
    [
      'Cuatro Quesos',
      '105',
      Colors.amber,
      "assets/images/four_cheese_pizza.png",
      'Cheese Lovers',
    ],
    [
      'Pizza Mexicana',
      '99',
      Colors.teal,
      "assets/images/mexicana_pizza.png",
      'La Mexicana',
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
      itemCount: pizzaOnSale.length,
      //Lo que se va a construir
      itemBuilder: (context, index) {
        return PizzaTile(
          pizzaFlavor: pizzaOnSale[index][0],
          pizzaPrice: pizzaOnSale[index][1],
          pizzaColor: pizzaOnSale[index][2],
          pizzaImagePath: pizzaOnSale[index][3],
          pizzaProvider: pizzaOnSale[index][4],
        );
      },
    );
  }
}

import 'package:donut_app/utils/cart_provider.dart';
import 'package:donut_app/utils/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      //La app abre en el Splash (conexión a Firebase) y luego en el Login
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

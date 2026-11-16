import 'package:donut_app/firebase_options.dart';
import 'package:donut_app/screens/home_page.dart';
import 'package:donut_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//Pantalla de carga: conecta la app con Firebase antes de abrir el Login
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      //Conexión con Firebase (usa la configuración de flutterfire configure)
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      if (!mounted) return;
      setState(() => _loading = false);

      //Muestra "Conectado" un momento y luego:
      //si ya hay sesión de Google abre Home, si no abre el Login
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loggedIn ? const HomePage() : const Login(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_loading) {
      //1. Cargando
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Colors.pink[400]),
          const SizedBox(height: 24),
          const Text('Conectando a Firebase...', style: TextStyle(fontSize: 18)),
        ],
      );
    } else if (_error == null) {
      //2. Conectado
      content = const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_done, color: Colors.green, size: 96),
          SizedBox(height: 16),
          Text(
            'Conectado a Firebase',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      );
    } else {
      //3. Error
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, color: Colors.red, size: 96),
          const SizedBox(height: 16),
          const Text(
            'No se pudo conectar a Firebase',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _connect,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[400]),
            child: const Text(
              'Reintentar',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(padding: const EdgeInsets.all(24), child: content),
      ),
    );
  }
}

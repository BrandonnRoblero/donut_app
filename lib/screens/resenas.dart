import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Pantalla de reseñas: formulario + lista en tiempo real (Cloud Firestore)
class Resenas extends StatefulWidget {
  const Resenas({super.key});

  @override
  State<Resenas> createState() => _ResenasState();
}

class _ResenasState extends State<Resenas> {
  //Colección de Firestore donde se guardan las reseñas
  final _resenas = FirebaseFirestore.instance.collection('resenas');

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _textoController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    //El nombre viene lleno con el de la cuenta de Google
    _nombreController.text =
        FirebaseAuth.instance.currentUser?.displayName ?? '';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _textoController.dispose();
    super.dispose();
  }

  //Guarda la reseña en Firestore
  Future<void> _publicar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await _resenas.add({
        'nombre': _nombreController.text.trim(),
        'texto': _textoController.text.trim(),
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'fecha': FieldValue.serverTimestamp(),
      });
      _textoController.clear();
      if (mounted) FocusScope.of(context).unfocus();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo publicar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink.shade100, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink.shade400, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Titulo
            const Text(
              'Reseñas',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            //1. Formulario
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: _inputStyle('Nombre'),
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Escribe tu nombre'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _textoController,
                    decoration: _inputStyle('¿Qué te pareció?'),
                    maxLines: 2,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Escribe tu reseña'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saving ? null : _publicar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _saving
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Publicar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),

            //2. Lista en tiempo real: snapshots() avisa cada vez que cambia algo
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _resenas
                    .orderBy('fecha', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink[400],
                      ),
                    );
                  }
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return Center(
                      child: Text(
                        'Aún no hay reseñas',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data();
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.pink[400],
                              child: Text(
                                (data['nombre'] ?? '?')
                                    .toString()
                                    .characters
                                    .first
                                    .toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['nombre'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(data['texto'] ?? ''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
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

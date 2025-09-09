import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu), // Ícono de menú
          title: const Text('Diagramación'), // Título de la AppBar
          actions: const [
            Icon(Icons.more_vert), // Ícono de more_vert
          ],
        ),
        body: Container(
          height: 570.0, // Altura de 148 píxeles
          width: double.infinity, // Ocupa todo el ancho disponible
          color: Colors.grey, // Color de fondo gris
          child: const Text('Hello World!'), // Texto dentro del Container
        ),
      ),
    );
  }
}

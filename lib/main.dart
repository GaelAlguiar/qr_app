import 'package:flutter/material.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 64, 183, 58)),
        useMaterial3: true,
      ),
      home: const PantallaMenu(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

class PantallaEscaneoQR extends StatelessWidget {
  const PantallaEscaneoQR({super.key});
  @override
  Widget build(context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Escanear QR"),
    );
  }
}

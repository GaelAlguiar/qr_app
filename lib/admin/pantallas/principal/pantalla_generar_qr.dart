import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

class PantallaGenerarQR extends StatelessWidget {
  const PantallaGenerarQR({super.key});
  @override
  Widget build(context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Generar QR"),
    );
  }
}

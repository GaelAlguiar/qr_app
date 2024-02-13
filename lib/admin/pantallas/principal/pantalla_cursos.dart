import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

class PantallaCursos extends StatelessWidget {
  const PantallaCursos({super.key});
  @override
  Widget build(context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Mis Cursos"),
    );
  }
}

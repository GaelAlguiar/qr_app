import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

class InfoSalon extends StatelessWidget {
  final int salonNumber;

  const InfoSalon({Key? key, required this.salonNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Salón $salonNumber',
      ),
      body: Center(
        child: Text('Contenido del salón $salonNumber'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/styles/pantallas/principal/styles.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PantallaEscaneoQr extends StatefulWidget {
  const PantallaEscaneoQr({super.key});

  @override
  State<PantallaEscaneoQr> createState() => _PantallaEscaneoQrState();
}

class _PantallaEscaneoQrState extends State<PantallaEscaneoQr> {
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Escanear QR'),
    );
  }
}

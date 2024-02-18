import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/styles/pantallas/principal/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PantallaGenerarQr extends StatefulWidget {
  const PantallaGenerarQr({super.key});

  @override
  State<PantallaGenerarQr> createState() => _PantallaGenerarQrState();
}

class _PantallaGenerarQrState extends State<PantallaGenerarQr> {
  final TextEditingController _textoControlador =
      TextEditingController(text: '');

  String data = '';

  final GlobalKey _qrKey = GlobalKey();

  bool dirExiste = false;

  dynamic externalDir = '/Storage/emulated/0/Download/';

  Future<void> _captureAndSave() async {
    try {
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var imagen = await boundary.toImage(pixelRatio: 3.0);

      final pinturaBlanca = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromLTWH(
          0,
          0,
          imagen.width.toDouble(),
          imagen.height.toDouble(),
        ),
      );
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          imagen.width.toDouble(),
          imagen.height.toDouble(),
        ),
        pinturaBlanca,
      );
      canvas.drawImage(
        imagen,
        Offset.zero,
        Paint(),
      );
      final foto = recorder.endRecording();

      final img = await foto.toImage(imagen.width, imagen.height);

      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Verificar por nombres de archivos duplicados
      String fileName = 'qr_code';
      int i = 1;

      while (await File('$externalDir/$fileName').exists()) {
        fileName = 'qr_code_$i';
        i++;
      }

      // Checar si la ruta del directorio existe o no
      dirExiste = await File(externalDir).exists();

      if (!dirExiste) {
        await Directory(externalDir).create(recursive: true);
        dirExiste = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;

      const snackBar = SnackBar(
        content: Text('Qr code saved to gallery'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      if (!mounted) return;

      const snackBar = SnackBar(
        content: Text('Algo salio mal'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Generar QR"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TextField(
                controller: _textoControlador,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  labelText: 'Ingrese número de aula',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: RepaintBoundary(
                key: _qrKey,
                child: QrImageView(
                  data: data,
                  version: QrVersions.auto,
                  size: 250,
                  gapless: true,
                  errorStateBuilder: (context, error) {
                    return const Center(
                      child: Text(
                        'Algo salio mal',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      data = _textoControlador.text;
                    });
                  },
                  fillColor: AppColors.primaryColor,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 13,
                  ),
                  child: const Text(
                    'Generar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                RawMaterialButton(
                  onPressed: _captureAndSave,
                  fillColor: AppColors.primaryColor,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 13,
                  ),
                  child: const Text(
                    'Exportar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

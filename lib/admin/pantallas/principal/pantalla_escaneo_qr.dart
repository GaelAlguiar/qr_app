import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_resultados_qr/pantalla_resultados.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PantallaEscaneoQr extends StatefulWidget {
  const PantallaEscaneoQr({super.key});

  @override
  State<PantallaEscaneoQr> createState() => PantallaEscaneoQrState();
}

class PantallaEscaneoQrState extends State<PantallaEscaneoQr> {
  late QRViewController controlador;
  late Barcode resultado;
  bool isCameraActive = false;
  List<Barcode> resultadosEscaneados = [];
  bool mostrarBoton = false;

  @override
  void initState() {
    super.initState();
    resultado = Barcode('', BarcodeFormat.unknown, []);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey qrkey = GlobalKey(debugLabel: 'QR');

    return Scaffold(
      appBar: const CustomAppBar(title: 'Escaneo QR'),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: QRView(
                    key: qrkey,
                    onQRViewCreated: _onQrViewCreated,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: mostrarBoton
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultadosScreen(
                                    resultadosEscaneados: resultadosEscaneados,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 147, 210, 164),
                            ),
                            child: const Text(
                              'Ver resultados',
                              style: TextStyle(
                                color: Color.fromARGB(255, 12, 136, 12),
                                fontSize: 16,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              resultado.format == BarcodeFormat.unknown
                                  ? 'Escanea un código'
                                  : '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onQrViewCreated(QRViewController controlador) {
    this.controlador = controlador;
    controlador.scannedDataStream.listen((scanData) {
      setState(() {
        resultado = scanData;
        resultadosEscaneados.add(resultado);
        mostrarBoton = true;
      });
    });
    if (!isCameraActive) {
      controlador.pauseCamera();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controlador.dispose();
  }
}

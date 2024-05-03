import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_app/admin/model/salon_model.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';


class VerQr extends StatefulWidget {
  final int numSalon;
  const VerQr({super.key, required this.numSalon});

  @override
  State<VerQr> createState() => _VerQrState();
}

class _VerQrState extends State<VerQr> {

  final GlobalKey _qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List salonNumbers =
        context.read<SalonModel>().salonItems.map((salon) => salon[0]).toList();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Consultar QR',
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "QR SALÓN " + widget.numSalon.toString(),
                  style: TextStyle(
                    fontSize: 30, // Tamaño de fuente de 20
                    fontWeight: FontWeight.bold, // Texto en negrita
                  ),
                ),

                const SizedBox(
                  height: 90,
                ),
                Center(
                  child: RepaintBoundary(
                    key: _qrKey,
                    child: QrImageView(
                      data: widget.numSalon.toString(),
                      version: QrVersions.auto,
                      size: 250,
                      gapless: true,
                      errorStateBuilder: (context, error) {
                        return const Center(
                          child: Text(
                            'Algo salió mal',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_app/admin/model/salon_model.dart';
import 'package:qr_app/admin/styles/pantallas/principal/styles.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

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

  @override
  Widget build(BuildContext context) {
    List salonNumbers =
        context.read<SalonModel>().salonItems.map((salon) => salon[0]).toList();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Generar QR',
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: TextField(
                    controller: _textoControlador,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      labelText: 'Ingrese número de aula',
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          int salonNumber =
                              int.tryParse(_textoControlador.text) ?? 0;
                          if (salonNumbers.contains(salonNumber)) {
                            setState(() {
                              data = _textoControlador.text;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Generado exitosamente'),
                                backgroundColor:
                                    Color.fromARGB(255, 42, 189, 23),
                              ));
                            });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Número de salón inválido'),
                              backgroundColor: Color.fromARGB(255, 189, 34, 23),
                            ));
                          }
                        },
                        fillColor: AppColors.primaryColor,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.qr_code_2,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Generar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          int salonNumber =
                              int.tryParse(_textoControlador.text) ?? 0;
                          if (salonNumber != 0) {
                            context
                                .read<SalonModel>()
                                .addItemToList(salonNumber);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Salón añadido exitosamente'),
                              backgroundColor: Color.fromARGB(255, 42, 189, 23),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Número de salón inválido'),
                              backgroundColor: Color.fromARGB(255, 189, 34, 23),
                            ));
                          }
                        },
                        fillColor: AppColors.primaryColor,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.folder_copy_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Añadir',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

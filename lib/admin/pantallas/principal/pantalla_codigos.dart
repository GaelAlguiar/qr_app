import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_generar_qr.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/model/salon_model.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_info_salon.dart';

class PantallaCodigos extends StatefulWidget {
  const PantallaCodigos({Key? key}) : super(key: key);

  @override
  State<PantallaCodigos> createState() => _PantallaCodigosState();
}

class _PantallaCodigosState extends State<PantallaCodigos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Mis códigos',
      ),
      body: Consumer<SalonModel>(
        builder: (context, salonModel, child) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PantallaGenerarQr()),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Generar QR',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Image.asset(
                    'assets/images/logos/logoClases.png',
                    height: 250,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: salonModel.listaSalones.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoSalon(
                                    salonNumber: salonModel.listaSalones[index]
                                        [0],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: salonModel.listaSalones[index]
                                  [2], // Color del salón
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.class_, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  'Salón ${salonModel.listaSalones[index][0]}', // Número del salón
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_generar_qr.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/model/salon_model.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_info_salon.dart';

class PantallaCodigos extends StatefulWidget {
  const PantallaCodigos({super.key});

  @override
  State<PantallaCodigos> createState() => _PantallaCodigosState();
}

class _PantallaCodigosState extends State<PantallaCodigos> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
                    alignment: Alignment.center,
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
                        'Añadir Nuevo Salón QR',
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
                  StreamBuilder<QuerySnapshot>(
                    stream: _firebaseFirestore.collection('salones').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error al obtener los datos: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const Text('No hay documentos disponibles');
                      }
                      List<QueryDocumentSnapshot> salones = snapshot.data!.docs;

                      return Expanded(
                        child: ListView.builder(
                          itemCount: salones.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> salonData = salones[index].data() as Map<String, dynamic>;
                            //Datos de la inspección
                            String salonId  = salones[index].id;
                            int numeroSalon = salonData['numero'];

                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!context.mounted) return;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InfoSalon(
                                                salonNumber: numeroSalon,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto "Salón" hacia arriba
                                          children: [
                                            const Icon(Icons.class_, color: Colors.white),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto "Salón" hacia la izquierda
                                              children: [
                                                Text(
                                                  'Salón '+numeroSalon.toString(),
                                                  style: const TextStyle(color: Colors.white,fontSize: 20,),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            // Acción a realizar cuando se presione el botón
                                          },
                                          icon: const Icon(Icons.delete, color: Colors.black54,),
                                          iconSize: 32,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                          },
                        ),
                      );
                    },
                  ),

/*
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
                  */
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

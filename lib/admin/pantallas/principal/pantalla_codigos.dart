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
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ConfirmDialog(deleteNumSalon: numeroSalon,);
                                              },
                                            );
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class ConfirmDialog extends StatelessWidget {
  final int deleteNumSalon;

  const ConfirmDialog({super.key, required this.deleteNumSalon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar'),
      content: Text('¿Estás seguro de que quieres eliminar el salón ${deleteNumSalon}? Se eliminarán todas sus clases'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            //Eliminiar Detalle
            final QuerySnapshot snapshot = await FirebaseFirestore.instance
                .collection('salon_detalle') // Reemplaza 'tu-coleccion' por el nombre de tu colección
                .where('salon', isEqualTo: deleteNumSalon) // Filtra los documentos donde 'salon' sea igual a 1205
                .get();
            for (final doc in snapshot.docs) {
              await doc.reference.delete();
            }
            //Eliminar Salón
            final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
                .collection('salones') // Reemplaza 'tu-coleccion' por el nombre de tu colección
                .where('numero', isEqualTo: deleteNumSalon) // Filtra los documentos donde 'salon' sea igual a 1205
                .get();
            for (final doc in snapshot2.docs) {
              await doc.reference.delete();
            }
            Navigator.of(context).pop();

          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}




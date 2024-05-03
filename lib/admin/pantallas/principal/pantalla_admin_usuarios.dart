import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_crear_usuario.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_generar_qr.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/model/salon_model.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_info_salon.dart';



class PantallaAdminUsr extends StatefulWidget {
  const PantallaAdminUsr({super.key});

  @override
  State<PantallaAdminUsr> createState() => _PantallaAdminUsrState();
}

class _PantallaAdminUsrState extends State<PantallaAdminUsr> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String correo  = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Usuarios',
      ),
      body: Consumer<SalonModel>(
        builder: (context, salonModel, child) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1, // Flex del texto, ajusta según sea necesario
                        child: Text(
                          "Lista de Usuarios",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,// Tamaño de fuente de 30
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1, // Flex del botón, ajusta según sea necesario
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /*
                            ElevatedButton(
                              onPressed: () {
                                if (!context.mounted) return;
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerQr(
                                      numSalon: widget.salonNumber,
                                    ),
                                  ),
                                );*/
                              },
                              child: Icon(Icons.search),
                            ),*/
                            ElevatedButton(
                              onPressed: () {
                                if (!context.mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PantallaCrearUsr(

                                    ),
                                  ),
                                );
                              },
                              child: Icon(Icons.person_add),
                            ),
                          ],
                        ),

                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firebaseFirestore.collection('userInfo') // Reemplaza 'tu-coleccion' por el nombre de tu colección
                        .where('email', isNotEqualTo: correo) // Filtrar por campo 'email' diferente a 'rioma.mercury'
                        .limit(10).snapshots(),
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
                      List<QueryDocumentSnapshot> users = snapshot.data!.docs;

                      return Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userData = users[index].data() as Map<String, dynamic>;
                            //Datos de la inspección
                            String userId  = users[index].id;
                            String email        = userData['email'];
                            String nombre         = userData['nombre'];
                            String rol      = userData['rol'];

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
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            /*
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ConfirmDialog(deleteUser: userId,);
                                              },
                                            );*/
                                          },
                                          icon: const Icon(Icons.person, color: Colors.white),
                                          iconSize: 32,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!context.mounted) return;
                                          /*
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InfoSalon(
                                                salonNumber: numeroSalon,
                                              ),
                                            ),
                                          );*/
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto "Salón" hacia arriba
                                          children: [

                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto "Salón" hacia la izquierda
                                                children: [
                                                  Text(
                                                    nombre,
                                                    style: const TextStyle(color: Colors.white,fontSize: 18,),
                                                  ),
                                                  Text(
                                                    email,
                                                    style: const TextStyle(color: Colors.white,fontSize: 15,),
                                                  ),
                                                  Text(
                                                    rol.toUpperCase(),
                                                    style: const TextStyle(color: Colors.white,fontSize: 12,),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
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
  final String deleteUser;

  const ConfirmDialog({super.key, required this.deleteUser});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar'),
      content: Text('¿Estás seguro de que quieres eliminar este usuario?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            try {
              await FirebaseFirestore.instance
                  .collection('tu-coleccion')
                  .doc(deleteUser)
                  .delete();
              print('Documento eliminado exitosamente.');
            } catch (error) {
              print('Error al eliminar el documento: $error');
            }
            Navigator.of(context).pop();

          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
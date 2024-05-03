import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_horarioSalon.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_ver_qr.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_crear_horarioTest.dart';

class PantallaCursos extends StatefulWidget {
  PantallaCursos({super.key});
  @override
  _PantallaCursosState createState() => _PantallaCursosState();
}
class _PantallaCursosState extends State<PantallaCursos> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String correo  = FirebaseAuth.instance.currentUser!.email!;
  String condicion = "";
  void initState() {
    super.initState();
    setState(() {
      condicion  = correo;
      print(condicion);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mis cursos ',
      ),
      body: Center(
        child: Column(
          children: [

            StreamBuilder<QuerySnapshot>(
              stream:  _firebaseFirestore.collection('salon_detalle').where("emailMaestro", isEqualTo: condicion).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || condicion == "") {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error al obtener los datos: ${snapshot.error}');
                }
                if (!snapshot.hasData) {

                  return  Text('No hay documentos disponibles');
                }

                List<QueryDocumentSnapshot> horario = snapshot.data!.docs;
                if(horario.isEmpty){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Alinea la columna al centro verticalmente
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "No tienes ningún curso asignado actualmente..." ,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Alinea el texto al centro horizontalmente
                        ),
                      ],
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: horario.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> horarioData = horario[index].data() as Map<String, dynamic>;
                      //Datos del horario
                      String horarioId = horario[index].id;
                      String fecha        = horarioData['fecha'];
                      String hora         = horarioData['hora'];
                      String maestro      = horarioData['maestro'];
                      String materia      = horarioData['materia'];
                      String tema      = horarioData['tema'];
                      int salon           = horarioData['salon'];



                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.class_),
                                iconSize: 32,color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {

                                  if (!context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  horarioSalon(
                                          id: horarioId,
                                          fecha: fecha,
                                          hora: hora,
                                          maestro: maestro,
                                          materia: materia,
                                          numSalon: salon,
                                          tema: tema
                                      ),
                                    ),
                                  );
                                },
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //Text(condicion),
                                      Text(materia, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white,),),
                                      Text(hora, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white,),),
                                      //Text("Fecha estimada: ", style: TextStyle(fontSize: 12),textAlign: TextAlign.left,),
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
  }

}

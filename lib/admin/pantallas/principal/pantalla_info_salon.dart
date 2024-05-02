import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_horarioSalon.dart';
//import 'package:intl/intl.dart';

import 'crete_schedule.dart';

class InfoSalon extends StatefulWidget {
  final int salonNumber;


  InfoSalon({super.key, required this.salonNumber});
  @override
  _InfoSalonState createState() => _InfoSalonState();
}
class _InfoSalonState extends State<InfoSalon> {
  List<String> test = ['L','M','Mi','J','V','S'];
  List<String> _classSchedule = [];

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String condicion = "";
  void initState() {
    super.initState();
    DateTime ahora = DateTime.now();
    List<String> nombresDias = ['L', 'M', 'Mi', 'J', 'V', 'S', 'D'];
    int numeroDiaSemana = ahora.weekday - 1;
    setState(() {
      condicion = nombresDias[numeroDiaSemana];
      print(condicion);

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Salón '+widget.salonNumber.toString(),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1, // Flex del texto, ajusta según sea necesario
                    child: Text(
                      "Horario:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30, // Tamaño de fuente de 30
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1, // Flex del botón, ajusta según sea necesario
                    child: ElevatedButton(
                      onPressed: () {
                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateHora(
                              numeroSalon: widget.salonNumber,
                            ),
                          ),
                        );
                      },
                      child: Text("Añadir nueva clase"),
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(
              height: 100,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.collection('salon_detalle').where("salon", isEqualTo: widget.salonNumber).where("fecha",isEqualTo: condicion).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error al obtener los datos: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Text('No hay documentos disponibles');
                  }
                  List<QueryDocumentSnapshot> horario = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                     //itemExtent: 100,
                      scrollDirection: Axis.horizontal,
                      itemCount: test.length,
                      itemBuilder: (context, index) {
                        String nombre = test[index];


                        return Container(
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [


                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        condicion = nombre;
                                      });
                                      /*
                                          if (!context.mounted) return;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  InspectionScreen(
                                                  inspectionId: inspectionId,
                                                  carName: carName
                                              ),
                                            ),
                                          );*/
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Text(nombre, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                                          Icon(Icons.view_day),
                                          //Text(hora, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                                          //Text("Fecha estimada: ", style: TextStyle(fontSize: 12),textAlign: TextAlign.left,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      },
                    ),
                  );
                },
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream:  _firebaseFirestore.collection('salon_detalle').where("salon", isEqualTo: widget.salonNumber).where("fecha",isEqualTo: condicion).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || condicion == "") {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error al obtener los datos: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No hay documentos disponibles');
                }
                List<QueryDocumentSnapshot> horario = snapshot.data!.docs;

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
                      int salon        = horarioData['salon'];



                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.class_),
                                iconSize: 32,
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
                                           numSalon: salon
                                          ),
                                        ),
                                      );
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(condicion),
                                      Text(materia, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                                      Text(hora, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
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

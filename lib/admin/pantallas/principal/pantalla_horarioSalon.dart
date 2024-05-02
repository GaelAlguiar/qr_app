import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../componentes/Appbar/appbar.dart';

class horarioSalon extends StatelessWidget {
  final String id;
  final String fecha;
  final String hora;
  final String maestro;
  final String materia;
  final int numSalon;
  horarioSalon({super.key,
    required this.id, required this.fecha, required this.hora, required this.maestro, required this.materia, required this.numSalon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Salón '+numSalon.toString()+" Hora: "+ hora,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      QrImageView(
                        data: numSalon.toString(),
                        version: QrVersions.auto,
                        size: 100,
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
                      SizedBox(width: 10,),
                      Text(
                        "Salón: " + numSalon.toString(),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Fecha: "+fecha, style: TextStyle(
                    fontSize: 20,
                  ),),
                      SizedBox(width: 50,),
                      Text("Hora: "+ hora, style: TextStyle(
                        fontSize: 20,
                      ),),
                    ],
                  ),



                  //Text("Id"+id),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Maestro: " + maestro,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          softWrap: true,  // Truncar el texto si se desborda
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Materia: " + materia,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                           // Truncar el texto si se desborda
                          softWrap: true, // Permitir que el texto se divida en varias líneas
                        ),
                      ),
                    ],
                  ),





                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

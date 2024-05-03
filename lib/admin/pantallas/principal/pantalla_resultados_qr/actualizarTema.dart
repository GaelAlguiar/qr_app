import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

class PantallaActualizarTema extends StatefulWidget {
  final String idDetalle;
  PantallaActualizarTema({super.key, required this.idDetalle});
  @override
  State<PantallaActualizarTema> createState() => _PantallaActualizarTema();
}

class _PantallaActualizarTema extends State<PantallaActualizarTema>
{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override


  final _formKey = GlobalKey<FormState>();
  TextEditingController _temaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Actualizar Tema',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [

              TextFormField(
                controller: _temaController,
                keyboardType: TextInputType.text, // Establece el tipo de teclado como email
                decoration: InputDecoration(
                  labelText: 'Actualiza el Tema',
                ),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(

                  onPressed: () async {
                    if (_temaController.text != "" ) {
                      try {
                        await FirebaseFirestore.instance
                            .collection('salon_detalle') // Nombre de la colección
                            .doc(widget.idDetalle) // Referencia al documento con el ID específico
                            .update({'tema': _temaController.text}); // Campo a actualizar y su nuevo valor
                        print('Campo actualizado correctamente.');
                      } catch (error) {
                        print('Error al actualizar el campo: $error');
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);


                    }else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Llena el campo'),
                        backgroundColor: Color.fromARGB(255, 189, 34, 23),
                      ));
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    backgroundColor: Colors.green,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white, // Color del icono blanco
                        ), // Icono de agregar hora
                        SizedBox(width: 8.0), // Espacio entre el icono y el texto
                        Text('Actualizar',style: TextStyle(color: Colors.white),), // Texto del botón
                      ]
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
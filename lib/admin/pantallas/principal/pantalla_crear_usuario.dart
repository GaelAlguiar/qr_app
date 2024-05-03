import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

import '../../../utils/login_google_utils.dart';



class PantallaCrearUsr extends StatefulWidget {
  PantallaCrearUsr({super.key});
  @override
  State<PantallaCrearUsr> createState() => _PantallaCrearUsr();
}

class _PantallaCrearUsr extends State<PantallaCrearUsr>
{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<String> _rolesItems = ['estudiante','profesor']; // Lista vacía para los nombres de los maestros

  @override

  String _selectedRol = 'estudiante';

  final _formKey = GlobalKey<FormState>();
  TextEditingController _correoController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Alta de Usuarios',
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),

                ),
            TextFormField(
              controller: _correoController,
              keyboardType: TextInputType.emailAddress, // Establece el tipo de teclado como email
              decoration: InputDecoration(
                labelText: 'Correo electrónico universitario',
              ),
            ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // Establece el texto como oculto
                  keyboardType: TextInputType.text, // El tipo de teclado predeterminado es adecuado para contraseñas
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),



                SizedBox(height: 20,),
                DropdownButtonFormField(
                  value: _selectedRol,
                  items: _rolesItems.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      _selectedRol = selectedItem!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Selecciona un rol',
                    hintText: 'Selecciona una opción',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(

                    onPressed: () async {
                      if (_nombreController.text != "" || _correoController.text != "") {
                        final data = {
                          "email": _correoController.text,
                          "nombre": _nombreController.text,
                          "rol": _selectedRol,
                        };
                        // Realizar la consulta para buscar documentos con las condiciones especificadas
                        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                            .collection('userInfo') // Reemplaza 'tu-coleccion' por el nombre de tu colección
                            .where('email', isEqualTo: _correoController.text)
                            .get();
                        if(querySnapshot.docs.isEmpty)
                        {
                          await LoginGoogleUtils().createUserWithEmail(_correoController.text, _passwordController.text);
                          _firebaseFirestore.collection("userInfo").add(data)
                              .then((documentReference) {
                            print("Se añadió correctamente. ID del documento: ${documentReference.id}");
                            Navigator.pop(context);

                          })
                              .catchError((error) {
                            print("Ocurrió un error al añadir el documento: $error");
                          });
                        }else
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Ya existe un usuario registrado con este correo'),
                            backgroundColor: Color.fromARGB(255, 189, 34, 23),
                          ));
                        }
                      }else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Escoge Materia'),
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
                          Text('Agregar',style: TextStyle(color: Colors.white),), // Texto del botón
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
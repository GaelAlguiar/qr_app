import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';



class CreateHora extends StatefulWidget {
  final int numeroSalon;
  CreateHora({super.key, required this.numeroSalon});
  @override
  State<CreateHora> createState() => _CreateHora();

}

class _CreateHora extends State<CreateHora>
{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<String> _maestrosITems = ['Seleccione'];
  List<String> _correoMaestros = [];

  @override
  void initState() {
    super.initState();
    // Suscribirse a los cambios en la colección 'userInfo' donde el campo 'rol' es igual a 'profesor'
    _firebaseFirestore
        .collection('userInfo')
        .where("rol", isEqualTo: "profesor")
        .snapshots()
        .listen((querySnapshot) {

      setState(()
      {
        for (var docSnapshot in querySnapshot.docs) {
          var nombre = docSnapshot.data()["nombre"];
          _maestrosITems.add(nombre);
          _correoMaestros.add( docSnapshot.data()["email"]);
        }
      });
    });
  }

  String _selectedMaestro = 'Seleccione';
  String _selectedFecha = 'LMV';
  String _selectedHora = 'M1';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Lista de elementos para el menú desplegable

  List<String> _listaFechas = ['LMV','L','M','Mi','J','V','S'];
  List<String> _listaHoras = [
    'M1','M2','M3','M4','M5','M6',
    'V1','V2','V3','V4','V5',
    'N1', 'N2', 'N3', 'N4','N5','N6'];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Salón ' + widget.numeroSalon.toString(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Materia',
                  ),

                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2, // Establece que acepte múltiples líneas
                  decoration: InputDecoration(
                    labelText: 'Tema',
                  ),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                  value: _selectedMaestro,
                  items: _maestrosITems.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      _selectedMaestro = selectedItem!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Selecciona un maestro',
                    hintText: 'Selecciona una opción',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
                SizedBox(height: 20,),
                //Lista seleccionable de fechas
                DropdownButtonFormField(
                  value: _selectedFecha,
                  items: _listaFechas.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      _selectedFecha = selectedItem!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Selecciona una fecha',
                    hintText: 'Selecciona una opción',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
                SizedBox(height: 20,),
                //Lista de Horas
                DropdownButtonFormField(
                  value: _selectedHora,
                  items: _listaHoras.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      _selectedHora = selectedItem!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Selecciona una hora',
                    hintText: 'Selecciona una opción',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(

                    onPressed: () async {
                      if (_titleController.text != "") {
                        int indexMaestro = _maestrosITems.indexOf(_selectedMaestro);
                        print(indexMaestro);
                        String emailMaestro = _correoMaestros[indexMaestro-1];
                        print(emailMaestro);
                        final data = {
                          "materia": _titleController.text,
                          "maestro": _selectedMaestro,
                          "emailMaestro": emailMaestro,
                          "fecha": _selectedFecha,
                          "hora": _selectedHora,
                          "salon": widget.numeroSalon,
                          "tema": _descriptionController.text,
                        };
                        if(_selectedFecha == "LMV")
                        {
                          final dataL = {
                            "materia": _titleController.text,
                            "maestro": _selectedMaestro,
                            "emailMaestro": emailMaestro,
                            "fecha": "L",
                            "hora": _selectedHora,
                            "salon": widget.numeroSalon,
                            "tema": _descriptionController.text,
                          };
                          final dataMi = {
                            "materia": _titleController.text,
                            "maestro": _selectedMaestro,
                            "emailMaestro": emailMaestro,
                            "fecha": "Mi",
                            "hora": _selectedHora,
                            "salon": widget.numeroSalon,
                            "tema": _descriptionController.text,
                          };
                          final dataV = {
                            "materia": _titleController.text,
                            "maestro": _selectedMaestro,
                            "emailMaestro": emailMaestro,
                            "fecha": "V",
                            "hora": _selectedHora,
                            "salon": widget.numeroSalon,
                            "tema": _descriptionController.text,
                          };
                          _firebaseFirestore.collection("salon_detalle").add(dataL)
                              .then((documentReference) {
                            print("Se añadió correctamente. ID del documento: ${documentReference.id}");

                          })
                              .catchError((error) {
                            print("Ocurrió un error al añadir el documento: $error");
                          });
                          _firebaseFirestore.collection("salon_detalle").add(dataMi)
                              .then((documentReference) {
                            print("Se añadió correctamente. ID del documento: ${documentReference.id}");
                          })
                              .catchError((error) {
                            print("Ocurrió un error al añadir el documento: $error");
                          });
                          _firebaseFirestore.collection("salon_detalle").add(dataV)
                              .then((documentReference) {
                            print("Se añadió correctamente. ID del documento: ${documentReference.id}");
                            Navigator.pop(context);
                          })
                              .catchError((error) {
                            print("Ocurrió un error al añadir el documento: $error");
                          });

                        }else{
                          // Realizar la consulta para buscar documentos con las condiciones especificadas
                          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                              .collection('salon_detalle') // Reemplaza 'tu-coleccion' por el nombre de tu colección
                              .where('salon', isEqualTo: widget.numeroSalon)
                              .where('fecha', isEqualTo: _selectedFecha)
                              .where('hora', isEqualTo: _selectedHora)
                              .get();
                           if(querySnapshot.docs.isEmpty)
                           {
                             _firebaseFirestore.collection("salon_detalle").add(data)
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
                               content: Text('Ya existe una materia asignada en esta hora'),
                               backgroundColor: Color.fromARGB(255, 189, 34, 23),
                             ));
                           }


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
                            Icons.add_alarm,
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
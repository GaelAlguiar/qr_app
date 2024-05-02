import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'e-Fime App',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.green,
          elevation: 0.0,
          centerTitle: true,

          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 37,
                child: IconButton(
                  icon: const Icon( Icons.person ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PerfilPage()),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  //color: Color(0xffF7F8F8),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50), // Espacio entre el borde superior y el texto
            Text(
              'Nombre de usuario',
              style: TextStyle(
                fontSize: 24, // Tamaño del texto
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
            SizedBox(height: 10), // Espacio entre los textos
            Text(
              'Carrera del alumno',
              style: TextStyle(
                fontSize: 18, // Tamaño del texto
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0), // Ajusta este valor para cambiar la posición vertical del botón
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para cerrar sesión
                    },
                    child: Text('Cerrar Sesión'),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
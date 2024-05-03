import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/global_screens/login.dart';
import 'package:qr_app/utils/login_google_utils.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String correo  = FirebaseAuth.instance.currentUser!.email!;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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

          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream:  _firebaseFirestore.collection('userInfo').where("email", isEqualTo: correo).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error al obtener los datos: ${snapshot.error}');
                }
                if (!snapshot.hasData) {

                  return  Text('No hay documentos disponibles');
                }

                List<QueryDocumentSnapshot> user = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: user.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> userData = user[index].data() as Map<String, dynamic>;
                      //Datos del horario
                      String horarioId = user[index].id;
                      String email        = userData['email'];
                      String nombre         = userData['nombre'];
                      String rol      = userData['rol'];




                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            IconButton(
                              icon: ClipRRect(
                                borderRadius: BorderRadius.circular(30), // Ajusta el radio según sea necesario
                                child: Image.asset(
                                  'assets/images/logos/logoFime.png',
                                  height: 200,
                                ),
                              ),
                              onPressed: () {
                                // Tu lógica al presionar el botón aquí
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              nombre,
                              style: TextStyle(
                                fontSize: 24, // Tamaño del texto
                                fontWeight: FontWeight.bold, // Negrita
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 20, // Tamaño del texto
                                fontWeight: FontWeight.bold, // Negrita
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              rol.toUpperCase(),
                              style: TextStyle(
                                fontSize: 18, // Tamaño del texto
                              ),
                            ),
                          ],
                        ),
                      );

                    },
                  ),
                );
              },
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.0), // Ajusta este valor para cambiar la posición vertical del botón
                child: ElevatedButton(
                  onPressed: () async {
                    try{
                      await LoginGoogleUtils().singOutWithEmail();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaLogin(),
                          ),
                              (route) => false
                      );
                    }
                    catch (e)
                    {
                      debugPrint("$e");
                    }
                  },
                  child: Text('Cerrar Sesión'),
                ),
              ),
            ),
          ],
        )
    );
  }
}
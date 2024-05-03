import 'package:flutter/material.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_admin_usuarios.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_escaneo_qr.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_codigos.dart';
import 'package:qr_app/admin/pantallas/principal/user_info.dart';
import 'package:qr_app/utils/login_google_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_app/global_screens/login.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_cursos_profe.dart';

import 'package:qr_app/utils/login_google_utils.dart';

class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(" Menú Principal", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PerfilPage()),
              );

            },
            icon: const Icon(Icons.account_circle, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logos/logoQR.png',
                width: MediaQuery.of(context).size.width * 0.50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 23.0,
                  color: Color.fromARGB(255, 163, 163, 163),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PantallaEscaneoQr(),
                    ),
                  );
                },
                icon: const Icon(Icons.qr_code),
                label: const Text(
                  'Escaneo QR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PantallaCursos(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.class_outlined),
                    SizedBox(width: 10),
                    Text(
                      'Mis cursos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PantallaCodigos()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.grid_view),
                    SizedBox(width: 10),
                    Text(
                      'Mis códigos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PantallaAdminUsr()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      'Usuarios',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

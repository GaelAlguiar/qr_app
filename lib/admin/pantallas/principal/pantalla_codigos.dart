import 'package:flutter/material.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_generar_qr.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';

class PantallaCodigos extends StatefulWidget {
  const PantallaCodigos({super.key});

  @override
  State<PantallaCodigos> createState() => _PantallaCodigosState();
}

class _PantallaCodigosState extends State<PantallaCodigos> {
  List<String> salones = [
    'Salón 1',
    'Salón 2',
    'Salón 3',
    'Salón 4',
    'Salón 5',
    'Salón 6',
    'Salón 7',
    'Salón 8',
    'Salón 9',
    'Salón 10',
  ]; // Lista de salones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Mis códigos',
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PantallaGenerarQR()),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Generar QR',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/images/logos/logoClases.png',
                height: 250,
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: salones.map((salon) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 97, 5, 112),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.class_, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(salon,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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

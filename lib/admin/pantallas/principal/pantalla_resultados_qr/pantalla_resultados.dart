import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultadosScreen extends StatelessWidget {
  final List<Barcode> resultadosEscaneados;

  const ResultadosScreen({Key? key, required this.resultadosEscaneados})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Resultados'),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.builder(
            itemCount: resultadosEscaneados.length,
            itemBuilder: (context, index) {
              final barcode = resultadosEscaneados[0];
              return ListTile(
                title: Text(barcode.code ?? 'Código no disponible'),
              );
            },
          ),
        ),
      ),
    );
  }
}

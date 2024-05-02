import 'package:flutter/material.dart';
import 'package:qr_app/admin/componentes/Appbar/appbar.dart';


class PantallaUsuarios extends StatelessWidget {
  PantallaUsuarios({super.key});
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final matriculaController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Usuarios"),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField
                  (
                   controller: nombreController,
                   validator: (value)
                   {
                     if (value!.isEmpty)
                       return "Obligatorio";
                     return null;
                   },
                   decoration: InputDecoration
                     (
                        labelText: "Nombre"
                     ),
                 ),
                TextFormField
                  (
                  controller: emailController,
                  validator: (value)
                  {
                    if (value!.isEmpty)
                      return "Obligatorio";
                    return null;
                  },
                  decoration: InputDecoration
                    (
                      labelText: "Email"
                  ),
                ),
                TextFormField
                  (
                  controller: matriculaController,
                  validator: (value)
                  {
                    if (value!.isEmpty)
                      return "Obligatorio";
                    return null;
                  },
                  decoration: InputDecoration
                    (
                      labelText: "Matricula"
                  ),
                ),
                TextFormField
                  (
                  controller: passwordController,
                  validator: (value)
                  {
                    if (value!.isEmpty)
                      return "Obligatorio";
                    return null;
                  },
                  decoration: InputDecoration
                    (
                      labelText: "Contraseña"
                  ),
                ),
                TextFormField
                  (
                  //controller: nombreController,
                  validator: (value)
                  {
                    if (value!.isEmpty)
                      return "Obligatorio";
                    return null;
                  },
                  decoration: InputDecoration
                    (
                      labelText: "Repita la contraseña"
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
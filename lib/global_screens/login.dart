import 'package:flutter/material.dart';
import 'package:qr_app/admin/pantallas/principal/custom/custom_button.dart';
import 'package:qr_app/admin/pantallas/principal/custom/custom_geometria.dart';
import 'package:qr_app/admin/pantallas/principal/custom/custom_textform.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_menu.dart';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_app/services/firebase_service.dart';
//Utils for Google Login
import 'package:qr_app/utils/login_google_utils.dart';

// LoginScreen
class PantallaLogin extends StatelessWidget
{
  const PantallaLogin({Key? key}) : super(key: key);

  // Función de inicialización
  void init(BuildContext context) async {
    // Evalúa la condición, por ejemplo, si el usuario ya está logueado
    bool isUserLoggedIn = await LoginGoogleUtils().isUserLoggedIn();
    if (isUserLoggedIn) {
      // Redirige a otra pantalla si el usuario ya está logueado
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PantallaMenu()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                IconButton(
                  icon: Image.asset(
                    'assets/images/logos/logoFimePNG.png',
                    width: 150,
                    height: 150,
                  ),
                  onPressed: () => {},
                ),
                const SizedBox(height: 45),
                Container(
                  height: MediaQuery.of(context).size.height - 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: _LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  class _LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
  }

  class _LoginFormState extends State<_LoginForm> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    final textStyles = Theme.of(context).textTheme;
    return Padding
      (
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Iniciar Sesión',
            style: textStyles.titleLarge,
          ),
          const SizedBox(height: 70),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            controller: username,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            controller: password,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              onPressed: () async {
                try {
                  UserCredential? credentials = await LoginGoogleUtils().loginUserWithEmail(username.text, password.text);
                  if (credentials.user != null)
                  {
                    if (context.mounted)
                    {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaMenu(),
                          ),
                              (route) => false
                      );
                    }
                  }else
                  {
                    print("Hola, mundo!");
                  }
                } catch (e)
                {
                  debugPrint("$e");
                }
                },
            ),
          ),
          const SizedBox(height: 10),

        ],
      ),
    );
  }
}


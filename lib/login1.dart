import 'package:flutter/material.dart';
import 'package:qr_app/admin/pantallas/principal/custom/custom_button.dart';
import 'package:qr_app/admin/pantallas/principal/custom/custom_geometria.dart';
import 'package:qr_app/admin/pantallas/principal/custom/custom_textform.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_menu.dart';
//Firebase
import 'package:firebase_auth/firebase_auth.dart';
//Utils for Google Login
import 'package:qr_app/utils/login_google_utils.dart';

class PantallaLogin extends StatelessWidget {
  const PantallaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return FutureBuilder(
        future: LoginGoogleUtils().isUserLoggedIn(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
    } else
    {
    if (snapshot.data == true)
    {
    //context.go("/Root");
    return Container();
    }else
    {
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
                      // Icon Banner
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
                        height: size.height - 260, // 80 los dos sizebox y 100 el ícono
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: scaffoldBackgroundColor,
                          borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(100)),
                        ),
                        child: _LoginForm(),
                      )
                    ],
                  ),
                ))),
      );
    }
    }
    });


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
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text('Iniciar Sesión', style: textStyles.titleLarge),
          const SizedBox(height: 90),
          CustomTextFormField(
            label: 'Matricula',
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
                buttonColor: Colors.green,
                onPressed: () async {
                  try {
                    UserCredential? credentials = await LoginGoogleUtils()
                        .loginUserWithEmail(username.text, password.text);
                    if (credentials.user != null) {
                      if (context.mounted) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PantallaMenu(),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    debugPrint("$e");
                  }
                },
                /*onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PantallaMenu(),
                    ),
                  );
                },*/
              )),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

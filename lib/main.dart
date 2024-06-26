import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/admin/model/salon_model.dart';
import 'package:qr_app/global_screens/login.dart';
//Importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SalonModel(),
      child: MaterialApp(
        title: 'Qr App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 64, 183, 58)),
          useMaterial3: true,
        ),
        home: const PantallaLogin(),
      ),
    );
  }
}

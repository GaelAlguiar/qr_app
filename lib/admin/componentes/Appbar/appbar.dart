import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/admin/pantallas/principal/pantalla_menu.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 13, 102, 21),
      centerTitle: false,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Container(
        padding: const EdgeInsets.all(1),
        child: Text(
          title,
          style: GoogleFonts.robotoCondensed(
            fontSize: 25.0,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: IconButton(
            icon: Image.asset(
              'assets/images/logos/logoFime.png',
              height: 50,
            ),
            onPressed: () {
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
            },
          ),
        ),
      ],
    );
  }
}

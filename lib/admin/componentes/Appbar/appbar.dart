import 'package:flutter/material.dart';

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
      title: Container(
        padding: const EdgeInsets.all(5),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 21.0,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/images/logos/logoFime.png',
            height: 50,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

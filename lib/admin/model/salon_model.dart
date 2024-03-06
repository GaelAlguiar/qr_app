import 'dart:math';

import 'package:flutter/material.dart';

class SalonModel extends ChangeNotifier {
  final List _salonItems = const [
    // [ Edificio, Piso, Color, StringQr ]
    [4205, 3, Colors.green, ''],
    [2305, 2, Colors.brown, ''],
  ];

  final List _listaSalones = [];

  SalonModel() {
    _listaSalones.addAll(_salonItems);
  }

  List get listaSalones => _listaSalones;

  List get salonItems => _salonItems;

  void addItemToList(int salonNumber) {
    Color randomColor = _generateRandomColor();

    List nuevoSalon = [salonNumber, 0, randomColor, ''];
    _listaSalones.add(nuevoSalon);

    notifyListeners();
  }

  void guardarQR(int index, String qrData) {
    _salonItems[index][3] = qrData;
    notifyListeners();
  }

  Color _generateRandomColor() {
    Random random = Random();
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    return Color.fromARGB(255, red, green, blue);
  }
}

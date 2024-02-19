import 'package:flutter/material.dart';

class SalonModel extends ChangeNotifier {
  final List _salonItems = const [
    // [ Número, Edificio, Color, StringQr ]
    [4205, 3, Colors.green, ''],
    [2305, 2, Colors.brown, ''],
  ];

  final List _listaSalones = [];

  SalonModel() {
    _listaSalones.addAll(_salonItems);
  }

  List get listaSalones => _listaSalones;

  List get salonItems => _salonItems;

  void addItemToList(int index) {
    _listaSalones.add(_salonItems[index]);
    notifyListeners();
  }

  void guardarQR(int index, String qrData) {
    _salonItems[index][3] = qrData;
    notifyListeners();
  }
}

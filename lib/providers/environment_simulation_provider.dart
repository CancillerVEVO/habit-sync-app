import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnvironmentSimulationProvider with ChangeNotifier {
  DateTime _currentDate = DateTime.parse('2024-09-14'); // DateTime.parse uses yyyy-MM-dd format

  String get currentDate => DateFormat('yyyy/MM/dd').format(_currentDate); // Use yyyy/MM/dd format

  void incrementDate() {
    _currentDate = _currentDate.add(Duration(days: 1));
    notifyListeners();
  }

  void subtractDate() {
    _currentDate = _currentDate.subtract(Duration(days: 1));
    notifyListeners();
  }

  // Método que retorna una fecha modificada sin alterar el _currentDate
  String getModifiedDate({int days = 0}) {
    DateTime modifiedDate = _currentDate.add(Duration(days: days));
    return DateFormat('yyyy/MM/dd').format(modifiedDate);
  }
}

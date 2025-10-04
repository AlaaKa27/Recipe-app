import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier {
  int _currentNumber = 1;
  List<double> _baseIngredientAmounts = [];
  int get currenNumber => _currentNumber;
  //set initial ing Amuont
  // ignore: non_constant_identifier_names
  void SetBaseIngredientAmounts(List<double> amounts) {
    _baseIngredientAmounts = amounts;
    notifyListeners();
  }

  // update ingredient
  List<String> get updaetAmounts {
    return _baseIngredientAmounts
        .map<String>((amount) => (amount * _currentNumber).toStringAsFixed(1))
        .toList();
  }

  // increse servings
  void increaseQuantity() {
    _currentNumber++;
    notifyListeners();
  }

  // decrease servings
  void decreaseQuantity() {
    if (_currentNumber > 1) {
      _currentNumber--;
      notifyListeners();
    }
  }
}

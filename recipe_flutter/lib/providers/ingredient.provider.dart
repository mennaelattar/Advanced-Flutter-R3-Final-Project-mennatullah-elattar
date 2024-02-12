import 'dart:ffi';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter/models/ingredient.model.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredientList;
  List<Ingredient>? get ingredientList => _ingredientList;

  CarouselController? buttonCarouselController;
  int currentIndexPage = 0;

  void providerInit() {
    buttonCarouselController = CarouselController();
  }

  void providerDispose() {
    buttonCarouselController = null;
  }

  Future<void> getIngredients() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('ingredients').get();
      if (result.docs.isNotEmpty) {
        _ingredientList = List<Ingredient>.from(result.docs.map(
            (document) => Ingredient.fromJson(document.data(), document.id)));
      } else {
        _ingredientList = [];
      }
      notifyListeners();
    } catch (e) {
      _ingredientList = [];
      notifyListeners();
    }
  }
}

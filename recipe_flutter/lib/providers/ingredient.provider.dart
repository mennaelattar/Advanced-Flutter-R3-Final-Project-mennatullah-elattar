import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter/models/ingredient.model.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredientList;
  List<Ingredient>? get ingredientList => _ingredientList;

  void providerInit() {}

  void providerDispose() {}

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

  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "user_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "user_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }

      notifyListeners();
    } catch (e) {
      _ingredientList = [];
      notifyListeners();
    }
  }
}

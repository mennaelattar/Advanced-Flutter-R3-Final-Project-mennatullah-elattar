import 'dart:ffi';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter/models/recipie.model.dart';
import 'package:recipe_flutter/pages/single_recipe/index.dart';

class RecipesProvider extends ChangeNotifier {
  List<Recipe>? _recipeList;
  List<Recipe>? get recipeList => _recipeList;

  bool? isPressed;
  String? recipeId;

  void providerInit() {
    isPressed = false;
    recipeId = "";
  }

  void providerDispose() {
    isPressed = null;
    recipeId = null;
  }

  Future<void> getTodayFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where("is_today", isEqualTo: true)
          .limit(3)
          .get();
      if (result.docs.isNotEmpty) {
        _recipeList = List<Recipe>.from(result.docs
            .map((document) => Recipe.fromJson(document.data(), document.id)));
      } else {
        _recipeList = [];
      }
      notifyListeners();
    } catch (e) {
      _recipeList = [];
      notifyListeners();
    }
  }

  void addToFaviourateList(bool isPressed, String recipeId) {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (isPressed) {
      FirebaseFirestore.instance.collection('recipes').doc(recipeId).update({
        'favourite_user_ids': FieldValue.arrayUnion([currentUserId])
      });
    } else {
      FirebaseFirestore.instance.collection('recipes').doc(recipeId).update({
        'favourite_user_ids': FieldValue.arrayRemove([currentUserId])
      });
    }
    notifyListeners();
  }

  void getSingleRecipeData(BuildContext context, String recipe_id) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      Navigator.push(context, MaterialPageRoute(builder: (__) {
        return SingleRecipePage(
          recipeId: recipe_id,
        );
      }));
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}

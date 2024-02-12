import 'dart:ffi';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter/models/ad.model.dart';

class AdsProvider extends ChangeNotifier {
  List<Ad>? _adList;
  List<Ad>? get adList => _adList;

  CarouselController? buttonCarouselController;
  int currentIndexPage = 0;

  void providerInit() {
    buttonCarouselController = CarouselController();
  }

  void providerDispose() {
    buttonCarouselController = null;
  }

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ads')
          .where("is_active", isEqualTo: true)
          .get();
      if (result.docs.isNotEmpty) {
        _adList = List<Ad>.from(result.docs
            .map((document) => Ad.fromJson(document.data(), document.id)));
      } else {
        _adList = [];
      }
      notifyListeners();
    } catch (e) {
      _adList = [];
      notifyListeners();
    }
  }
}

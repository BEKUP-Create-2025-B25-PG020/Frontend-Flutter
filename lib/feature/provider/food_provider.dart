import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mantra_application/common/static/food_list_result_state.dart';
import 'package:mantra_application/core/data/model/food.dart';
import 'package:mantra_application/core/data/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodProvider extends ChangeNotifier {
  final HttpService httpService;
  FoodListResultState _state = FoodListNoneState();
  FoodListResultState get state => _state;

  FoodProvider({required this.httpService}) {
    loadCachedData();
    fetchFoods();
  }

  /// Loads locally cached food list if available.
  Future<void> loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString('cached_foods');
    if (cachedJson != null) {
      try {
        final cachedList = (jsonDecode(cachedJson) as List)
            .map((e) => Food.fromJson(e))
            .toList();

        _state = FoodListLoadedState(cachedList);
        notifyListeners();
      } catch (e) {
        debugPrint("Error decoding cached foods: $e");
      }
    }
  }

  Future<void> fetchFoods() async {
    if (_state is! FoodListLoadedState) {
      _state = FoodListLoadingState();
      notifyListeners();
    }

    try {
      final response = await httpService.getFoodList();
      _state = FoodListLoadedState(response.data);
      notifyListeners();

      // Step 3: save the new list to cache
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'cached_foods',
        jsonEncode(response.data.map((f) => f.toJson()).toList()),
      );
    } catch (e) {
      // Step 4: gracefully handle failure
      _state = FoodListErrorState(e.toString());
      notifyListeners();
    }
  }

  List<Food> get foods {
    if (_state is FoodListLoadedState) {
      return (_state as FoodListLoadedState).data;
    }
    return [];
  }
}

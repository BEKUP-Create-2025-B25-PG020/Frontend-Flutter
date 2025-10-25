import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:mantra_application/common/static/food_list_result_state.dart';
import 'package:mantra_application/core/data/model/food.dart';
import 'package:mantra_application/core/data/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeaturedFoodProvider extends ChangeNotifier {
  final HttpService httpService;
  FoodListResultState _state = FoodListNoneState();
  FoodListResultState get state => _state;

  FeaturedFoodProvider({required this.httpService}) {
    loadCachedData();
    fetchFeaturedFoods(limit: 5);
  }

  Future<void> loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString('cached_featured_foods');
    if (cachedJson != null) {
      try {
        final cachedList = (jsonDecode(cachedJson) as List)
            .map((e) => Food.fromJson(e))
            .toList();
        _state = FoodListLoadedState(cachedList);
        notifyListeners();
      } catch (_) {
        // Ignore cache error
      }
    }
  }

  Future<void> fetchFeaturedFoods({int limit = 5}) async {
    _state = FoodListLoadingState();
    notifyListeners();

    try {
      final response = await httpService.getFeaturedFoods(limit: limit);
      _state = FoodListLoadedState(response.data);

      // Save to cache
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'cached_featured_foods',
        jsonEncode(response.data.map((f) => f.toJson()).toList()),
      );
    } catch (e) {
      _state = FoodListErrorState(e.toString());
    }

    notifyListeners();
  }
}

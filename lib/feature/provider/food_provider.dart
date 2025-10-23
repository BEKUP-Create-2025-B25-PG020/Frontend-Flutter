import 'package:flutter/material.dart';
import 'package:mantra_application/common/static/food_list_result_state.dart';
import 'package:mantra_application/core/data/model/food.dart';
import 'package:mantra_application/core/data/service/http_service.dart';

class FoodProvider extends ChangeNotifier {
  final HttpService httpService;
  FoodListResultState _state = FoodListNoneState();

  FoodListResultState get state => _state;

  FoodProvider({required this.httpService});

  Future<void> fetchFoods() async {
    _state = FoodListLoadingState();
    notifyListeners();

    try {
      final response = await httpService.getFoodList();
      _state = FoodListLoadedState(response.data);
    } catch (e) {
      _state = FoodListErrorState(e.toString());
    }

    notifyListeners();
  }

  List<Food> get foods {
    if (_state is FoodListLoadedState) {
      return (_state as FoodListLoadedState).data;
    }
    return [];
  }
}

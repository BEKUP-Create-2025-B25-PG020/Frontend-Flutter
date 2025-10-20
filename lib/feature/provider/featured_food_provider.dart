import 'package:flutter/widgets.dart';
import 'package:mantra_application/common/static/food_list_result_state.dart';
import 'package:mantra_application/core/data/service/http_service.dart';

class FeaturedFoodProvider extends ChangeNotifier {
  final HttpService httpService;
  FoodListResultState _state = FoodListNoneState();

  FoodListResultState get state => _state;

  FeaturedFoodProvider({required this.httpService});

  Future<void> fetchFeaturedFoods({int limit = 1}) async {
    _state = FoodListLoadingState();
    notifyListeners();

    try {
      final response = await httpService.getFeaturedFoods(limit: limit);
      _state = FoodListLoadedState(response.data);
    } catch (e) {
      _state = FoodListErrorState(e.toString());
    }

    notifyListeners();
  }
}

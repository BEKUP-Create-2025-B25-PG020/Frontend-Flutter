import 'package:flutter/widgets.dart';
import 'package:mantra_application/common/static/food_detail_result_state.dart';
import 'package:mantra_application/core/data/service/http_service.dart';

class FoodDetailProvider extends ChangeNotifier {
  final HttpService httpService;
  FoodDetailResultState _state = FoodDetailNoneState();

  FoodDetailResultState get state => _state;

  FoodDetailProvider({required this.httpService});

  Future<void> fetchDetailFood(int id) async {
    _state = FoodDetailLoadingState();
    notifyListeners();

    try {
      final response = await httpService.getDetailFood(id);
      _state = FoodDetailLoadedState(response.data);
    } catch (e) {
      _state = FoodDetailErrorState(e.toString());
    }

    notifyListeners();
  }
}

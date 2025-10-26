import 'package:flutter/widgets.dart';
import 'package:mantra_application/common/static/food_detail_result_state.dart';
import 'package:mantra_application/core/data/model/food_detail.dart';
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

  Future<void> likeOrUnlikeFood(int foodId, bool isCurrentlyLiked) async {
    if (_state is! FoodDetailLoadedState) return;

    try {
      final response = isCurrentlyLiked
          ? await httpService.unlikeFood(foodId)
          : await httpService.likeFood(foodId);

      final currentFood = (_state as FoodDetailLoadedState).data;

      final updatedFood = FoodDetail(
        id: currentFood.id,
        name: currentFood.name,
        shortDescription: currentFood.shortDescription,
        longDescription: currentFood.longDescription,
        foodHistory: currentFood.foodHistory,
        interestingFacts: currentFood.interestingFacts,
        mainImageUrl: currentFood.mainImageUrl,
        isFeatured: currentFood.isFeatured,
        region: currentFood.region,
        category: currentFood.category,
        likesCount: response.data.likesCount,
        galleries: currentFood.galleries,
      );
      _state = FoodDetailLoadedState(updatedFood);
      notifyListeners();
    } catch (e) {
      _state = FoodDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}

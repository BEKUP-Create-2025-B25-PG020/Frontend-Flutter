import 'package:flutter/widgets.dart';
import 'package:mantra_application/core/data/service/http_service.dart';

class FoodLikeProvider extends ChangeNotifier {
  final HttpService httpService;

  bool isLiked = false;
  int likeCount = 0;

  FoodLikeProvider({required this.httpService});

  Future<void> toggleLike(int foodId) async {
    try {
      if (isLiked) {
        final response = await httpService.unlikeFood(foodId);
        likeCount = response.data.likesCount;
        isLiked = false;
      } else {
        final response = await httpService.likeFood(foodId);
        likeCount = response.data.likesCount;
        isLiked = true;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

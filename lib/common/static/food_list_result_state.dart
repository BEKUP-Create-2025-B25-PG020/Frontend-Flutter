import 'package:mantra_application/core/data/model/food.dart';

sealed class FoodListResultState {}

class FoodListNoneState extends FoodListResultState {}

class FoodListLoadingState extends FoodListResultState {}

class FoodListErrorState extends FoodListResultState {
  final String error;

  FoodListErrorState(this.error);
}

class FoodListLoadedState extends FoodListResultState {
  final List<Food> data;

  FoodListLoadedState(this.data);
}

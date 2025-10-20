import 'package:mantra_application/core/data/model/food_detail.dart';

sealed class FoodDetailResultState {}

class FoodDetailNoneState extends FoodDetailResultState {}

class FoodDetailLoadingState extends FoodDetailResultState {}

class FoodDetailErrorState extends FoodDetailResultState {
  final String error;

  FoodDetailErrorState(this.error);
}

class FoodDetailLoadedState extends FoodDetailResultState {
  final List<FoodDetail> data;

  FoodDetailLoadedState(this.data);
}

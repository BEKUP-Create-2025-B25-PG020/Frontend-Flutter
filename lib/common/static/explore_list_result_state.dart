import 'package:mantra_application/core/data/model/food.dart';

sealed class ExploreListResultState {}

class ExploreListNoneState extends ExploreListResultState {}

class ExploreListLoadingState extends ExploreListResultState {}

class ExploreListErrorState extends ExploreListResultState {
  final String error;

  ExploreListErrorState(this.error);
}

class ExploreListLoadedState extends ExploreListResultState {
  final List<Food> data;

  ExploreListLoadedState(this.data);
}

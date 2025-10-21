import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mantra_application/core/data/service/http_service.dart';
import 'package:mantra_application/common/static/explore_list_result_state.dart';

class ExploreListProvider extends ChangeNotifier {
  final HttpService httpServices;

  ExploreListProvider(this.httpServices);

  ExploreListResultState _resultState = ExploreListNoneState();
  ExploreListResultState get resultState => _resultState;

  Future<void> fetchExploreList() async {
    _resultState = ExploreListLoadingState();
    notifyListeners();

    try {
      final result = await httpServices.getFoodList();

      if (result.data.isEmpty) {
        _resultState = ExploreListErrorState("Data kosong");
      } else {
        _resultState = ExploreListLoadedState(result.data);
      }
    } on Exception catch (e) {
      _resultState = ExploreListErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}

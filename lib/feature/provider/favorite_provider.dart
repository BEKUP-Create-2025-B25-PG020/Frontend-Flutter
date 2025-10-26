import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  Set<int> _favorites = {};
  Set<int> get favorites => _favorites;

  FavoriteProvider() {
    // Automatically load favorites when the provider is first created
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    _favorites = favList.map(int.parse).toSet();
    notifyListeners();
  }

  bool isFavorite(int id) => _favorites.contains(id);

  Future<void> toggleFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    await prefs.setStringList(
      'favorites',
      _favorites.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }
}

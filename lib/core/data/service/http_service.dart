import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mantra_application/core/data/response/food_detail_response.dart';
import 'package:mantra_application/core/data/response/food_response.dart';

class HttpService {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? "";
  final String _apiKey = dotenv.env['API_KEY'] ?? "";

  Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "api_key": dotenv.env["API_KEY"] ?? "",
  };

  Future<FoodResponse> getFoodList() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/foods"),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      return FoodResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load food list');
    }
  }

  Future<FoodDetailResponse> getDetailFood(int id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/foods/$id"),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      return FoodDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load food detail');
    }
  }

  Future<FoodResponse> getFeaturedFoods({int limit = 1}) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}foods/featured?limit=$limit"),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      return FoodResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load featured foods');
    }
  }
}

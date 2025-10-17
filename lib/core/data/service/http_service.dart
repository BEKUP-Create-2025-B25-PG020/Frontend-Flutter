import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mantra_application/core/data/response/food_detail_response.dart';
import 'package:mantra_application/core/data/response/food_response.dart';

class HttpService {
  static const String _baseUrl = "https://mantra.aerossky.com/api/v1/";

  Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "api_key": dotenv.env["API_KEY"] ?? "",
  };

  Future<FoodResponse> getFoodList() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/foods"),
      headers: _headers,
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
      headers: _headers,
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
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return FoodResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load featured foods');
    }
  }
}

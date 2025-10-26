import 'package:mantra_application/core/data/model/food.dart';

class FoodResponse {
  final bool success;
  final String message;
  final List<Food> data;

  FoodResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    return FoodResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? List<Food>.from(json["data"]!.map((x) => Food.fromJson(x)))
          : <Food>[],
    );
  }
}

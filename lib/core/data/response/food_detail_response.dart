import 'package:mantra_application/core/data/model/food_detail.dart';

class FoodDetailResponse {
  final bool success;
  final String message;
  final FoodDetail data;

  FoodDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FoodDetailResponse.fromJson(Map<String, dynamic> json) {
    return FoodDetailResponse(
      success: json["success"],
      message: json["message"],
      data: FoodDetail.fromJson(json["data"]),
    );
  }
}

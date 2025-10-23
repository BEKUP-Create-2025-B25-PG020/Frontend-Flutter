import 'package:mantra_application/core/data/model/like_data.dart';

class FoodLikeResponse {
  final bool success;
  final String message;
  final LikeData data;

  FoodLikeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FoodLikeResponse.fromJson(Map<String, dynamic> json) {
    return FoodLikeResponse(
      success: json["success"],
      message: json["message"],
      data: LikeData.fromJson(json["data"]),
    );
  }
}

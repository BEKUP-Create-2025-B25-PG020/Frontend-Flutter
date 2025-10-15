import 'package:mantra_application/core/data/model/category.dart';
import 'package:mantra_application/core/data/model/food.dart';
import 'package:mantra_application/core/data/model/gallery.dart';
import 'package:mantra_application/core/data/model/region.dart';

class FoodDetail extends Food {
  String longDescription;
  String foodHistory;
  String interestingFacts;
  int likesCount;
  List<Gallery> galleries;

  FoodDetail({
    required super.id,
    required super.name,
    required super.shortDescription,
    required this.longDescription,
    required this.foodHistory,
    required this.interestingFacts,
    required super.mainImageUrl,
    required super.region,
    required super.category,
    required this.likesCount,
    required this.galleries,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    return FoodDetail(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      foodHistory: json['food_history'],
      interestingFacts: json['interesting_facts'],
      mainImageUrl: json['main_image_url'],
      region: Region.fromJson(json["region"]),
      category: Category.fromJson(json["category"]),
      likesCount: json['likes_count'],
      galleries: List<Gallery>.from(
        json["galleries"].map((x) => Gallery.fromJson(x)),
      ),
    );
  }
}

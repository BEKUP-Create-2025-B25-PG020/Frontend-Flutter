import 'package:mantra_application/core/data/model/category.dart';
import 'package:mantra_application/core/data/model/region.dart';

class Food {
  int id;
  String name;
  String shortDescription;
  String mainImageUrl;
  Region region;
  Category category;

  Food({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.mainImageUrl,
    required this.region,
    required this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      region: Region.fromJson(json["region"]),
      category: Category.fromJson(json["category"]),
      mainImageUrl: json['main_image_url'],
    );
  }
}

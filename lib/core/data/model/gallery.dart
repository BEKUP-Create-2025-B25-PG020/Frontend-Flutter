class Gallery {
  int id;
  int foodId;
  String imageUrl;
  bool mainPhoto;

  Gallery({
    required this.id,
    required this.foodId,
    required this.imageUrl,
    required this.mainPhoto,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'],
      foodId: json['food_id'],
      imageUrl: json['image_url'],
      mainPhoto: json['main_photo'],
    );
  }
}

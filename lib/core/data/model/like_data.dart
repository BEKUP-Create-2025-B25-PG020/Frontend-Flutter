class LikeData {
  final int likesCount;

  LikeData({required this.likesCount});

  factory LikeData.fromJson(Map<String, dynamic> json) {
    return LikeData(likesCount: json["likes_count"] ?? 0);
  }
}

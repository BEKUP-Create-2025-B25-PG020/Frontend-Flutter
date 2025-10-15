class Region {
  int id;
  String regionName;
  String regencyCity;
  String province;
  String island;

  Region({
    required this.id,
    required this.regionName,
    required this.regencyCity,
    required this.province,
    required this.island,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    regionName: json["region_name"],
    regencyCity: json["regency_city"],
    province: json["province"],
    island: json["island"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_name": regionName,
    "regency_city": regencyCity,
    "province": province,
    "island": island,
  };
}

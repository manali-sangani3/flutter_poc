class ShopModel {
  final int id;
  final String title;
  final String thumbnail;

  ShopModel({required this.id, required this.title, required this.thumbnail});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }
}

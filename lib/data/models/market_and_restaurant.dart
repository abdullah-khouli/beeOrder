import 'dart:convert';

class RestaurantAndMarktModel {
  final String coverPhotoUrl;
  final String id;
  final String timeToDeliver;
  final String logoUrl;
  final String name;
  final String? type;
  final String? deliveryFee;
  final String isOnline;
  bool isFavorite;

  RestaurantAndMarktModel({
    required this.id,
    required this.coverPhotoUrl,
    required this.timeToDeliver,
    required this.logoUrl,
    required this.name,
    required this.type,
    required this.deliveryFee,
    required this.isOnline,
    this.isFavorite = false, //الحالة الافتراضية لاي منتج هو انه ليس مفضل
  });

  Map<String, dynamic> toMap() {
    return {
      'coverPhotoUrl': coverPhotoUrl,
      'id': id,
      'timeToDeliver': timeToDeliver,
      'logoUrl': logoUrl,
      'name': name,
      'type': type,
      'deliveryFee': deliveryFee,
      'isOpen': isOnline,
      'isFavorite': isFavorite,
    };
  }

  factory RestaurantAndMarktModel.fromMap(Map<String, dynamic> map) {
    return RestaurantAndMarktModel(
      coverPhotoUrl: map['coverPhotoUrl'] ?? '',
      id: map['id'] ?? '',
      timeToDeliver: map['timeToDeliver'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      name: map['name'] ?? '',
      type: map['type'],
      deliveryFee: map['deliveryFee'],
      isOnline: map['isOpen'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantAndMarktModel.fromJson(String source) =>
      RestaurantAndMarktModel.fromMap(json.decode(source));
}

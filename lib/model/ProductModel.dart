import 'dart:convert';

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Object? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> obj) {
    return ProductModel(
        id: obj['id'],
        title: obj['title'],
        price: obj['price'],
        description: obj['description'],
        category: obj['category'],
        image: obj['image'],
        rating: obj['rating']);
  }
}

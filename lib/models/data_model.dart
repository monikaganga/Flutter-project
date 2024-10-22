// data_model.dart
class DataModel {
  List<Product>? products; // A list to hold the products

  DataModel({this.products}); // Constructor

  // Factory method to create a DataModel from JSON
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      products: List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)), // Map JSON to Product
      ),
    );
  }
}

class Product {
  int? id; // Product ID
  String? title; // Product title
  double? price; // Product price
  String? thumbnail; // Product image URL

  Product({this.id, this.title, this.price, this.thumbnail}); // Constructor

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'], // Map the ID
      title: json['title'], // Map the title
      price: json['price'].toDouble(), // Map the price (ensure it's a double)
      thumbnail: json['thumbnail'], // Map the thumbnail URL
    );
  }
}

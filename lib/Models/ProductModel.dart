

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? name;
  double? price;
  String? id;

  ProductModel({
    this.name,
    this.price,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json["name"],
    price: json["price"],
    id: json["id"],
  );

  factory ProductModel.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data=doc.data() as Map<String,dynamic>;
    data["id"]=doc.id;
    return ProductModel.fromJson(data);
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "id": id,
  };
}

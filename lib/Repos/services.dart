import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductRepository{
  final instance =FirebaseFirestore.instance.collection("products");

  Future<dynamic> createProduct(Map<String, dynamic> data) async{
    try{
      final result=await instance.add(data);
      return result;
    }catch(e){
      print(e);
    }
  }
  Future<List<dynamic>> fetchAllProducts() async{
    try{
      final result=(await instance.get()).docs;
      return result;
    }catch(e){
      return [];
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository{

  final instance = FirebaseFirestore.instance.collection("product");

  Future<dynamic> createProduct(Map<String, dynamic> data) async {
    try{
      final result = await instance.add(data);
      return result;
    }catch(error){
      print(error);
    }
    return null;
  }

  Future<List<dynamic>> fetchProduct() async {
    try{
      final result = (await instance.get()).docs;
      return result;
    }catch(error){
      print(error);
    }
    return [];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSnapshot() {
    final result = instance.snapshots();
    return result;
  }

  Future<dynamic> fetchOneProduct(String id) async {
    try{
      final result = await instance.doc(id).get();
      return result.data();
    }catch(error){
      print(error);
    }
    return null;
  }

  Future<bool> deleteProduct(String id) async {
    try{
      final result = await instance.doc(id).delete();
    }catch(error){
      print(error);
      rethrow;
    }
    return false;
  }

  Future<bool> updateProduct(Map<String, dynamic> data, String id) async {
    try{
      print(id);
      final result = await instance.doc(id).set(data);
      return true;
    }catch(error){
      print(error);
      rethrow;
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kryssna/services/FirebaseService.dart';

import '../Models/ProductModel.dart';

class ProductRepository{

  final instance = FirebaseService.db.collection("product")
  .withConverter(fromFirestore: (snapshot,_){
    return ProductModel.fromFirebaseSnapshot(snapshot);
  }, toFirestore:(ProductModel model,_)=>model.toJson() );

  Future<dynamic> createProduct(ProductModel data) async {
    try{
      final result = await instance.add(data);
      return result;
    }catch(error){
      print(error);
    }
    return null;
  }

  Future<List<QueryDocumentSnapshot<ProductModel>>> fetchAllProduct() async {
    try{
      final result = (await instance.get()).docs;
      return result;
    }catch(error){
      print(error);
    }
    return [];
  }

  Stream<QuerySnapshot<ProductModel>> fetchSnapshot() {
    final result = instance.snapshots();
    return result;
  }

  Future<ProductModel?> fetchOneProduct(String id) async {
    try{
      final result = await instance.doc(id).get();
      return result.data();
    }catch(error){
      print(error);
    }
    return ProductModel();
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

  Future<bool> updateProduct(ProductModel data, String id) async {
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
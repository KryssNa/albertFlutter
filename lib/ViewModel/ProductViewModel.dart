import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/ProductModel.dart';
import '../Repos/productRepositery.dart';

class ProductViewModel with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  List<QueryDocumentSnapshot<ProductModel>> _productdata = [];
  List<QueryDocumentSnapshot<ProductModel>> get productdata => _productdata;


  Future<void> fetch() async {
    try {
      final getData = await ProductRepository().fetchAllProduct();
      _productdata = getData;
      notifyListeners();
    } catch (e) {
      print(e);
       }
  }

  // Future<void> delete(String id) async {
  //   try {
  //     await ProductRepository().deleteProduct(id);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product deleted")));
  //     fetch();
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
  //   }
  // }
  //
  // void signOut() async {
  //   try {
  //     final user = await _auth.signOut();
  //     Navigator.of(context).popAndPushNamed("/login");
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Lougout Success"),
  //       backgroundColor: Colors.green,
  //     ));
  //   } on FirebaseAuthException catch (err) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(err.message.toString()),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }
}
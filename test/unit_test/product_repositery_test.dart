
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kryssna/Models/ProductModel.dart';
import 'package:kryssna/Repos/productRepositery.dart';
import 'package:kryssna/services/FirebaseService.dart';

Future<void> main() async {
 FirebaseService.db=FakeFirebaseFirestore();

 final ProductRepository productRepository = ProductRepository();

 test("Test to create product",() async{
   final respose = await productRepository.createProduct(ProductModel(
     name: "Test Product",
     price: 25.0,
   ));
   final data = await respose.get();
   final actual = data
       .data()
       .name
       .toString();
   final expected = "Test Product";
   expect(actual, expected);
 });

 test("Test to get one product",() async{
   final response=await productRepository.fetchOneProduct("test");
    final actual = response;
    final expected = "test";
    expect(actual, expected);

 });



}
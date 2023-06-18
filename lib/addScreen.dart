
import 'package:flutter/material.dart';
import 'package:kryssna/Models/ProductModel.dart';

import 'Repos/productRepositery.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController _productName = new TextEditingController();
  TextEditingController _productDescription = new TextEditingController();
  TextEditingController _productPrice = new TextEditingController();

  Future<void> save() async{
    try{
      ProductModel data = new ProductModel(
        name: _productName.text,
        price:double.parse(_productPrice.text),
      );
      await ProductRepository().createProduct(data);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Saved")));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Screen"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(controller: _productName, decoration: InputDecoration(label: Text("Product Name")),),
            TextFormField(controller: _productDescription, maxLines: 5, decoration: InputDecoration(label: Text("Product Description")),),
            TextFormField(controller: _productPrice, decoration: InputDecoration(label: Text("Product Price")),),

            ElevatedButton(onPressed: (){
              save();
            }, child: Text("Save Product"))
          ],
        ),
      ),
    );
  }
}
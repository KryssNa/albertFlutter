
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kryssna/Models/ProductModel.dart';

import 'Repos/productRepositery.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {


  TextEditingController _productName = new TextEditingController();
  TextEditingController _productDescription = new TextEditingController();
  TextEditingController _productPrice = new TextEditingController();

  Future<void> update() async{
    try{
      ProductModel productModel = new ProductModel(
        name: _productName.text,
        price:double.parse(_productPrice.text),
      );
      await ProductRepository().updateProduct(productModel, _id);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Updated")));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }

  }

  String _id = "";
  dynamic data;
  Future<void> fetchOneData(String id) async{
    try{
      final response = await ProductRepository().fetchOneProduct(id);
      setState(() {
        _id = id;
        data = response;
      });

      _productName.text = response.name.toString();
      _productPrice.text = response.price.toString();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if(arguments !=null){
        fetchOneData(arguments.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Screen"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(controller: _productName, decoration: InputDecoration(label: Text("Product Name")),),
            TextFormField(controller: _productDescription, maxLines: 5, decoration: InputDecoration(label: Text("Product Description")),),
            TextFormField(controller: _productPrice, decoration: InputDecoration(label: Text("Product Price")),),

            ElevatedButton(onPressed: (){
              update();
            }, child: Text("Update Product"))
          ],
        ),
      ),
    );
  }
}
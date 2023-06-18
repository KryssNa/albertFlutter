import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kryssna/Models/ProductModel.dart';
import 'package:kryssna/ViewModel/ProductViewModel.dart';
import 'package:provider/provider.dart';
import 'Repos/productRepositery.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List<QueryDocumentSnapshot<ProductModel>> productdata = [];

  Future<void> fetchDataFromViewModel() async {
    try {
      final getData = await productViewModel.fetch();

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }

  Future<void> delete(String id) async {
    try {
      await ProductRepository().deleteProduct(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product deleted")));
      fetchDataFromViewModel();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }

  void signOut() async {
    try {
      final user = await _auth.signOut();
      Navigator.of(context).popAndPushNamed("/login");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Lougout Success"),
        backgroundColor: Colors.green,
      ));
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
  late ProductViewModel productViewModel;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productViewModel=Provider.of<ProductViewModel>(context,listen: false);
    });
    fetchDataFromViewModel();
    super.initState();
  }

  void _showDialog(String id){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure you want to delete this product?"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Delete")),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
            delete(id);
            // _showDialog(e.id);
          }, child: Text("Cancel")),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context,prouctVM,child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
            actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/add-screen");
            },
            child: Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          fetchDataFromViewModel();
                        },
                        child: Text("Refresh")),
                    Column(
                      children: [
                        Text(prouctVM.productdata.length.toString(), style: TextStyle(fontSize: 20)),

                        Text(" Data Found", style: TextStyle(fontSize: 20)),
                      ],
                    )
                  ],
                ),

                ...prouctVM.productdata.map((e) => Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(e.data().name.toString()),
                            Text("Rs. ${e.data().price.toString()}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/update-screen", arguments: e.id);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  delete(e.id);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      }
    );
  }
}
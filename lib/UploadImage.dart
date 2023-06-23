import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  Future<void> _pickimage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final selected =await _picker.pickImage(source: source,imageQuality: 100);
    if(selected ==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image Selected")));
      return;
    }
    setState(() {
      image = File(selected.path);

    });
    print(selected.path);
  }
  Future<void> _uploadImage() async{
    try{
      if(image == null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image Selected")));
        return;
      }
      // await ProductRepository().uploadImage(image!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image Uploaded")));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body:Column(
        children:[
          ElevatedButton(onPressed: (){
            _pickimage(ImageSource.camera);
          }, child: Icon(Icons.camera_alt)),
          ElevatedButton(onPressed: (){
            _pickimage(ImageSource.gallery);
          }, child: Icon(Icons.photo)),

        ]
      )
    );
  }
}

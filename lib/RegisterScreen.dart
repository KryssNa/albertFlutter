import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureTextPassword = true;
  bool _obscureTextPasswordConfirm = true;

  String _uid = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void register() async {
    try {
      await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Register Success"),
        backgroundColor: Colors.green,
      ));

      Navigator.of(context).popAndPushNamed("/login");
      
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/640px-Instagram_logo_2022.svg.png",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      final RegExp emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if(value == null || value.isEmpty ){
                        return "Email is required";
                      }
                      if(!emailValid.hasMatch(value)){
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: 'Email Address',
                      hintStyle:
                      TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureTextPassword,
                    validator: (String? value){
                      if(value == null || value.isEmpty ){
                        return "Password is required";
                      }
                      if(value.length < 8){
                        return "Password should be at least 8 character";
                      }
                      if(_confirmPasswordController.text != value){
                        return "Please make sure both the password are the same";
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPassword = !_obscureTextPassword;
                          });
                        },
                        child: Icon(
                          _obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureTextPasswordConfirm,
                    validator: (String? value){
                      if(value == null || value.isEmpty ){
                        return "Password is required";
                      }
                      if(value.length < 8){
                        return "Password should be at least 8 character";
                      }
                      if(_passwordController.text != value){
                        return "Please make sure both the password are the same";
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_clock,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                          fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextPasswordConfirm = !_obscureTextPasswordConfirm;
                          });
                        },
                        child: Icon(
                          _obscureTextPasswordConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.blue)
                              )
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 20)),
                        ),
                        onPressed: (){
                          register();
                        }, child: Text("Sign Up", style: TextStyle(
                        fontSize: 20
                    ),)),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(
                          color: Colors.grey.shade800
                      ),),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Text("Sign in", style: TextStyle(color: Colors.blue),))
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

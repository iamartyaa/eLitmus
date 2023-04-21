// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pirate_hunt/model/user_model.dart';
import 'package:pirate_hunt/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  
  static const routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  final _auth =  FirebaseAuth.instance; 
  @override
  Widget build(BuildContext context) {

    final userNameField = TextFormField(
      autofocus: false,
      controller: userNameController,
      validator: (value) {
        RegExp regex = new RegExp(r'.{6,}$');

        if (value!.isEmpty) {
          return ("Please enter a Username!");
        }

        if (!regex.hasMatch(value)) {
          return ('Please enter a valid Username! Min. 6 characters!');
        }
      },
      keyboardType: TextInputType.name,
      onSaved: (val) {
        userNameController.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email!");
        }
        // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
        //   return ("Please enter a valid email!");
        // }
        return null;
      },
      onSaved: (val) {
        emailController.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email Address",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'.{6,}$');

        if (value!.isEmpty) {
          return ("Please enter a password!");
        }

        if (!regex.hasMatch(value)) {
          return ('Please enter a valid Password! Min. 6 characters!');
        }
      },
      onSaved: (val) {
        passwordController.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmPasswordController,
      // validator: (value) {
      //   if(confirmPasswordController.text.length>6 && passwordController.text != value){
      //     return ("Password doesn't match!");
      //   }
      //   return null;
      // },
      
      onSaved: (val) {
        confirmPasswordController.text = val!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final signUpButton = Material(
      elevation: 5,
      color: Colors.red,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: const Text(
          'SignUp',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back,color: Colors.red,),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      userNameField,
                      const SizedBox(
                        height: 15,
                      ),
                      emailField,
                      const SizedBox(
                        height: 15,
                      ),
                      passwordField,
                      const SizedBox(
                        height: 15,
                      ),
                      confirmPasswordField,
                      const SizedBox(
                        height: 25,
                      ),
                      signUpButton,
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> signUp(String email, String password) async {
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore(),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.msg);
      });
    }
  }

  postDetailsToFirestore( ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid ;
    userModel.userName = userNameController.text;
    userModel.score = 0;

    await firebaseFirestore.collection("users").doc(user.uid)
    .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully!");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>  const HomeScreen()), (route) => false);
  }
}

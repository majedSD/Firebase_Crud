import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/Authentication/sign_up_screen.dart';
import 'package:frebase_crud/Cloud_Firestore/firebase_crud_screen.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Future<void> SignInAuthentication() async {
    await firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTEController.text, password: passwordTEController.text)
        .then((value) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Sign In',
          message: 'Sign in successfull',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Get.to(const FirebaseCrudAppScreen());
    }).onError((error, stackTrace) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'failed',
          message: 'Sign in failed',
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in Screen"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailTEController,
                  decoration: InputDecoration(
                      hintText: 'Enter Your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  validator: Validator,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: passwordTEController,
                  validator: Validator,
                  decoration: InputDecoration(
                      hintText: 'Enter Your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SignInAuthentication();
                      }
                    },
                    child: const Text('Sign in')),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(const SignUpScreen());
                    },
                    child: const Text('Sign up'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? Validator(value) {
    if (value!.isEmpty) {
      return 'Enter the valid value';
    }
    return null;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Future<void> SignUpAuthentication() async {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailTEController.text, password: passwordTEController.text)
        .then((value) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Sign up',
          message: 'Sign up successfull',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }).onError((error, stackTrace) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'failed',
          message: 'Sign up failed',
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
        title: const Text("Sign up Screen"),
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
                  validator: Validator,
                  decoration: InputDecoration(
                      hintText: 'Enter Your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
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
                        SignUpAuthentication();
                      }
                    },
                    child: const Text('Sign Up'))
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
  }
}

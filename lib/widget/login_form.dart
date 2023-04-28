

import 'package:casino_v2/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }

}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final dio = Dio();

  void validateForm() async {
    if (_formKey.currentState!.validate()) {
      var response = await dio.post("https://fake-casino.shrp.dev/auth/login", data: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      print(response.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Form(
      key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: Column(
                children: [
                  TextFormField(controller: emailController, decoration: const InputDecoration(labelText: "Enter Your Email",icon: Icon(Icons.email)),),
                  TextFormField(controller: passwordController, decoration: const InputDecoration(labelText: "Enter Your Username",icon: Icon(Icons.person)),),
                  ]
                ),
              ),
            Column(
              children: [
                ElevatedButton(onPressed: validateForm, child: const Text("Envoyer"),),
              ],
            )
            
          ]
        ),
      )
    );
  }
}
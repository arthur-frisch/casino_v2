import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }

}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final dio = Dio();

  void validateForm() async {
    if (_formKey.currentState!.validate()) {
      await dio.post("https://fake-casino.shrp.dev/users", data: {
        "email": emailController.text,
        "password": passwordController.text,
        "external_identifier": userNameController.text,
        "role": "3324c71c-5c60-4998-9ba4-73dc8af5449d"
      });
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
                  TextFormField(controller: userNameController, decoration: const InputDecoration(labelText: "Enter Your Username",icon: Icon(Icons.person)),),
                  TextFormField(controller: passwordController, decoration: const InputDecoration(labelText: "Enter Your Password",icon: Icon(Icons.lock)),),
                  TextFormField(controller: confirmedPasswordController, decoration: const InputDecoration(labelText: "Confirm Your Password",icon: Icon(Icons.lock)),),
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
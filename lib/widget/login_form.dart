import 'package:casino_v2/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/token_storage.dart';

final storageService = StorageService();

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

  void validateForm(TokenModel tokenModel) async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await dio.post("https://fake-casino.shrp.dev/auth/login", data: {
          "email": emailController.text,
          "password": passwordController.text,
        });
        storageService.writeSecureData(StorageItem("access_token", response.data["data"]["access_token"]));
        storageService.writeSecureData(StorageItem("expires", "${response.data["data"]["expires"]}"));
        storageService.writeSecureData(StorageItem("refresh_token", response.data["data"]["refresh_token"]));
        tokenModel.storageService = storageService;
      } catch (error) {
        print(error);
      }
      
    }
  }

  void test(TokenModel tokenModel) async {
    Map<String, dynamic> test = await tokenModel.storageService.readAll();
    print(test["refresh_token"]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TokenModel(),
      child: Consumer<TokenModel>(
        builder: (context, model, child) => Center(child: Form(
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
                  ElevatedButton(onPressed: () => validateForm(model), child: const Text("Envoyer"),),
                  ElevatedButton(onPressed: () => context.go('/'), child: const Text("Créer un compte"),),
                  ElevatedButton(onPressed: () async => test(model), child: const Text("tetstzytdfzyt"))
                ],
              )     
            ]
          ),
        )
      ) 
      ),
    );  
  }
}
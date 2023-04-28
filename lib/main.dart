import 'package:casino_v2/game.dart';
import 'package:casino_v2/login.dart';
import 'package:casino_v2/models/token_storage.dart';
import 'package:casino_v2/providers/token.dart';
import 'package:casino_v2/widget/register_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/game',
      builder: (context, state) => const Game(), 
    ),
  ],
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<String> isLogin(TokenModel model) async {
    return "${await model.storageService.readSecureData("access_token")}";
  }  

  void logOut(BuildContext context, TokenModel model) {
    model.storageService = StorageService(); // Reset des tokens;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TokenModel(),
      child: Consumer<TokenModel>(
        builder: (context, model, child) =>Scaffold(
          appBar: AppBar(
          title: const Text("Création du compte"),
        ),
        body: 
          Column(children: [
            const RegisterForm(), 
            FutureBuilder<String>(
              future: isLogin(TokenModel()),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  // Si token
                  if (snapshot.data?.isNotEmpty == true && snapshot.data != "null") {
                    return Column(children: [
                        ElevatedButton(onPressed: () => context.go('/game'), child: const Text("Accueil")),
                        ElevatedButton(onPressed: () => logOut(context, model), child: const Text("Se déconnecter"))
                      ]
                    );
                  } else {
                    return Column(
                      children: [
                        ElevatedButton(onPressed: () => context.go('/login'), child: const Text("Se connecter")), 
                      ],
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              }
            )
          ],
        )
      )
    )
    );
  }
}

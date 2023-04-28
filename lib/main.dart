import 'package:casino_v2/game.dart';
import 'package:casino_v2/login.dart';
import 'package:casino_v2/widget/register_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, state) => const Game(), )
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Création du compte"),
      ),
      body: 
        Column(children: [
          const RegisterForm(), 
          ElevatedButton(onPressed: () => context.go('/login'), child: const Text("Se connecter"),),
          ElevatedButton(onPressed: () => context.go('/game'), child: const Text("Voir son token"),),
        ],
      )
    );
  }
}

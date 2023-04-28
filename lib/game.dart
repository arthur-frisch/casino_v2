import 'package:casino_v2/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  Future<String> getToken(TokenModel model) async {
    try {
      // DIRTY
      return "${await model.storageService.readSecureData("access_token")}";
    } catch(err) {
      return "$err";
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TokenModel(),
      child: Consumer<TokenModel>(
        builder: (context, model, child) => 
        Scaffold(
          appBar: AppBar(
            title: const Text("C'est le jeu ici"),
          ),
          body: Center(
            child:
              Column(
                children: [
                  FutureBuilder<String>(
                    future: getToken(model),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Erreur : ${snapshot.error}');
                        } else {
                          return Text("Tu es connecté : ${snapshot.data}");
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  ElevatedButton(onPressed: () => context.go('/'), child: const Text("Retourner à l'accueil"),),
                ],
              ),
            ),
          ),
      )
    );
  }
}
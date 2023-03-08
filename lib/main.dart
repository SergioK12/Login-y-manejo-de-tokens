import 'package:crud_servicos/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/views.dart';

void main() => runApp(const AppState());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Validacion de formularios',
      initialRoute: 'home',
      routes: {
        'login': (context) => const LoginView(),
        'home': (context) => const HomeView(),
        'product': (context) => const ProductsView(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.indigo,
            elevation: 0,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo,
            elevation: 0,
          )),
    );
  }
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProductsServices())

      ],
      child: const MyApp(),
    );
  }
}

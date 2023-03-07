import 'package:flutter/material.dart';
import 'package:validacion_de_formularios/views/views.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Validacion de formularios',
     initialRoute: 'login',
     routes: {
      'login':(context) => const LoginView(),
      'home':(context) => const HomeView()
     },
    );
  }
}
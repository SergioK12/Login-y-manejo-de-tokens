import 'package:crud_servicos/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: authprovider.readToken(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Espere");
                }
                Future.microtask(() {
                  Navigator.of(context).pushReplacementNamed('home');
                },);

                return Container();
              })),
    );
  }
}

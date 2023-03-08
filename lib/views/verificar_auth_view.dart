import 'package:crud_servicos/services/services.dart';
import 'package:crud_servicos/views/home_view.dart';
import 'package:crud_servicos/views/login_view.dart';
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
                if (snapshot.data == '') {
                  Future.microtask(
                    () {
                      //Navigator.of(context).pushReplacementNamed('login');
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const LoginView(),
                              transitionDuration: const Duration(seconds: 0)));
                    },
                  );
                }
                else{
                  Future.microtask(
                  () {
                    //Navigator.of(context).pushReplacementNamed('login');
                    Navigator.pushReplacement(
                        context, PageRouteBuilder(
                          pageBuilder: (_,__,___ ) => const HomeView(),
                          transitionDuration: const Duration(seconds: 0)
                          
                        )
                      );
                  },
                );

                }

                return Container();
              })),
    );
  }
}

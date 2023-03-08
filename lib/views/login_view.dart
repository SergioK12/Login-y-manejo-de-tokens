import 'package:crud_servicos/ui/inputdecorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/loginformprovider.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.30),
              ),
              CardContainer(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Iniciar sesión",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const _LoginForm(),
                  )
                ],
              )),
              const SizedBox(height: 30),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.grey[100]),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
                child: const Text(
                  "Crear una cuenta nueva",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'registro');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginform = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginform.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hinText: "Sergio@test.com",
                  labeltextt: "Correo electrónico",
                  prefixIcon: Icons.alternate_email_outlined),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : "El correo es incorrecto";
              },
              onChanged: (value) => loginform.email = value,
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hinText: "*********",
                  labeltextt: "Contraseña",
                  prefixIcon: Icons.lock_outline),
              validator: (value) {
                return (value != null && value.length > 6)
                    ? null
                    : "Minimo 6 caracteres";
              },
              onChanged: (value) => loginform.contra = value,
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.purple,
              onPressed: loginform.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authservice =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginform.isValidForm()) return;

                      loginform.isLoading = true;
                      final String? mensajeError = await authservice.login(
                          loginform.email, loginform.contra);
                          
                      if (mensajeError == null) {
                        Future(() =>
                            Navigator.pushReplacementNamed(context, 'home'));
                      } else {
                        debugPrint(mensajeError);
                        loginform.isLoading = false;
                        NotificationsService.showSnackbar(mensajeError);
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  (loginform.isLoading) ? "Cargando" : "Ingresar",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}

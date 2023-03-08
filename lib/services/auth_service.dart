import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDXnx9OXX7AkwJIFmprqVk3iBko_qt5LA0';

  Future<String?> crearusuario(String correo, String contra) async {
    final Map<String, dynamic> authData = {'correo': correo, 'email': correo};

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);
  }
}

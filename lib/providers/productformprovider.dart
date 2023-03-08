import 'package:crud_servicos/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Producto producto;

  ProductFormProvider(this.producto);

  actualizardisponibilidad(bool value) {
    producto.disponibilidad = value;
    notifyListeners();
  }

  bool isValidForm() {
    debugPrint(producto.nombre);
    debugPrint(producto.precio.toString());
    debugPrint(producto.disponibilidad.toString());
    return formkey.currentState?.validate() ?? false;
  }
}

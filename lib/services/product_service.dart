import 'dart:convert';
import 'dart:io';

import 'package:crud_servicos/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-d1097-default-rtdb.firebaseio.com';
  bool isLoading = true;
  bool isSaving = false;
  Producto? selectedProduct;
  File? newPicture;

  final List<Producto> listadeproductos = [];

  ProductsServices() {
    loadProducts();
  }

  Future<List<Producto>> loadProducts() async {
    notifyListeners();
    final url = Uri.https(_baseUrl, 'Productos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final productoTemporal = Producto.fromMap(value);
      productoTemporal.id = key;
      listadeproductos.add(productoTemporal);
    });

    isLoading = false;
    notifyListeners();

    return listadeproductos;
  }

  Future guardarOCrearProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      await crearProducto(producto);
    } else {
      actualizarProducto(producto);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> actualizarProducto(Producto productoaActualizar) async {
    final url = Uri.https(_baseUrl, 'Productos/${productoaActualizar.id}.json');
    final resp = await http.put(url, body: productoaActualizar.toJson());
    final decodeData = resp.body;
    debugPrint(decodeData);

    final indice = listadeproductos
        .indexWhere((element) => element.id == productoaActualizar.id);

    listadeproductos[indice] = productoaActualizar;
    notifyListeners();
    return productoaActualizar.id!;
  }

  Future<String> crearProducto(Producto productoNuevo) async {
    final url = Uri.https(_baseUrl, 'Productos.json');
    final resp = await http.post(url, body: productoNuevo.toJson());
    final decodeData = json.decode(resp.body);
    //debugPrint(decodeData);

    productoNuevo.id = decodeData['name'];

    listadeproductos.add(productoNuevo);
    return productoNuevo.id!;
    //return 'ok';
  }

  void updateSelectedProduct(String path) {
    selectedProduct!.imagen = path;
    newPicture = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPicture == null) return null;

    isSaving = true;
    notifyListeners();
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dmllxc39m/image/upload?upload_preset=dopjxkww');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPicture!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode == 201) {
      return null;
    }
    newPicture = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}

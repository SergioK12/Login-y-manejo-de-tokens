import 'package:crud_servicos/services/services.dart';
import 'package:crud_servicos/widgets/widgets.dart';
import 'package:crud_servicos/views/views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductsServices>(context);
    if (productprovider.isLoading == true) return const LoadingView();
    final lista = productprovider.listadeproductos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.height * 0.02)),
                child: GestureDetector(
                  child: ProductCard(producto: lista[index]),
                  onTap: () {
                    productprovider.selectedProduct = lista[index].copy();
                    Navigator.pushNamed(context, 'product');
                  },
                ),
              )),
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {
            productprovider.selectedProduct = Producto(
              disponibilidad: true,
              nombre: ' ',
              precio: 0.0);
            Navigator.pushNamed(context, 'product');
          }),
    );
  }
}

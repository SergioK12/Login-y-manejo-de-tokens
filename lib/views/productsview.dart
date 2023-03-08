import 'package:crud_servicos/providers/productformprovider.dart';
import 'package:crud_servicos/services/services.dart';
import 'package:crud_servicos/ui/inputdecorations.dart';
import 'package:crud_servicos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final productservice = Provider.of<ProductsServices>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productservice.selectedProduct!),
      child: _ProductScreenBody(productservice: productservice),
    );
    //return _ProductScreenBody(productservice: productservice);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    required this.productservice,
  });

  final ProductsServices productservice;

  @override
  Widget build(BuildContext context) {
    final formprovider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      //appBar: AppBar(title: const Text("ProductosView"),),
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(imagenurl: productservice.selectedProduct?.imagen),
                Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (photo == null) {
                          debugPrint("No hay foto");
                          return;
                        }

                        debugPrint("Tenemos imagen ${photo.path}");
                        productservice.updateSelectedProduct(photo.path);
                      },
                    )),
              ],
            ),
            const _FormularioDelProducto(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: productservice.isSaving
            ? null
            : () async {
                if (!formprovider.isValidForm()) return;

                final String? imageUrl = await productservice.uploadImage();

                if (imageUrl != null) formprovider.producto.imagen = imageUrl;
                
                await productservice.guardarOCrearProducto(formprovider.producto);
                
              },
        child: productservice.isSaving
        ? const CircularProgressIndicator(color: Colors.white)
        : const Icon(Icons.save_as_outlined)
      ),
    );
  }
}

class _FormularioDelProducto extends StatelessWidget {
  const _FormularioDelProducto();

  @override
  Widget build(BuildContext context) {
    final productform = Provider.of<ProductFormProvider>(context);
    final producto = productform.producto;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _buildboxdecoration(),
        width: double.infinity,
        height: 350,
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: productform.formkey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: producto.nombre,
                  decoration: InputDecorations.authInputDecoration(
                      labeltextt: 'Nombre del producto', hinText: 'Nombre:'),
                  onChanged: ((value) => producto.nombre = value),
                  validator: (value) {
                    // value.trim().toString().length < 1
                    if (value == null || value.trim().toString().isEmpty) {
                      return "El campo es obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  initialValue: producto.precio.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      labeltextt: '\$150', hinText: 'Precio:'),
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      producto.precio = 0.0;
                    } else {
                      producto.precio = double.parse(value);
                    }
                  },
                  validator: (value) {
                    // value.trim().toString().length < 1
                    if (value == null || value.trim().toString().isEmpty) {
                      return "El campo es obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SwitchListTile.adaptive(
                    title: const Text("Disponible"),
                    value: producto.disponibilidad,
                    onChanged: (value) {
                      productform.actualizardisponibilidad(value);
                    })
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildboxdecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 5))
        ]);
  }
}

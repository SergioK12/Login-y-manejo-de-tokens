import 'package:crud_servicos/models/models.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Producto producto;
  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardborder(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(producto.imagen),
            _Productdetail(nombre:  producto.nombre,id: producto.id ?? 'Id error'),
            Positioned(
                top: 0, right: 0, child: _PriceTag(producto.precio)),
            Positioned(
                top: 0,
                left: 0,
                child: (producto.disponibilidad == false)
                    ? const _Disponibilidad()
                    : const SizedBox())
          ],
        ),
      ),
    );
  }

  //ClipRRect _backgroundImage() =>

  BoxDecoration _cardborder() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 7)),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? imageurl;
  const _BackgroundImage(this.imageurl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.green,
        child: (imageurl == null)
        ? const Image(image: AssetImage('assets/no-image.png'),fit: BoxFit.cover,)
        : FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(imageurl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Disponibilidad extends StatelessWidget {
  const _Disponibilidad();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "No disponible",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double precio;
  const _PriceTag(this.precio);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '\$$precio',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}

class _Productdetail extends StatelessWidget {
  final String nombre;
  final String id;
  const _Productdetail({required this.nombre, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _boxdecorationProductDetail(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              id,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxdecorationProductDetail() => const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

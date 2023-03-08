import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imagenurl;
  const ProductImage({super.key, this.imagenurl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _decoracion(),
        child:  Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImage(imagenurl)
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoracion() => const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
          ]);
}

Widget getImage (String? foto){

  if(foto == null){
     return const Image(image: AssetImage('assets/no-image.png'),fit: BoxFit.cover);
  }
  if(foto.startsWith('http') ){
    return FadeInImage(
      image: NetworkImage(foto),
      placeholder: const AssetImage('assets/jar-loading.gif'),
      fit: BoxFit.cover,
    );
  }

  return Image.file(
    File(foto),
    fit: BoxFit.cover, 
  );

}

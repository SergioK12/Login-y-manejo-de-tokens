import 'dart:convert';

class Producto {
  Producto({
    required this.disponibilidad,
    this.imagen,
    required this.nombre,
    required this.precio,
    this.id,
  });

  bool disponibilidad;
  String? imagen;
  String nombre;
  double precio;
  String? id;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        disponibilidad: json["Disponibilidad"],
        imagen: json["Imagen"],
        nombre: json["Nombre"],
        precio: json["Precio"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "Disponibilidad": disponibilidad,
        "Imagen": imagen,
        "Nombre": nombre,
        "Precio": precio,
      };

  Producto copy() =>
      Producto(
        disponibilidad: disponibilidad,
        imagen: imagen,
        nombre: nombre, 
        precio: precio,
        id: id,
      );
}

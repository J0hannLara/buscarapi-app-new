import '../../domain/entities/favoritos.dart';

class FavoritoDto extends Favorito {
  FavoritoDto({
    required super.id,
    required super.nombre,
    required super.descripcion,
    super.imagen,
  });

  factory FavoritoDto.fromJson(Map<String, dynamic> json) {
    return FavoritoDto(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'],
    );
  }
}

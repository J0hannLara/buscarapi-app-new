// features/negocios/data/models/categoria_dto.dart
import '../../domain/entities/categoria.dart';

class CategoriaDto extends Categoria {
  CategoriaDto({
    required super.id,
    required super.nombre,
    super.descripcion,
  });

  factory CategoriaDto.fromJson(Map<String, dynamic> json) {
    return CategoriaDto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}

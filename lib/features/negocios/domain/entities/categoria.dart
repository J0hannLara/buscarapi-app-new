// features/negocios/domain/entities/categoria.dart
class Categoria {
  final int id;
  final String nombre;
  final String? descripcion;

  Categoria({required this.id, required this.nombre, this.descripcion});
}

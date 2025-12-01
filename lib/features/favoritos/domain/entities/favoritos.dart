class Favorito {
  final int id;
  final String nombre;
  final String descripcion;
  final String? imagen;

  Favorito({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.imagen,
  });
}

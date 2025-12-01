import 'dart:io';
import 'package:flutter/material.dart';
import '../domain/entities/categoria.dart';
import '../domain/entities/empleado_negocio.dart';

class NegocioProvider extends ChangeNotifier {
  String nombre = '';
  String descripcion = '';
  File? imagen;
  int userId = 0;
  List<Categoria> categoriasSeleccionadas = [];
  List<EmpleadoNegocio> empleados = [];
  String celularSucursal = '';
  String ubicacionSucursal = '';
  double? latitudSucursal;
  double? longitudSucursal;

  void setCoordenadasSucursal(double lat, double lng) {
    latitudSucursal = lat;
    longitudSucursal = lng;
    notifyListeners();
  }

  void setSucursal(String celular, String ubicacion) {
    celularSucursal = celular;
    ubicacionSucursal = ubicacion;
    notifyListeners();
  }

  void agregarEmpleado(EmpleadoNegocio empleado) {
    empleados.add(empleado);
    notifyListeners();
  }

  void eliminarEmpleado(int idUsuario) {
    empleados.removeWhere((e) => e.idUsuario == idUsuario);
    notifyListeners();
  }

  void setDatosNegocio(
    String nombre,
    String descripcion,
    File? imagen,
    int userId,
  ) {
    this.nombre = nombre;
    this.descripcion = descripcion;
    this.imagen = imagen;
    this.userId = userId;
    notifyListeners();
  }

  void setCategorias(List<Categoria> categorias) {
    categoriasSeleccionadas = categorias;
    notifyListeners();
  }

  void limpiar() {
    nombre = '';
    descripcion = '';
    imagen = null;
    userId = 0;
    categoriasSeleccionadas = [];
    empleados = [];
    celularSucursal = '';
    ubicacionSucursal = '';
    notifyListeners();
  }
}

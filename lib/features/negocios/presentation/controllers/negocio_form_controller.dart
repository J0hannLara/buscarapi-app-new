import 'dart:io';
import 'package:flutter/material.dart';

class NegocioFormController extends ChangeNotifier {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  File? selectedImage;
  String? errorMessage;
  bool isLoading = false;

  void setImage(File file) {
    selectedImage = file;
    notifyListeners();
  }

  void setError(String? message) {
    errorMessage = message;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void disposeControllers() {
    nombreController.dispose();
    descripcionController.dispose();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class NegocioImagePicker extends StatelessWidget {
  final File? selectedImage;
  final Function(File) onImageSelected;

  const NegocioImagePicker({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final tempDir = await getTemporaryDirectory();
    final compressedPath =
        '${tempDir.path}/negocio_${DateTime.now().millisecondsSinceEpoch}.webp';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      pickedFile.path,
      compressedPath,
      format: CompressFormat.webp,
      quality: 80,
    );

    if (compressedFile != null) {
      onImageSelected(File(compressedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage(context),
          icon: const Icon(Icons.image),
          label: const Text("Seleccionar Imagen"),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.primary,
          ),
        ),
        if (selectedImage != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                selectedImage!,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}

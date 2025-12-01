import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'dart:typed_data'; // Necesario para Uint8List

class NfcWriteController extends ChangeNotifier {
  bool isWriting = false;
  String statusMessage = 'Acerca el dispositivo al NFC...';

  Future<void> startNFCWrite(int negocioId) async {
    if (!await NfcManager.instance.isAvailable()) {
      statusMessage = "NFC no disponible en este dispositivo.";
      notifyListeners();
      return;
    }

    NfcManager.instance.startSession(
      pollingOptions: {
        NfcPollingOption.iso14443,
        NfcPollingOption.iso15693,
        NfcPollingOption.iso18092,
      },
      onDiscovered: (NfcTag tag) async {
        try {
          isWriting = true;
          statusMessage = "Escribiendo en la etiqueta...";
          notifyListeners();

          final ndef = Ndef.from(tag);
          if (ndef == null || !ndef.isWritable) {
            statusMessage = "Esta etiqueta no se puede escribir.";
            notifyListeners();
            NfcManager.instance.stopSession();
            return;
          }

          final customUrl = 'buscarapi://negocio/$negocioId';

          // Crear registro URI manualmente
          final uriRecord = _createUriRecord(customUrl);

          // Crear el mensaje NDEF
          final message = NdefMessage(records: [uriRecord]);

          // Escribir el mensaje
          await ndef.write(message: message);

          statusMessage = "✅ Negocio registrado exitosamente en la etiqueta NFC.";
          isWriting = false;
          notifyListeners();

          NfcManager.instance.stopSession();
        } catch (e) {
          statusMessage = "❌ Error al escribir: $e";
          isWriting = false;
          notifyListeners();
          NfcManager.instance.stopSession();
        }
      },
    );
  }

  // Método auxiliar para crear un registro URI
  NdefRecord _createUriRecord(String uriString) {
    // El código de identificación para URI (0x01 para http://, etc.)
    // Para URI personalizados, usamos 0x00 (no definido) y ponemos la URI completa
    final uri = Uri.parse(uriString);
    
    // Convertir la URI a bytes UTF-8
    final uriBytes = Uint8List.fromList(uri.toString().codeUnits);
    
    // El tipo para registros URI es "U" en ASCII
    final type = Uint8List.fromList([0x55]); // 'U' en ASCII
    
    // Para registros URI, el payload comienza con el código de identificación
    // Usamos 0x00 para URI no definidas/personalizadas
    final payload = Uint8List(1 + uriBytes.length);
    payload[0] = 0x00; // Código de identificación para URI no definidas
    payload.setRange(1, payload.length, uriBytes);

    return NdefRecord(
      typeNameFormat: TypeNameFormat.wellKnown,
      type: type,
      identifier: Uint8List(0), // Identificador vacío
      payload: payload,
    );
  }

  void stopSession() {
    NfcManager.instance.stopSession();
  }
}
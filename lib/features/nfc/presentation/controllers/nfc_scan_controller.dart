import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:nfc_manager/ndef_record.dart';
import '../../../../core/constants/endpoints.dart';
import '../../../negocios/presentation/pages/negocio_detail_page.dart';

class NFCScanController extends ChangeNotifier {
  String statusMessage = 'Acerca tu dispositivo a una etiqueta NFC...';
  bool isScanning = false;

  Future<void> startNFCScan(BuildContext context) async {
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
          final ndef = Ndef.from(tag);
          if (ndef == null) {
            statusMessage = "❌ Esta etiqueta no contiene información válida.";
            notifyListeners();
            NfcManager.instance.stopSession(); // errorMessage eliminado
            return;
          }

          final cachedMessage = ndef.cachedMessage;
          if (cachedMessage == null || cachedMessage.records.isEmpty) {
            statusMessage = "❌ No se encontró ningún dato en la etiqueta.";
            notifyListeners();
            NfcManager.instance.stopSession(); // errorMessage eliminado
            return;
          }

          final record = cachedMessage.records.first;
          int? negocioId;

          // Corrección: Usar TypeNameFormat en lugar de NdefTypeNameFormat
          if (record.typeNameFormat == TypeNameFormat.wellKnown && // Cambiado aquí
              record.type.isNotEmpty &&
              record.type[0] == 0x55) { // 'U' en ASCII
            final uriPrefixCode = record.payload.isNotEmpty ? record.payload[0] : 0;
            final uriSuffix = utf8.decode(record.payload.sublist(1));
            final prefix = _getUriPrefix(uriPrefixCode);
            final text = '$prefix$uriSuffix';

            final uri = Uri.tryParse(text);
            if (uri != null &&
                uri.scheme == 'buscarapi' &&
                uri.host == 'negocio' &&
                uri.pathSegments.isNotEmpty) {
              negocioId = int.tryParse(uri.pathSegments[0]);
            }
          }

          if (negocioId == null || negocioId == 0) {
            statusMessage = "❌ El ID de negocio no es válido.";
            notifyListeners();
            NfcManager.instance.stopSession(); // errorMessage eliminado
            return;
          }

          statusMessage = "🔎 Buscando negocio...";
          isScanning = true;
          notifyListeners();

          final response = await http.get(
            Uri.parse('${Endpoints.baseUrl}/api/negocio/$negocioId'),
          );

          if (response.statusCode == 200) {
            final prefs = await SharedPreferences.getInstance();
            final userId = prefs.getInt('userId') ?? 0;

            await http.post(
              Uri.parse('${Endpoints.baseUrl}/api/interacciones'),
              body: {
                'tipo': 'like',
                'modelo': 'Negocio',
                'id_modelo': negocioId.toString(),
                'id_usuario': userId.toString(),
              },
            );

            NfcManager.instance.stopSession();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => NegocioDetailPage(negocioId: negocioId!),
              ),
            );
          } else {
            statusMessage = "❌ No se encontró el negocio.";
            notifyListeners();
            NfcManager.instance.stopSession(); // errorMessage eliminado
          }
        } catch (e) {
          statusMessage = "❌ Error al leer: $e";
          notifyListeners();
          NfcManager.instance.stopSession(); // errorMessage eliminado
        }
      },
    );
  }

  String _getUriPrefix(int code) {
    const uriPrefixes = [
      '', 'http://www.', 'https://www.', 'http://', 'https://',
      'tel:', 'mailto:', 'ftp://anonymous:anonymous@', 'ftp://ftp.', 'ftps://',
      'sftp://', 'smb://', 'nfs://', 'ftp://', 'dav://', 'news:',
      'telnet://', 'imap:', 'rtsp://', 'urn:', 'pop:', 'sip:',
      'sips:', 'tftp:', 'btspp://', 'btl2cap://', 'btgoep://', 'tcpobex://',
      'irdaobex://', 'file://', 'urn:epc:id:', 'urn:epc:tag:', 'urn:epc:pat:',
      'urn:epc:raw:', 'urn:epc:', 'urn:nfc:'
    ];

    return (code >= 0 && code < uriPrefixes.length) ? uriPrefixes[code] : '';
  }

  void disposeController() {
    NfcManager.instance.stopSession();
  }
}
// features/qr/data/qr_scanner_service.dart

class QrScannerService {
  static int? extractNegocioId(String rawValue) {
    if (rawValue.startsWith('buscarapi://negocio/')) {
      return int.tryParse(rawValue.split('/').last);
    }
    return null;
  }
}

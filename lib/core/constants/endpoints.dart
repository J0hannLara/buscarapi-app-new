import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static String get baseUrl {
    final env = dotenv.env['ENV'] ?? 'dev';

    switch (env) {
      case 'staging':
        return dotenv.env['BASE_URL_STAGING'] ?? '';
      case 'prod':
        return dotenv.env['BASE_URL_PROD'] ?? '';
      case 'dev':
      default:
        return dotenv.env['BASE_URL_DEV'] ?? '';
    }
  }

  // 👇 Endpoints específicos
  static String get login => '$baseUrl/api/login';
  static String get register => '$baseUrl/api/register';
  static String get negocios => '$baseUrl/api/negocios';

  static final mapTileUrl = dotenv.env['MAP_TILE_URL']!;
}

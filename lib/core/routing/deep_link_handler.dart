import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class DeepLinkHandler {
  final AppLinks _appLinks = AppLinks();
  final GlobalKey<NavigatorState> navigatorKey;

  DeepLinkHandler(this.navigatorKey);

  Future<void> init() async {
    // Cuando la app ya está abierta
    _appLinks.uriLinkStream.listen((Uri? uri) {
      _handleIncomingLink(uri);
    });

    // Cuando abre desde un link inicial
    final initialLink = await _appLinks.getInitialAppLink();
    if (initialLink != null) {
      _handleIncomingLink(initialLink);
    }
  }

  void _handleIncomingLink(Uri? uri) {
    if (uri != null && uri.scheme == 'buscarapi' && uri.host == 'negocio') {
      final idStr = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
      final negocioId = int.tryParse(idStr ?? '');
      if (negocioId != null) {
        navigatorKey.currentState?.pushNamed('/negocio/$negocioId');
      }
    }
  }
}

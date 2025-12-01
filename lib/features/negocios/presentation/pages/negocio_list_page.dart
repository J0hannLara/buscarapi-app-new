import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/datasources/negocio_remote_ds.dart';
import '../controllers/negocio_list_controller.dart';
import '../widgets/negocio_card.dart';
import '../../../nfc/presentation/pages/nfc_write_page.dart';
import '../../../qr/presentation/pages/qr_generate_page.dart';
import 'negocio_detail_page.dart';
import 'negocio_form_page.dart';

class NegocioListPage extends StatelessWidget {
  final bool seleccionandoParaNFC;
  final bool seleccionandoParaQR;

  const NegocioListPage({
    super.key,
    this.seleccionandoParaNFC = false,
    this.seleccionandoParaQR = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NegocioListController(NegocioRemoteDataSource())..loadNegocios(),
      child: Consumer<NegocioListController>(
        builder: (context, controller, _) {
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;
          final textTheme = theme.textTheme;

          return Scaffold(
            appBar: AppBar(
              title: Text('Mis negocios', style: TextStyle(color: colorScheme.secondary)),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            backgroundColor: colorScheme.background,
            body: RefreshIndicator(
              onRefresh: controller.loadNegocios,
              color: colorScheme.primary,
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : controller.negocios.isEmpty
                      ? Center(
                          child: Text(
                            "No tienes negocios registrados.",
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onBackground,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.negocios.length,
                          itemBuilder: (context, index) {
                            final negocio = controller.negocios[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: NegocioCard(
                                negocio: negocio,
                                onTap: () {
                                  if (seleccionandoParaNFC) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => NfcWritePage(
                                          negocioId: negocio.id,
                                          negocioNombre: negocio.nombre,
                                        ),
                                      ),
                                    );
                                  } else if (seleccionandoParaQR) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => QRGeneratePage(
                                          negocioId: negocio.id,
                                          negocioNombre: negocio.nombre,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => NegocioDetailPage(
                                          negocioId: negocio.id,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NegocioFormPage()),
                );
              },
              child: const Icon(Icons.add, size: 28),
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 8,
            ),
          );
        },
      ),
    );
  }
}

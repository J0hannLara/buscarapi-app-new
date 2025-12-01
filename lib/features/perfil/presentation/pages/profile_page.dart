import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Controllers
import '../controllers/perfil_controller.dart';

// Rutas internas
import '../../../auth/presentation/pages/login_page.dart';
import '../../../negocios/presentation/pages/negocio_list_page.dart';
import '../../../nfc/presentation/pages/nfc_options_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = PerfilController();
        controller.loadUserData();
        return controller;
      },
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PerfilController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Avatar y datos del usuario
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.primary,
                      child: Icon(Icons.person,
                          size: 50, color: colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.nombre,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      controller.celular,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      "ID: ${controller.userId}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Opciones de Perfil
              _buildProfileOption(context, Icons.person, "Editar Perfil"),
              _buildProfileOption(context, Icons.settings, "Configuración"),
              _buildProfileOption(
                context,
                Icons.store,
                "Negocios",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NegocioListPage()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                Icons.nfc,
                "NFC/QR",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NFCOptionsPage()),
                  );
                },
              ),

              const SizedBox(height: 40),

              // 🔹 Botón de Cerrar Sesión
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await controller.logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.logout, color: colorScheme.secondary),
                  label: Text(
                    "Cerrar Sesión",
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String text,
      {VoidCallback? onTap}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.secondary, size: 28),
        title: Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: colorScheme.secondary.withOpacity(0.5), size: 18),
        onTap: onTap,
      ),
    );
  }
}

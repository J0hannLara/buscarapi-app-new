import 'package:flutter/material.dart';
import '../controllers/register_controller.dart';
import '../widgets/register_fields.dart';
import '../../data/datasources/auth_remote_ds.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RegisterController(AuthRemoteDataSource());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    final theme = Theme.of(context);
    final nombres = _controller.nombresController.text;
    final apellidos = _controller.apellidosController.text;
    final celular = _controller.celularController.text;

    if (nombres.isEmpty || apellidos.isEmpty || celular.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    setState(() {}); // refrescar el loading

    final success = await _controller.register();

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado correctamente.')),
        );
        Navigator.pushNamed(context, '/login');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar el usuario')),
        );
      }
    }

    setState(() {}); // refrescar el loading
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'BuscaRapi',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Crear Cuenta',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 30),
            RegisterTextField(
              controller: _controller.nombresController,
              label: 'Nombres',
              hint: 'Ingrese sus nombres',
              icon: Icons.person,
            ),
            const SizedBox(height: 15),
            RegisterTextField(
              controller: _controller.apellidosController,
              label: 'Apellidos',
              hint: 'Ingrese sus apellidos',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 15),
            _buildPhoneField(theme),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _controller.isLoading ? null : _onRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _controller.isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.onPrimary,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Registrarse'),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(
                    color: theme.colorScheme.onSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Número de Teléfono',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.colorScheme.onSurface),
              ),
              child: Row(
                children: [
                  Image.asset('assets/img/bolivia_flag.png', width: 24, height: 24),
                  const SizedBox(width: 10),
                  Text(
                    '+591',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegisterTextField(
                controller: _controller.celularController,
                label: '',
                hint: 'Ingrese su número',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

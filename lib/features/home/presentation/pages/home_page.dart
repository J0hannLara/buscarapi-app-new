import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import '../widgets/item_card.dart';
import '../../../../core/presentation/widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildHorizontalList(BuildContext context, List items, String tipo) {
    if (items.isEmpty) {
      return Center(
        child: Text('No hay $tipo disponibles', style: Theme.of(context).textTheme.bodyLarge),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) => ItemCard(item: item, tipo: tipo)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..loadData(),
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: RefreshIndicator(
              onRefresh: controller.loadData,
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const SearchBarWidget(),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("Negocios Destacados", style: Theme.of(context).textTheme.titleMedium),
                          ),
                          _buildHorizontalList(context, controller.negocios, 'negocios'),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("Productos Destacados", style: Theme.of(context).textTheme.titleMedium),
                          ),
                          _buildHorizontalList(context, controller.productos, 'productos'),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("Servicios Destacados", style: Theme.of(context).textTheme.titleMedium),
                          ),
                          _buildHorizontalList(context, controller.servicios, 'servicios'),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
